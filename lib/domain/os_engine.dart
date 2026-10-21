import 'package:eva_ai/domain/care_plans.dart';
import 'package:eva_ai/domain/connect_engine.dart';
import 'package:eva_ai/domain/cycle_engine.dart';
import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

class Horizon {
  const Horizon({
    required this.label,
    required this.day,
    required this.phase,
    required this.energy,
    required this.mood,
    required this.focus,
    required this.sleep,
    required this.cravings,
    required this.skin,
    required this.workout,
    required this.stress,
    required this.symptom,
    required this.event,
  });

  final String label;
  final DateTime day;
  final String phase;
  final String energy;
  final String mood;
  final String focus;
  final String sleep;
  final String cravings;
  final String skin;
  final String workout;
  final String stress;
  final String symptom;
  final String event;
}

class WeekAhead {
  const WeekAhead({required this.days, required this.confidence, required this.note});

  final List<Horizon> days;
  final String confidence;
  final String note;
}

class Recall {
  const Recall({required this.line, required this.fromNotes});

  final String line;
  final bool fromNotes;
}

class WellPart {
  const WellPart({required this.name, required this.score, required this.detail});

  final String name;
  final int? score;
  final String detail;
}

class Wellbeing {
  const Wellbeing({required this.score, required this.parts, required this.caption});

  final int? score;
  final List<WellPart> parts;
  final String caption;
}

class Chapter {
  const Chapter({required this.label, required this.line});

  final String label;
  final String line;
}

class HealthReport {
  const HealthReport({required this.span, required this.lines, required this.shareText});

  final String span;
  final List<String> lines;
  final String shareText;
}

const lifeStages = <(String, String)>[
  ('cycle', 'Cycle'),
  ('teen', 'Teen'),
  ('college', 'College'),
  ('work', 'Work'),
  ('fertility', 'Trying'),
  ('pregnancy', 'Pregnancy'),
  ('postpartum', 'Postpartum'),
  ('pcos', 'PCOS'),
  ('perimenopause', 'Perimenopause'),
  ('menopause', 'Menopause'),
];

String stageLabel(String focus) {
  for (final stage in lifeStages) {
    if (stage.$1 == focus) return stage.$2;
  }
  return switch (focus) {
    'mental' => 'Mind',
    'beauty' => 'Skin',
    'fitness' => 'Strength',
    'nutrition' => 'Food',
    _ => 'Cycle',
  };
}

String stageLine(String focus) {
  return switch (focus) {
    'teen' => 'School nights, and a cycle that may still be irregular. EVA keeps this as education and will not score a young body.',
    'college' => 'Weeks get uneven. The calendar stays a model, and a late period is not a verdict.',
    'work' => 'The day leads with energy and the one action that fits a full schedule.',
    'fertility' => 'Trying is a shared maybe. The window is a calendar, not contraception, and not a promise.',
    'pregnancy' => 'Pregnancy leads the day. The cycle forecast steps aside until you say otherwise.',
    'postpartum' => 'Broken sleep is expected here. EVA leaves unscored anything you have not had time to log.',
    'pcos' => 'Symptoms lead. A perfect cycle is not required for the day to make sense.',
    'perimenopause' => 'Cycles can stretch. Heat, sleep, and patience lead. This is not a diagnosis of menopause.',
    'menopause' => 'Heat, sleep, and mood are the day. Hormone therapy stays with a clinician.',
    'mental' => 'Mood sits beside the cycle. EVA will not name a disorder from a feeling.',
    'beauty' => 'Skin follows the cycle model plus the days you mark. No photo is uploaded.',
    'fitness' => 'Training gets quieter when the phase model says recovery matters.',
    'nutrition' => 'Plates shift with the phase. There is no calorie target.',
    _ => 'The cycle you confirmed leads. Your notes are what make the next week personal.',
  };
}

WeekAhead seeAhead(HealthProfile profile, DateTime now) {
  final trust = cycleTrust(profile);
  final menopause = profile.focus == 'menopause' || profile.focus == 'perimenopause';
  if (!trust.dated && !profile.pregnant && !menopause) {
    return WeekAhead(
      days: [
        for (var offset = 0; offset <= 7; offset++)
          Horizon(
            label: _offsetLabel(offset, shiftDays(now, offset)),
            day: shiftDays(now, offset),
            phase: 'Unknown',
            energy: 'Not enough information yet',
            mood: 'Not enough information yet',
            focus: 'Unknown',
            sleep: 'Unknown',
            cravings: 'Unknown',
            skin: 'Unknown',
            workout: 'Unknown',
            stress: 'Unknown',
            symptom: 'No symptom is being projected.',
            event: 'No period date is saved.',
          ),
      ],
      confidence: trust.label,
      note: trust.evidence,
    );
  }
  return WeekAhead(
    days: [for (var offset = 0; offset <= 7; offset++) _horizon(profile, shiftDays(now, offset), offset)],
    confidence: profile.pregnant || menopause ? 'Not a cycle score' : trust.label,
    note: profile.pregnant || menopause
        ? 'This stage does not get a cycle score. Looking further ahead does not create one.'
        : '${trust.evidence} The same limit applies to every day ahead.',
  );
}

String _offsetLabel(int offset, DateTime day) {
  return switch (offset) {
    0 => 'Today',
    1 => 'Tomorrow',
    3 => '3 days',
    7 => '7 days',
    _ => prettyDay(day).split(' · ').first,
  };
}

Recall recall(HealthProfile profile, DateTime now) {
  final recentStart = shiftDays(now, -30);
  final earlyStart = shiftDays(now, -120);
  final earlyEnd = shiftDays(now, -31);
  final recent = _symptomCounts(profile, recentStart, now);
  final early = _symptomCounts(profile, earlyStart, earlyEnd);
  final names = {...recent.keys, ...early.keys};
  String? best;
  var bestGap = 0;
  for (final name in names) {
    final before = early[name] ?? 0;
    final after = recent[name] ?? 0;
    if (before < 2 && after < 2) continue;
    final gap = (before - after).abs();
    if (gap > bestGap) {
      bestGap = gap;
      best = name;
    }
  }
  if (best == null) {
    final anyQuote = _oldQuote(profile, now, '');
    if (anyQuote != null) {
      return Recall(
        line: 'EVA still has your words: "$anyQuote". A comparison waits for the same note in a later month.',
        fromNotes: true,
      );
    }
    return const Recall(
      line: 'EVA is keeping what you say. A comparison waits until the same note appears in two different months.',
      fromNotes: false,
    );
  }
  final before = early[best] ?? 0;
  final after = recent[best] ?? 0;
  final spoken = _spoken(best);
  final quote = _oldQuote(profile, now, best);
  if (before >= 2 && before > after) {
    final drop = ((before - after) / before * 100).round();
    final remembered = quote == null ? '' : ' You wrote "$quote".';
    return Recall(
      line: 'Earlier notes mention $spoken $before times. The last month mentions $spoken $after. That is $drop% fewer notes.$remembered It is a change in what you wrote, not a measurement of the symptom.',
      fromNotes: true,
    );
  }
  if (after >= 2 && after > before) {
    return Recall(
      line: '$spoken showed up $after times this past month and $before times in the earlier stretch. More notes, not a proof that the symptom grew.',
      fromNotes: true,
    );
  }
  return Recall(
    line: '$spoken is in the record. There is not yet a clear rise or fall between the two stretches.',
    fromNotes: true,
  );
}

List<String> discoveries(HealthProfile profile, DateTime now) {
  final found = <String>[];
  var acne = 0;
  var acneNearSleep = 0;
  var cravingWithSleep = 0;
  var cravings = 0;
  final phaseCounts = <String, Map<CyclePhase, int>>{};

  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null) continue;
    if (profile.timingConfirmed) {
      for (final symptom in log.symptoms) {
        final phases = phaseCounts.putIfAbsent(symptom, () => {});
        final phase = projectCycle(profile, day).phase;
        phases[phase] = (phases[phase] ?? 0) + 1;
      }
    }
    if (log.symptoms.contains('acne')) {
      acne += 1;
      if (_hasSymptom(profile, day, 'insomnia') || _hasSymptom(profile, shiftDays(day, -1), 'insomnia')) {
        acneNearSleep += 1;
      }
    }
    if (log.symptoms.contains('craving')) {
      cravings += 1;
      if (log.symptoms.contains('insomnia')) cravingWithSleep += 1;
    }
  }

  if (acne >= 2 && acneNearSleep * 2 >= acne) {
    found.add('Acne notes have landed beside short-sleep notes more often than not. That is a neighborhood in your log, not a cause.');
  }
  if (cravings >= 2 && cravingWithSleep * 2 >= cravings) {
    found.add('Craving notes and poor-sleep notes have shared a day. The log shows they travel together. It does not say one creates the other.');
  }
  for (final entry in phaseCounts.entries) {
    final total = entry.value.values.fold<int>(0, (sum, count) => sum + count);
    if (total < 3) continue;
    final top = entry.value.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    if (top.first.value / total >= 0.7) {
      found.add('${_spoken(entry.key)} has clustered in the ${phasePhrase(top.first.key)} across your notes. A cluster is not a diagnosis.');
    }
  }

  final workouts = profile.workouts.map(tryParseDay).whereType<DateTime>().toList();
  if (workouts.length >= 2) {
    var moved = 0;
    var movedThenCalmer = 0;
    for (final day in workouts) {
      final next = profile.logOn(isoDay(shiftDays(day, 1)));
      if (next == null || next.mood.isEmpty) continue;
      moved += 1;
      if (next.mood == 'calm' || next.mood == 'bright' || next.mood == 'steady') movedThenCalmer += 1;
    }
    if (moved >= 2 && movedThenCalmer * 2 >= moved) {
      found.add('On days after you logged movement, the next mood note was often steadier. That is your sequence, not a training prescription.');
    }
  }

  if (found.isEmpty) {
    found.add('No hidden pattern yet. EVA will not invent one to seem clever. Two repeats of the same note are the start.');
  }
  return found;
}

String companionLine(HealthProfile profile, DateTime now) {
  if (profile.streak >= 3) {
    return 'You have shown up ${profile.streak} days in a row. That is attention, and it is not a grade of your health.';
  }
  final thisWeek = _logsBetween(profile, shiftDays(now, -6), now).length;
  var fullest = thisWeek;
  if (profile.logs.isNotEmpty) {
    final first = profile.logs.map((log) => tryParseDay(log.day)).whereType<DateTime>().fold<DateTime?>(null, (earliest, day) {
      if (earliest == null || day.isBefore(earliest)) return day;
      return earliest;
    });
    if (first != null) {
      for (var cursor = first; !cursor.isAfter(now); cursor = shiftDays(cursor, 7)) {
        final count = _logsBetween(profile, cursor, shiftDays(cursor, 6)).length;
        if (count > fullest) fullest = count;
      }
    }
  }
  if (thisWeek >= 3 && thisWeek >= fullest) {
    return 'This week holds as many notes as any week stored here. EVA kept them so you do not have to retell them.';
  }
  if (profile.milestones.isNotEmpty) {
    return 'EVA still remembers ${profile.milestones.length == 1 ? 'a milestone' : '${profile.milestones.length} milestones'} you already reached.';
  }
  return 'Say one true sentence. If EVA understands it, you should not have to say it the same way again.';
}

List<Chapter> lifeChapters(HealthProfile profile) {
  final buckets = <String, List<DailyLog>>{};
  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null) continue;
    final key = '${day.year}-${day.month.toString().padLeft(2, '0')}';
    buckets.putIfAbsent(key, () => []).add(log);
  }
  if (buckets.isEmpty) {
    return const [Chapter(label: 'This season', line: 'The story starts with the first note you choose to keep.')];
  }
  final keys = buckets.keys.toList()..sort();
  final chapters = <Chapter>[];
  for (var i = 0; i < keys.length; i++) {
    final logs = buckets[keys[i]]!;
    final day = tryParseDay(logs.first.day)!;
    final counts = <String, int>{};
    for (final log in logs) {
      for (final symptom in log.symptoms) {
        counts[symptom] = (counts[symptom] ?? 0) + 1;
      }
    }
    var line = '${logs.length} ${logs.length == 1 ? 'note' : 'notes'} kept.';
    if (counts.isNotEmpty) {
      final top = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      line = '${_spoken(top.first.key)} in ${top.first.value} ${top.first.value == 1 ? 'note' : 'notes'}.';
      if (i > 0) {
        final previous = buckets[keys[i - 1]]!;
        final previousCount = previous.where((log) => log.symptoms.contains(top.first.key)).length;
        if (previousCount > top.first.value) {
          line = '$line Fewer than the month before.';
        } else if (top.first.value > previousCount && previousCount > 0) {
          line = '$line More notes than the month before.';
        }
      }
    }
    chapters.add(Chapter(label: _monthName(day), line: line));
  }
  return chapters;
}

String coachLine(HealthProfile profile, DateTime now) {
  if (!profile.timingConfirmed && !profile.pregnant && profile.focus != 'menopause' && profile.focus != 'perimenopause') {
    return 'No period date is saved, so the coach will not name a cycle day.';
  }
  final lows = <int, int>{};
  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null) continue;
    final low = (log.energy != null && log.energy! < 0.4) || log.mood == 'low' || log.symptoms.contains('cramp');
    if (!low) continue;
    final cycleDay = projectCycle(profile, day).day;
    lows[cycleDay] = (lows[cycleDay] ?? 0) + 1;
  }
  final ranked = lows.entries.where((entry) => entry.value >= 2).toList()..sort((a, b) => b.value.compareTo(a.value));
  if (ranked.isNotEmpty) {
    final day = ranked.first.key;
    return 'Day $day is where a low or cramp note has shown up ${ranked.first.value} times. The experiment is water and an earlier night. EVA will not promise a percent of relief.';
  }
  final phase = projectCycle(profile, now).phase;
  if (phase == CyclePhase.lateLuteal || phase == CyclePhase.menstrual) {
    return 'The phase model often softens here. If that matches you, protect sleep tonight. It is a model, not a reading from a sensor.';
  }
  if (phase == CyclePhase.lateFollicular || phase == CyclePhase.ovulatory) {
    return 'The phase model often has more room for a plan you already wanted. Use it if you want it. EVA is not assigning the day.';
  }
  return 'Nothing in your notes repeats on the same cycle day yet. The coach will stay general until it does.';
}

Wellbeing wellbeing(HealthProfile profile, DateTime now) {
  final start = shiftDays(now, -13);
  final recent = _logsBetween(profile, start, now);
  final sleepNotes = recent.where((log) => log.symptoms.contains('insomnia')).length;
  final stressNotes = recent.where((log) => log.stress.isNotEmpty).length;
  final moves = profile.workouts.where((day) => _within(day, start, now)).length;
  final meals = profile.mealsNoted.where((day) => _within(day, start, now)).length;
  final energyNotes = recent.where((log) => log.energy != null).length;
  final waters = recent.where((log) => log.symptoms.contains('water')).length;
  final moods = recent.where((log) => log.mood.isNotEmpty).length;
  String countLine(int count, String noun, String empty) {
    if (count == 0) return empty;
    final word = count == 1 ? noun : '${noun}s';
    return '$count $word in 14 days. Counted, not scored.';
  }

  return Wellbeing(
    score: null,
    parts: [
      WellPart(name: 'Sleep', score: null, detail: countLine(sleepNotes, 'poor-sleep note', 'No sleep note in two weeks.')),
      WellPart(name: 'Stress', score: null, detail: countLine(stressNotes, 'stress note', 'Stress was not logged.')),
      WellPart(name: 'Fitness', score: null, detail: countLine(moves, 'movement day', 'No movement in this window.')),
      WellPart(name: 'Nutrition', score: null, detail: countLine(meals, 'meal note', 'No meal note in this window. There is no calorie target.')),
      WellPart(name: 'Recovery', score: null, detail: countLine(energyNotes, 'energy note', 'No energy note yet.')),
      WellPart(name: 'Hydration', score: null, detail: countLine(waters, 'water note', 'Water was not mentioned in this window.')),
      WellPart(name: 'Mind', score: null, detail: countLine(moods, 'mood note', 'No mood note in two weeks. Not a mental-health diagnosis.')),
      WellPart(name: 'Cycle', score: null, detail: cycleTrust(profile).evidence),
    ],
    caption: 'No wellbeing number. EVA will not turn the calendar, or these counts, into one.',
  );
}

List<HealthReport> healthReports(HealthProfile profile, DateTime now) {
  return [
    _report(profile, now, 7, 'This week'),
    _report(profile, now, 30, 'This month'),
    _report(profile, now, 90, 'This quarter'),
  ];
}

String togetherLine(HealthProfile profile, DateTime now) {
  if (profile.circle.isEmpty) {
    return 'The relationship twin starts when you add someone in Connect. Until then, nothing about you is shared.';
  }
  final person = profile.circle.first;
  final twin = relationshipTwin(person);
  final when = !profile.timingConfirmed
      ? 'No period date is saved, so this does not describe a cycle day.'
      : projectCycle(profile, now).phase == CyclePhase.lateLuteal || projectCycle(profile, now).phase == CyclePhase.menstrual
          ? 'In this softer part of the model, practical help matters more than advice.'
          : 'The useful help is the task they name, not the one a partner invents.';
  final gate = person.permissions.isEmpty ? 'Their view is still empty. You have not granted anything.' : 'They can see only the permissions that are on.';
  return '${person.name}. ${twin.showingUp} ${twin.support} $when $gate';
}

String supervisorLine(HealthProfile profile, Map<String, String> rooms) {
  final seen = profile.answered.where((item) => item.startsWith('seen:')).map((item) => item.substring(5)).toSet();
  if (seen.isEmpty && profile.logs.isEmpty) {
    return 'Nothing to audit yet. Open one room, and EVA will notice what you never reach.';
  }
  for (final room in rooms.entries) {
    if (!seen.contains(room.key)) {
      return '${room.value} is still unopened. It stays in the list. EVA will not hide other rooms to push it.';
    }
  }
  return 'You have opened every room. The next improvement is a truer note, not another screen.';
}

String pulseLine(HealthProfile profile, DateTime now) {
  final memory = recall(profile, now);
  if (memory.fromNotes) return memory.line;
  final found = discoveries(profile, now);
  if (found.isNotEmpty && !found.first.startsWith('No hidden pattern')) return found.first;
  if (profile.streak >= 3) return companionLine(profile, now);
  return coachLine(profile, now);
}

List<String> pregnancyGuide(PregnancyStory story) {
  return [
    'Week ${story.week} is a guide, not a measurement. ${story.headline}',
    'For you: name one thing that would make today easier. Energy can swing without anything being wrong.',
    'For a partner: ask what the next hour needs. Kicks, dates, and visits stay private until Connect grants them.',
    'Prepare: ${story.visit}',
  ];
}

Horizon _horizon(HealthProfile profile, DateTime day, int offset) {
  final label = _offsetLabel(offset, day);
  if (profile.pregnant && profile.pregnancyLmp != null) {
    final story = pregnancyStory(profile.pregnancyLmp!, day);
    return Horizon(
      label: label,
      day: day,
      phase: 'Week ${story.week}',
      energy: 'Led by pregnancy',
      mood: 'Ask her, do not infer',
      focus: 'The week',
      sleep: 'Protect it',
      cravings: 'Follow appetite',
      skin: 'No cycle skin call',
      workout: 'Only what feels steady',
      stress: 'Not scored',
      symptom: 'No cycle symptom is projected over a pregnancy.',
      event: story.headline,
    );
  }
  if (profile.focus == 'menopause' || profile.focus == 'perimenopause') {
    return Horizon(
      label: label,
      day: day,
      phase: stageLabel(profile.focus),
      energy: 'Variable',
      mood: 'Can shift with sleep',
      focus: 'Soft',
      sleep: 'Often broken',
      cravings: 'No cycle craving call',
      skin: 'Dryness is common. Not a diagnosis.',
      workout: 'Keep the habit gentle',
      stress: 'Heat can shorten patience',
      symptom: 'A period forecast would be a guess in this stage.',
      event: 'Heat, sleep, and mood lead.',
    );
  }
  final cycle = projectCycle(profile, day);
  final phase = cycle.phase;
  final logged = offset == 0 ? profile.logOn(isoDay(day)) : null;
  final symptom = _likelySymptom(profile, phase);
  return Horizon(
    label: label,
    day: day,
    phase: phaseLabel(phase),
    energy: logged?.energy != null
        ? 'Logged'
        : switch (phase) {
            CyclePhase.lateFollicular || CyclePhase.ovulatory => 'Higher estimate',
            CyclePhase.menstrual || CyclePhase.lateLuteal => 'Lower estimate',
            _ => 'Steady estimate',
          },
    mood: logged != null && logged.mood.isNotEmpty ? _title(logged.mood) : moodLabel(phase),
    focus: switch (phase) {
      CyclePhase.lateFollicular || CyclePhase.ovulatory => 'High',
      CyclePhase.earlyFollicular || CyclePhase.earlyLuteal => 'Steady',
      CyclePhase.menstrual || CyclePhase.lateLuteal => 'Soft',
    },
    sleep: sleepImpact(phase),
    cravings: phase == CyclePhase.lateLuteal ? 'Appetite often rises in this model' : 'No craving spike in the model',
    skin: phase == CyclePhase.lateLuteal || phase == CyclePhase.menstrual ? 'Reactive window in the model' : 'Often calmer in the model',
    workout: switch (phase) {
      CyclePhase.lateFollicular || CyclePhase.ovulatory => 'Room for a harder session',
      CyclePhase.menstrual || CyclePhase.lateLuteal => 'Easy movement if you want it',
      _ => 'Familiar work',
    },
    stress: logged != null && logged.stress.isNotEmpty
        ? _title(logged.stress)
        : phase == CyclePhase.lateLuteal
            ? 'Easier to feel loud'
            : 'No stress spike in the model',
    symptom: symptom,
    event: _event(cycle, day),
  );
}

String _event(CycleSnapshot cycle, DateTime day) {
  final date = dateOnly(day);
  if (cycle.phase == CyclePhase.menstrual) return 'Bleeding is the modeled event.';
  if (cycle.phase == CyclePhase.ovulatory) return 'Ovulation is the modeled day. Not contraception.';
  if (!date.isBefore(dateOnly(cycle.fertileStart)) && !date.isAfter(dateOnly(cycle.fertileEnd))) {
    return 'Inside the modeled fertile window. Not contraception.';
  }
  if (cycle.phase == CyclePhase.lateLuteal) return 'A softer pre-period stretch is the modeled event.';
  return 'No sharp cycle event in the model.';
}

String _likelySymptom(HealthProfile profile, CyclePhase phase) {
  final counts = <String, int>{};
  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null || projectCycle(profile, day).phase != phase) continue;
    for (final symptom in log.symptoms) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  if (counts.isEmpty) return 'No repeated symptom in this phase yet.';
  final top = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  if (top.first.value < 2) return '${_spoken(top.first.key)} appeared once in this phase. Once is not a pattern.';
  return '${_spoken(top.first.key)} has shown up ${top.first.value} times in this phase.';
}

HealthReport _report(HealthProfile profile, DateTime now, int days, String span) {
  final start = shiftDays(now, 1 - days);
  final priorStart = shiftDays(start, -days);
  final priorEnd = shiftDays(start, -1);
  final lines = <String>[];
  final current = _symptomCounts(profile, start, now);
  final prior = _symptomCounts(profile, priorStart, priorEnd);
  var win = false;
  for (final name in current.keys.toSet().union(prior.keys.toSet())) {
    final before = prior[name] ?? 0;
    final after = current[name] ?? 0;
    if (before >= 2 && after < before) {
      final drop = ((before - after) / before * 100).round();
      lines.add('Win: ${_spoken(name)} appears in $drop% fewer notes than the span before.');
      win = true;
      break;
    }
  }
  if (profile.streak >= 3 && days <= 7) {
    lines.add('Win: ${profile.streak} days of showing up.');
    win = true;
  }
  final found = discoveries(profile, now).where((line) => !line.startsWith('No hidden pattern'));
  if (found.isNotEmpty) lines.add('Pattern: ${found.first}');
  if (!win) lines.add('No win was invented for a quiet stretch.');
  final heavy = profile.logs.any((log) => _within(log.day, start, now) && log.flow >= 3);
  if (heavy) {
    lines.add('Care: a heavy-bleeding note is in this span. That belongs with a clinician, not in a highlight.');
  } else {
    lines.add('No heavy-bleeding note in this span.');
  }
  lines.add('Shared only if you copy it. EVA does not post this.');
  return HealthReport(span: span, lines: lines, shareText: '$span\n${lines.join('\n')}');
}

Map<String, int> _symptomCounts(HealthProfile profile, DateTime start, DateTime end) {
  final counts = <String, int>{};
  for (final log in _logsBetween(profile, start, end)) {
    for (final symptom in log.symptoms) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  return counts;
}

List<DailyLog> _logsBetween(HealthProfile profile, DateTime start, DateTime end) {
  return profile.logs.where((log) => _within(log.day, start, end)).toList();
}

bool _within(String day, DateTime start, DateTime end) {
  final parsed = tryParseDay(day);
  if (parsed == null) return false;
  final date = dateOnly(parsed);
  return !date.isBefore(dateOnly(start)) && !date.isAfter(dateOnly(end));
}

bool _hasSymptom(HealthProfile profile, DateTime day, String symptom) {
  return profile.logOn(isoDay(day))?.symptoms.contains(symptom) ?? false;
}

String? _oldQuote(HealthProfile profile, DateTime now, String hint) {
  final cutoff = shiftDays(now, -60);
  final needle = hint.isEmpty ? '' : _spoken(hint).split(' ').first;
  for (final turn in profile.chat) {
    if (turn.role != 'you') continue;
    final day = tryParseDay(turn.at);
    if (day == null || !day.isBefore(cutoff)) continue;
    final text = turn.text.trim();
    if (text.length < 8) continue;
    if (needle.isNotEmpty && !text.toLowerCase().contains(needle) && !text.toLowerCase().contains(hint)) continue;
    return text.length > 90 ? '${text.substring(0, 90)}…' : text;
  }
  return null;
}

String _spoken(String symptom) {
  return switch (symptom) {
    'cramp' => 'cramps',
    'headache' => 'headaches',
    'acne' => 'acne',
    'insomnia' => 'poor sleep',
    'craving' => 'cravings',
    'bloating' => 'bloating',
    'water' => 'water',
    'skin-clear' => 'clear-skin days',
    _ => symptom,
  };
}

String _title(String value) {
  if (value.isEmpty) return value;
  return value[0].toUpperCase() + value.substring(1);
}

String _monthName(DateTime day) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  return '${months[day.month - 1]} ${day.year}';
}
