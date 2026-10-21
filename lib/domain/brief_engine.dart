import 'package:eva_ai/domain/care_plans.dart';
import 'package:eva_ai/domain/cycle_engine.dart';
import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

const sampleNight = WearableNight(
  sleep: '7h 42m',
  hrv: '54 ms',
  restingHeart: '58 bpm',
  temperature: '+0.12°',
);

String greetingFor(Daypart part) {
  switch (part) {
    case Daypart.night:
      return 'Still with you';
    case Daypart.morning:
      return 'Good morning';
    case Daypart.afternoon:
      return 'Good afternoon';
    case Daypart.evening:
      return 'Good evening';
  }
}

String _energyLine(double delta, Daypart part, {required bool cycleLed}) {
  if (!cycleLed) {
    return 'No energy estimate yet. EVA will not invent one from a missing period date.';
  }
  if (delta > 0.05) {
    return part == Daypart.night
        ? 'The phase table marks this as a higher-energy part of a cycle. It is not a measurement, including after sleep.'
        : 'The phase table marks this as a higher-energy part of a cycle. It is not a measurement.';
  }
  if (delta < -0.05) {
    return 'The phase table marks this as a lower-energy part of a cycle. It is not a measurement.';
  }
  return 'The phase table does not mark a strong shift here. It is not a measurement.';
}

List<String> _recommendations({
  required Daypart part,
  required CyclePhase phase,
  required String focus,
  required bool pregnant,
  required bool dated,
}) {
  if (pregnant || focus == 'pregnancy') {
    if (part == Daypart.night) {
      return ['Protect sleep', 'Note one question for your visit', 'Leave training for tomorrow'];
    }
    return ['A protein-and-folate plate', 'Walk only if it feels good', 'Note one question for your clinician'];
  }
  if (focus == 'menopause') {
    if (part == Daypart.night || part == Daypart.evening) {
      return ['Cool the room', 'Keep tomorrow\'s wake time steady', 'Leave caffeine for the morning'];
    }
    return ['Strength for bone and mood', 'Keep a cooler layer nearby', 'Protein at the first meal'];
  }
  if (focus == 'mental' && part != Daypart.night) {
    return ['Daylight within an hour of waking', 'Name one feeling without fixing it', 'Keep caffeine earlier'];
  }
  if (focus == 'pcos' && part != Daypart.night) {
    return ['Strength training', 'Protein at breakfast', 'A consistent bedtime'];
  }
  if (!dated) {
    if (part == Daypart.night) {
      return ['Protect sleep', 'Dim the room', 'Leave training for morning'];
    }
    return ['Save a period date before expecting a cycle estimate', 'Log only what happened', 'A clinician for medical decisions'];
  }
  if (part == Daypart.night) {
    return ['Protect sleep', 'Dim the room', 'Leave training for morning'];
  }
  if (part == Daypart.evening) {
    return ['Begin winding down', 'A balanced dinner', 'Leave intensity for tomorrow'];
  }
  if (phase == CyclePhase.lateFollicular || phase == CyclePhase.ovulatory) {
    return ['Strength training', 'Higher protein intake', 'Hydration focus'];
  }
  if (phase == CyclePhase.menstrual) {
    return ['A gentle walk if you want one', 'An iron-aware meal', 'Heat for cramps if it helps'];
  }
  if (phase == CyclePhase.lateLuteal) {
    return ['Keep the workout familiar', 'A satisfying meal', 'An earlier bedtime'];
  }
  return ['Familiar strength work', 'Protein at each meal', 'Hydration focus'];
}

List<Whisper> _whispers({
  required HealthProfile profile,
  required DateTime now,
  required Daypart part,
  required CycleSnapshot cycle,
  required bool cycleLed,
}) {
  final stamp = isoDay(now);
  final items = <Whisper>[];
  void add(String key, String message) {
    final id = '$stamp-$key';
    if (profile.dismissed.contains(id)) return;
    items.add(Whisper(id: id, message: message));
  }

  final daysUntil = calendarDaysBetween(now, cycle.nextPeriod);
  if (cycleLed && daysUntil <= 2) {
    add('period', 'The calendar estimate falls within 2 days of a period. It is not a confirmed start.');
  }
  if (part == Daypart.night || part == Daypart.evening || (cycleLed && sleepImpact(cycle.phase) == 'High')) {
    add(
      'bed',
      cycleLed && cycle.phase == CyclePhase.lateLuteal
          ? 'A textbook late luteal stretch is often described with lighter sleep. That is a model, not a reading from a ring.'
          : 'An earlier bedtime is a general suggestion, not a reading of your sleep.',
    );
  }
  if (cycleLed &&
      (part == Daypart.morning || part == Daypart.afternoon) &&
      (cycle.phase == CyclePhase.lateFollicular || cycle.phase == CyclePhase.ovulatory)) {
    add('energy', 'This part of a typical cycle is often higher energy. EVA does not know your afternoon.');
  }
  if (part != Daypart.night) {
    add('water', 'Hydration recommended.');
  }
  if (items.length > 2) return items.sublist(0, 2);
  return items;
}

List<HealthNote> _notes(HealthProfile profile, DateTime now) {
  final notes = <HealthNote>[];
  final today = profile.logOn(isoDay(now));
  if (today != null && today.flow >= 3) {
    notes.add(const HealthNote(
      title: 'Heavy bleeding',
      body: 'Soaking through protection every hour, or bleeding with faintness, is a reason to seek urgent care. EVA is only flagging the note you logged.',
      urgent: true,
    ));
  }

  var lateHeadaches = 0;
  var lowMood = 0;
  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null) continue;
    final phase = projectCycle(profile, day).phase;
    if (profile.timingConfirmed && log.symptoms.contains('headache') && phase == CyclePhase.lateLuteal) {
      lateHeadaches += 1;
    }
    if (log.mood == 'low' || log.mood == 'frayed') lowMood += 1;
  }
  if (lateHeadaches >= 3) {
    notes.add(const HealthNote(
      title: 'A headache pattern',
      body: 'Headaches have shown up on several late-luteal days. That is a useful note for a clinician. It is not a diagnosis.',
    ));
  }
  if (lowMood >= 3) {
    notes.add(const HealthNote(
      title: 'Mood has been heavy',
      body: 'A few logs in a row have been low or frayed. If that is more than a hard week, a clinician or someone you trust can help. If you might act on thoughts of suicide, call local emergency services. In the US or Canada, call or text 988.',
    ));
  }
  if (!profile.regular || profile.contexts.contains('pcos') || profile.contexts.contains('irregular')) {
    notes.add(const HealthNote(
      title: 'Calendar limits',
      body: 'Irregular cycles make ovulation dates uncertain. EVA will keep the confidence modest and avoid pretending the math is a hormone test.',
    ));
  }
  return notes;
}

List<Signal> _signals({
  required HealthProfile profile,
  required CycleSnapshot cycle,
  required PregnancyStory? pregnancy,
  required bool menopause,
  required DateTime now,
}) {
  if (pregnancy != null && profile.pregnant) {
    final kicks = profile.kicksDay == isoDay(now) ? profile.kicks : 0;
    return [
      Signal(
        label: 'Gestation',
        value: 'Week ${pregnancy.week}',
        caption: 'Day ${pregnancy.extraDays}',
        detail: 'This count starts at the last menstrual period. Ultrasound dating from a clinician replaces it.',
      ),
      Signal(
        label: 'Size metaphor',
        value: pregnancy.size,
        caption: 'Teaching image',
        detail: 'Size comparisons are memory aids. They are not a measurement of this pregnancy.',
      ),
      Signal(
        label: 'Kicks today',
        value: '$kicks',
        caption: 'Your notes',
        detail: 'This is a personal tally. If a clinician taught you a kick-count protocol, use theirs. A baby who is much quieter than usual is a same-day call.',
      ),
      Signal(
        label: 'Due estimate',
        value: prettyDay(pregnancy.due),
        caption: 'Not a deadline',
        detail: 'A due date is a 40-week estimate from the last menstrual period. Plenty of healthy births land on either side.',
      ),
    ];
  }

  if (menopause) {
    final todayFlashes = profile.hotFlashes.where((flash) => flash.at.startsWith(isoDay(now))).length;
    final mood = profile.logOn(isoDay(now))?.mood;
    return [
      Signal(
        label: 'Hot flashes',
        value: todayFlashes == 0 ? 'None' : '$todayFlashes',
        caption: 'Logged today',
        detail: 'A tally helps you see triggers such as wine, heat, or a short night. It does not decide whether hormone therapy is right for you.',
      ),
      Signal(
        label: 'Sleep',
        value: profile.wearableSample ? sampleNight.sleep : 'Unlogged',
        caption: profile.wearableSample ? 'Ring preview' : 'Add a night',
        detail: 'Sleep is the signal menopause care returns to. A preview night is sample data until a real ring or watch is connected.',
      ),
      Signal(
        label: 'Mood',
        value: mood == null || mood.isEmpty ? 'Unlogged' : mood,
        caption: 'Today',
        detail: 'Mood shifts can follow sleep and heat. EVA will not label them as a psychiatric diagnosis.',
      ),
      const Signal(
        label: 'Hormone sketch',
        value: 'Background',
        caption: 'Not a lab',
        detail: 'The cycle chart steps back in menopause. Trends in sleep, flashes, and mood are the live model.',
      ),
    ];
  }

  final trust = cycleTrust(profile);
  if (!trust.dated) {
    final loggedMood = profile.logOn(isoDay(now))?.mood ?? '';
    return [
      Signal(
        label: loggedMood.isEmpty ? 'Mood' : 'Mood today',
        value: loggedMood.isEmpty ? 'Not enough information yet' : _title(loggedMood),
        caption: loggedMood.isEmpty ? 'Unlogged' : 'What you logged',
        detail: loggedMood.isEmpty ? trust.evidence : 'This is the mood you logged. It is not a diagnosis.',
      ),
      const Signal(
        label: 'Sleep',
        value: 'Not enough information yet',
        caption: 'Unlogged',
        detail: 'No sleep record is being estimated.',
      ),
      Signal(
        label: 'Energy',
        value: 'Not enough information yet',
        caption: 'No score',
        detail: trust.evidence,
      ),
      Signal(
        label: 'Cycle',
        value: trust.label,
        caption: 'No score',
        detail: trust.evidence,
      ),
    ];
  }
  final delta = energyDelta(cycle.phase);
  final energyValue = delta > 0.05 ? 'Higher estimate' : delta < -0.05 ? 'Lower estimate' : 'Steady estimate';
  final loggedMood = profile.logOn(isoDay(now))?.mood ?? '';
  final hasMood = loggedMood.isNotEmpty;
  return [
    Signal(
      label: hasMood ? 'Mood today' : 'Mood forecast',
      value: hasMood ? _title(loggedMood) : moodLabel(cycle.phase),
      caption: hasMood ? 'What you logged' : 'Phase outlook',
      detail: hasMood
          ? 'This is the mood you logged today. The phase outlook steps back until you clear it.'
          : 'A mood forecast is the usual emotional weather of this phase, not a promise about your day.',
    ),
    Signal(
      label: 'Sleep impact',
      value: sleepImpact(cycle.phase),
      caption: 'Phase effect',
      detail: 'Low means this phase is less likely to disturb sleep. It is not a measurement from a ring unless you turn on a wearable preview.',
    ),
    Signal(
      label: 'Energy',
      value: energyValue,
      caption: 'Modeled today',
      detail: 'Higher, steady, or lower comes from a textbook phase table. It is not a reading from your body.',
    ),
    Signal(
      label: 'Cycle',
      value: trust.label,
      caption: 'Evidence',
      detail: trust.evidence,
    ),
  ];
}

DailyBrief buildBrief(HealthProfile profile, DateTime now) {
  final part = daypartOf(now);
  final cycle = projectCycle(profile, now);
  final menopause = profile.focus == 'menopause' || profile.contexts.contains('menopause');
  final pregnant = profile.pregnant;
  final lmp = profile.pregnancyLmp;
  final pregnancy = pregnant && lmp != null ? pregnancyStory(lmp, now) : null;
  final cycleLed = !pregnant && !menopause && profile.timingConfirmed;
  final daysAgo = calendarDaysBetween(profile.lastPeriodStart, now);

  var orbKicker = phaseLabel(cycle.phase);
  var orbValue = 'Day ${cycle.day}';
  var headline = cycle.phase == CyclePhase.lateFollicular
      ? 'Today your body is likely entering the late follicular phase.'
      : cycle.phase == CyclePhase.ovulatory
          ? 'Today your body is likely near ovulation.'
          : 'Today your body is likely in the ${phasePhrase(cycle.phase)}.';

  if (profile.focus == 'fertility' && cycleLed) {
    headline = cycle.fertilityToday > 0.45
        ? 'You are inside the modeled fertile window.'
        : 'The modeled fertile window is nearby, not guaranteed.';
  } else if (profile.focus == 'pcos') {
    headline = 'I am watching symptoms more closely than a perfect calendar.';
  } else if (profile.focus == 'mental' && cycleLed) {
    headline = 'Your cycle and your mood are on the same page today.';
  }

  if (pregnancy != null) {
    orbKicker = 'Week ${pregnancy.week}';
    orbValue = 'Day ${pregnancy.extraDays}';
    headline = pregnancy.headline;
  } else if (menopause) {
    orbKicker = 'Menopause';
    orbValue = 'Focus';
    headline = 'Heat, sleep, and mood are the signals I am watching.';
  } else if (profile.focus == 'pregnancy') {
    orbKicker = 'Pregnancy';
    orbValue = 'Ready';
    headline = 'When a pregnancy is confirmed, this day reshapes around it.';
  } else if (!profile.timingConfirmed) {
    orbKicker = 'Rhythm';
    orbValue = 'Unknown';
    headline = 'Not enough information yet. A cycle day appears after you save a period date.';
  } else if (headline.contains('likely')) {
    headline = 'Estimated from the period date you saved: the ${phasePhrase(cycle.phase)}. Not a measurement.';
  }

  final assumption = pregnant
      ? 'Pregnancy is leading the day. Cycle percentages are paused.'
      : menopause
          ? 'Cycle dates sit in the background while menopause is the focus.'
          : profile.timingConfirmed
              ? 'The saved period date was $daysAgo days ago, in a ${profile.cycleLength}-day rhythm you set. Later dates are estimates.'
              : 'No period date is saved. EVA is not guessing one.';

  return DailyBrief(
    daypart: part,
    greeting: greetingFor(part),
    orbKicker: orbKicker,
    orbValue: orbValue,
    headline: headline,
    energyLine: _energyLine(energyDelta(cycle.phase), part, cycleLed: cycleLed),
    recommendTitle: part == Daypart.night ? 'Recommended now' : 'Recommended today',
    recommendations: _recommendations(
      part: part,
      phase: cycle.phase,
      focus: profile.focus,
      pregnant: pregnant,
      dated: profile.timingConfirmed,
    ),
    signals: _signals(
      profile: profile,
      cycle: cycle,
      pregnancy: pregnancy,
      menopause: menopause,
      now: now,
    ),
    whispers: _whispers(
      profile: profile,
      now: now,
      part: part,
      cycle: cycle,
      cycleLed: cycleLed,
    ),
    assumption: assumption,
    cycle: cycle,
    showCycleChart: cycleLed,
    pregnancy: pregnancy,
    wearable: profile.wearableSample ? sampleNight : null,
    notes: _notes(profile, now),
  );
}

String learnedLine(HealthProfile profile, DateTime now) {
  final phase = projectCycle(profile, now).phase;
  final counts = <String, int>{};
  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null || projectCycle(profile, day).phase != phase) continue;
    for (final symptom in log.symptoms) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  if (counts.isEmpty) {
    return profile.timingConfirmed
        ? 'Tomorrow is already on the calendar. If it feels like today, one tap repeats it.'
        : 'Confirm the first day of bleeding once. After that, the day arrives without a form.';
  }
  final top = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  if (top.first.value < 2) {
    return 'You logged ${top.first.key} once in this phase. A second time is what turns a note into a pattern.';
  }
  return 'In this phase, ${top.first.key} has shown up ${top.first.value} times. That is your pattern, not a diagnosis.';
}

String _title(String value) {
  if (value.isEmpty) return value;
  return value[0].toUpperCase() + value.substring(1);
}

String briefName(Daypart part) {
  switch (part) {
    case Daypart.morning:
      return 'Morning brief';
    case Daypart.afternoon:
      return 'Afternoon brief';
    case Daypart.evening:
      return 'Evening brief';
    case Daypart.night:
      return 'Sleep brief';
  }
}

class DayForecast {
  const DayForecast({
    required this.energy,
    required this.rising,
    required this.mood,
    required this.focus,
    required this.modeled,
  });

  final int energy;
  final bool? rising;
  final String mood;
  final String focus;
  final List<String> modeled;
}

DayForecast dayForecast(HealthProfile profile, DailyBrief brief, DateTime now) {
  final phase = brief.cycle.phase;
  final delta = energyDelta(phase);
  final loggedMood = profile.logOn(isoDay(now))?.mood ?? '';
  return DayForecast(
    energy: ((0.5 + delta) * 100).round().clamp(0, 100),
    rising: delta.abs() < 0.05 ? null : delta > 0,
    mood: loggedMood.isNotEmpty ? _title(loggedMood) : moodLabel(phase),
    focus: switch (phase) {
      CyclePhase.lateFollicular || CyclePhase.ovulatory => 'High',
      CyclePhase.earlyFollicular || CyclePhase.earlyLuteal => 'Steady',
      CyclePhase.menstrual || CyclePhase.lateLuteal => 'Soft',
    },
    modeled: switch (phase) {
      CyclePhase.lateFollicular || CyclePhase.ovulatory => const [
          'High productivity',
          'Lower cravings',
          'Strong workout potential',
        ],
      CyclePhase.lateLuteal => const ['Gentler pace', 'Appetite may rise', 'Protect sleep'],
      CyclePhase.menstrual => const ['Rest counts', 'Warm meals', 'A short walk if you want one'],
      _ => const ['Steady work', 'Regular meals', 'Familiar training'],
    },
  );
}

int profileSignals(HealthProfile profile) {
  var count = 0;
  if (profile.name.trim().isNotEmpty) count += 1;
  if (profile.timingConfirmed) count += 1;
  if (profile.intentions.isNotEmpty) count += 1;
  if (profile.answered.contains('context')) count += 1;
  if (profile.logs.isNotEmpty) count += 1;
  if (profile.chat.isNotEmpty) count += 1;
  if (profile.wearableSample) count += 1;
  return count;
}
