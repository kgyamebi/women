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
    return 'I will follow how you feel, not a cycle percentage.';
  }
  final percent = (delta.abs() * 100).round();
  if (delta >= 0.17 && part == Daypart.night) {
    return 'Energy is expected to rise $percent% after you sleep.';
  }
  if (delta > 0) return 'Energy is expected to rise $percent%.';
  return 'Energy is expected to sit about $percent% lower than your follicular baseline.';
}

List<String> _recommendations({
  required Daypart part,
  required CyclePhase phase,
  required String focus,
  required bool pregnant,
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
    add('period', 'Your period may begin within 48 hours.');
  }
  if (part == Daypart.night || part == Daypart.evening || sleepImpact(cycle.phase) == 'High') {
    add('bed', 'Consider an earlier bedtime tonight.');
  }
  if (cycleLed &&
      (part == Daypart.morning || part == Daypart.afternoon) &&
      (cycle.phase == CyclePhase.lateFollicular || cycle.phase == CyclePhase.ovulatory)) {
    add('energy', 'Your energy may peak this afternoon.');
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
    if (log.symptoms.contains('headache') && phase == CyclePhase.lateLuteal) {
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

  final delta = energyDelta(cycle.phase);
  final energyValue = delta > 0 ? '+${(delta * 100).round()}%' : '${(delta * 100).round()}%';
  final provisional = profile.timingConfirmed ? 'Calendar estimate' : 'Provisional';
  return [
    Signal(
      label: 'Mood forecast',
      value: moodLabel(cycle.phase),
      caption: 'Phase outlook',
      detail: 'A mood forecast is the usual emotional weather of this phase, not a promise about your day. Logged mood always outranks it.',
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
      detail: 'The percentage compares this phase with a lower luteal baseline in a textbook cycle. It is not a reading from your body.',
    ),
    Signal(
      label: 'Cycle confidence',
      value: percentLabel(cycle.confidence),
      caption: provisional,
      detail: 'Calendar confidence is high only when a rhythm is regular and recently anchored. It is not proof of ovulation. A temperature shift or an ovulation test would make it physiological.',
    ),
  ];
}

DailyBrief buildBrief(HealthProfile profile, DateTime now) {
  final part = daypartOf(now);
  final cycle = projectCycle(profile, now);
  final menopause = profile.focus == 'menopause' || profile.contexts.contains('menopause');
  final pregnant = profile.pregnant;
  final lmp = profile.pregnancyLmp ?? profile.lastPeriodStart;
  final pregnancy = pregnant ? pregnancyStory(lmp, now) : null;
  final cycleLed = !pregnant && !menopause;
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
  }

  final assumption = pregnant
      ? 'Pregnancy is leading the day. Cycle percentages are paused.'
      : menopause
          ? 'Cycle dates sit in the background while menopause is the focus.'
          : profile.timingConfirmed
              ? 'Bleeding began $daysAgo days ago, in a ${profile.cycleLength}-day rhythm.'
              : 'I am assuming bleeding began $daysAgo days ago, in a regular ${profile.cycleLength}-day rhythm.';

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
