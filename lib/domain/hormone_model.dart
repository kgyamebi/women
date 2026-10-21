import 'dart:math' as math;

import 'package:eva_ai/domain/cycle_engine.dart';
import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

double _gauss(double x, double center, double spread) {
  final z = (x - center) / spread;
  return math.exp(-(z * z));
}

HormonePoint hormonesFor(int day, int length) {
  final ovulation = (length - 14).toDouble();
  final d = day.toDouble();
  final estrogen = (0.2 + 0.62 * _gauss(d, ovulation - 1, 4.2) + 0.28 * _gauss(d, ovulation + 6, 3.4)).clamp(0.0, 1.0);
  final progesterone = d < ovulation
      ? (0.08 + 0.05 * _gauss(d, 3, 2.4)).clamp(0.0, 1.0)
      : (0.12 + 0.8 * _gauss(d, ovulation + 7, 3.0)).clamp(0.0, 1.0);
  final testosterone = (0.26 + 0.36 * _gauss(d, ovulation, 3.2)).clamp(0.0, 1.0);
  final cortisol = (0.32 + (d > ovulation + 5 ? 0.2 : 0.0) + 0.08 * _gauss(d, length.toDouble(), 2.2)).clamp(0.0, 1.0);
  return HormonePoint(
    estrogen: estrogen,
    progesterone: progesterone,
    testosterone: testosterone,
    cortisol: cortisol,
  );
}

List<HormonePoint> hormoneSeries(int length) {
  return List<HormonePoint>.generate(length, (index) => hormonesFor(index + 1, length));
}

String levelWord(double level) {
  if (level < 0.22) return 'Quiet';
  if (level < 0.42) return 'Low';
  if (level < 0.62) return 'Steady';
  if (level < 0.8) return 'Rising';
  return 'High';
}

TwinRead buildTwin(HealthProfile profile, int day) {
  final length = profile.cycleLength < 15 ? 28 : profile.cycleLength;
  final safeDay = day.clamp(1, length);
  final phase = phaseFor(safeDay, length, profile.periodLength.clamp(2, 8));
  final point = hormonesFor(safeDay, length);
  final cravings = phase == CyclePhase.lateLuteal ? 0.84 : phase == CyclePhase.lateFollicular ? 0.24 : 0.46;
  final mood = switch (phase) {
    CyclePhase.lateFollicular || CyclePhase.ovulatory => 0.82,
    CyclePhase.earlyFollicular || CyclePhase.earlyLuteal => 0.58,
    CyclePhase.menstrual || CyclePhase.lateLuteal => 0.34,
  };
  final energy = (0.5 + energyDelta(phase)).clamp(0.0, 1.0);
  final sleep = switch (sleepImpact(phase)) {
    'High' => 0.28,
    'Moderate' => 0.5,
    _ => 0.78,
  };
  final recovery = switch (phase) {
    CyclePhase.lateFollicular || CyclePhase.ovulatory => 0.8,
    CyclePhase.earlyFollicular || CyclePhase.earlyLuteal => 0.62,
    CyclePhase.menstrual => 0.36,
    CyclePhase.lateLuteal => 0.4,
  };

  final matching = profile.logs.where((log) {
    final logged = tryParseDay(log.day);
    if (logged == null) return false;
    final snapshot = projectCycle(profile, logged);
    return snapshot.phase == phase && log.symptoms.isNotEmpty;
  }).toList();
  final counts = <String, int>{};
  for (final log in matching) {
    for (final symptom in log.symptoms) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  String personal = 'Typical associations for this part of a textbook cycle. Your logs will make this personal.';
  if (counts.isNotEmpty) {
    final top = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final name = top.first.key;
    personal = 'In this phase you have logged $name ${top.first.value} ${top.first.value == 1 ? 'time' : 'times'}. That is a pattern, not a diagnosis.';
  }

  TwinMetric metric(String label, String value, double level) => TwinMetric(label: label, value: value, level: level);

  return TwinRead(
    day: safeDay,
    phase: phase,
    point: point,
    hormones: [
      metric('Estrogen', levelWord(point.estrogen), point.estrogen),
      metric('Progesterone', levelWord(point.progesterone), point.progesterone),
      metric('Testosterone', levelWord(point.testosterone), point.testosterone),
      metric('Cortisol', levelWord(point.cortisol), point.cortisol),
    ],
    forecasts: [
      metric('Cravings', levelWord(cravings), cravings),
      metric('Mood', levelWord(mood), mood),
      metric('Energy', levelWord(energy), energy),
      metric('Sleep quality', levelWord(sleep), sleep),
      metric('Recovery', levelWord(recovery), recovery),
    ],
    personal: personal,
  );
}
