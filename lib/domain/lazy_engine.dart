import 'package:eva_ai/domain/health_models.dart';

class UsualNote {
  const UsualNote({required this.symptom, required this.count});

  final String symptom;
  final int count;
}

bool logHasContent(DailyLog log) {
  return log.flow > 0 || log.mood.isNotEmpty || log.stress.isNotEmpty || log.energy != null || log.symptoms.isNotEmpty;
}

String noteLabel(String symptom) {
  return switch (symptom) {
    'cramp' => 'Cramps',
    'headache' => 'Headache',
    'acne' => 'Acne',
    'insomnia' => 'Poor sleep',
    'craving' => 'Craving',
    'bloating' => 'Bloating',
    'water' => 'Water',
    'skin-clear' => 'Clear skin',
    '' => '',
    _ => symptom[0].toUpperCase() + symptom.substring(1),
  };
}

String shortcutLabel(DailyLog log) {
  final bits = <String>[];
  if (log.flow > 0 && log.flow < 4) {
    bits.add(const ['', 'Light', 'Medium', 'Heavy'][log.flow]);
  }
  if (log.mood.isNotEmpty) bits.add(noteLabel(log.mood));
  for (final symptom in log.symptoms.take(2)) {
    bits.add(noteLabel(symptom));
  }
  if (bits.isEmpty && log.energy != null) return 'Energy note';
  if (bits.isEmpty && log.stress.isNotEmpty) return noteLabel(log.stress);
  return bits.join(', ');
}

List<UsualNote> usualNotes(HealthProfile profile) {
  final counts = <String, int>{};
  for (final log in profile.logs) {
    for (final symptom in log.symptoms.toSet()) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  final ranked = counts.entries.where((entry) => entry.value >= 2).toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return [
    for (final entry in ranked.take(6)) UsualNote(symptom: entry.key, count: entry.value),
  ];
}

DailyLog? latestPriorLog(HealthProfile profile, DateTime now) {
  final today = isoDay(dateOnly(now));
  DailyLog? best;
  for (final log in profile.logs) {
    if (log.day.compareTo(today) >= 0 || !logHasContent(log)) continue;
    if (best == null || log.day.compareTo(best.day) > 0) best = log;
  }
  return best;
}
