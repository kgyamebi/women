import 'dart:math' as math;

import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

Daypart daypartOf(DateTime now) {
  if (now.hour < 5) return Daypart.night;
  if (now.hour < 12) return Daypart.morning;
  if (now.hour < 17) return Daypart.afternoon;
  return Daypart.evening;
}

String phaseLabel(CyclePhase phase) {
  switch (phase) {
    case CyclePhase.menstrual:
      return 'Menstrual';
    case CyclePhase.earlyFollicular:
      return 'Early follicular';
    case CyclePhase.lateFollicular:
      return 'Late follicular';
    case CyclePhase.ovulatory:
      return 'Ovulatory';
    case CyclePhase.earlyLuteal:
      return 'Early luteal';
    case CyclePhase.lateLuteal:
      return 'Late luteal';
  }
}

String phasePhrase(CyclePhase phase) {
  switch (phase) {
    case CyclePhase.menstrual:
      return 'menstrual phase';
    case CyclePhase.earlyFollicular:
      return 'early follicular phase';
    case CyclePhase.lateFollicular:
      return 'late follicular phase';
    case CyclePhase.ovulatory:
      return 'ovulatory window';
    case CyclePhase.earlyLuteal:
      return 'early luteal phase';
    case CyclePhase.lateLuteal:
      return 'late luteal phase';
  }
}

int cycleDay({
  required DateTime today,
  required DateTime lastPeriodStart,
  required int length,
}) {
  final safeLength = length < 15 ? 28 : length;
  final delta = calendarDaysBetween(lastPeriodStart, today);
  final shifted = delta < 0 ? 0 : delta;
  return (shifted % safeLength) + 1;
}

CyclePhase phaseFor(int day, int length, int periodLength) {
  final ovulation = length - 14;
  if (day <= periodLength) return CyclePhase.menstrual;
  if (day >= ovulation - 1 && day <= ovulation + 1) return CyclePhase.ovulatory;
  if (day < ovulation - 1 && day >= ovulation - 4) return CyclePhase.lateFollicular;
  if (day < ovulation - 1) return CyclePhase.earlyFollicular;
  if (day <= ovulation + 7) return CyclePhase.earlyLuteal;
  return CyclePhase.lateLuteal;
}

double energyDelta(CyclePhase phase) {
  switch (phase) {
    case CyclePhase.menstrual:
      return -0.12;
    case CyclePhase.earlyFollicular:
      return 0.06;
    case CyclePhase.lateFollicular:
      return 0.18;
    case CyclePhase.ovulatory:
      return 0.14;
    case CyclePhase.earlyLuteal:
      return 0.04;
    case CyclePhase.lateLuteal:
      return -0.16;
  }
}

String moodLabel(CyclePhase phase) {
  switch (phase) {
    case CyclePhase.lateFollicular:
    case CyclePhase.ovulatory:
      return 'Positive';
    case CyclePhase.earlyFollicular:
    case CyclePhase.earlyLuteal:
      return 'Steady';
    case CyclePhase.menstrual:
    case CyclePhase.lateLuteal:
      return 'Tender';
  }
}

String sleepImpact(CyclePhase phase) {
  switch (phase) {
    case CyclePhase.lateLuteal:
      return 'High';
    case CyclePhase.menstrual:
    case CyclePhase.earlyLuteal:
      return 'Moderate';
    case CyclePhase.earlyFollicular:
    case CyclePhase.lateFollicular:
    case CyclePhase.ovulatory:
      return 'Low';
  }
}

double _gauss(double x, double center, double spread) {
  final z = (x - center) / spread;
  return math.exp(-(z * z));
}

double fertilityLevel(int day, int length) {
  final ovulation = (length - 14).toDouble();
  return (_gauss(day.toDouble(), ovulation, 1.7) * 0.92).clamp(0.0, 1.0);
}

/// A display number is not produced here. One saved date is not a confidence percent.
double calendarConfidence(HealthProfile profile) => 0;

class CycleTrust {
  const CycleTrust({required this.label, required this.evidence, required this.dated});

  final String label;
  final String evidence;
  final bool dated;
}

CycleTrust cycleTrust(HealthProfile profile) {
  final symptoms = profile.logs.fold<int>(0, (sum, log) => sum + log.symptoms.length);
  final sleep = profile.logs.where((log) => log.symptoms.contains('insomnia')).length;
  final dated = profile.timingConfirmed;
  final evidence =
      'Based on ${dated ? '1 period date you saved' : '0 period dates'} · $symptoms symptom ${symptoms == 1 ? 'entry' : 'entries'} · $sleep sleep ${sleep == 1 ? 'note' : 'notes'}.';
  if (!dated) {
    return CycleTrust(label: 'Not enough information yet', evidence: evidence, dated: false);
  }
  final days = profile.logs.map((log) => tryParseDay(log.day)).whereType<DateTime>().toList()..sort();
  final span = days.length >= 2 ? calendarDaysBetween(days.first, days.last) : 0;
  final length = profile.cycleLength < 15 ? 28 : profile.cycleLength;
  if (span >= length && symptoms >= 4) {
    return CycleTrust(
      label: 'Medium',
      evidence: '$evidence Notes cover at least one cycle length. This is still not a hormone test.',
      dated: true,
    );
  }
  return CycleTrust(
    label: 'Low',
    evidence: '$evidence One saved date is not a cycle history.',
    dated: true,
  );
}

CycleSnapshot projectCycle(HealthProfile profile, DateTime today) {
  final length = profile.cycleLength < 15 ? 28 : profile.cycleLength;
  final day = cycleDay(today: today, lastPeriodStart: profile.lastPeriodStart, length: length);
  final phase = phaseFor(day, length, profile.periodLength.clamp(2, 8));
  final ovulationDay = length - 14;
  var ovulationDelta = ovulationDay - day;
  if (ovulationDelta < 0) ovulationDelta += length;
  final ovulation = shiftDays(today, ovulationDelta);
  final nextPeriod = shiftDays(today, length - day + 1);
  var pmsDelta = (ovulationDay + 8) - day;
  if (pmsDelta < 0) pmsDelta += length;
  final confidence = calendarConfidence(profile);
  return CycleSnapshot(
    day: day,
    length: length,
    phase: phase,
    nextPeriod: nextPeriod,
    ovulation: ovulation,
    fertileStart: shiftDays(ovulation, -5),
    fertileEnd: ovulation,
    pmsStart: shiftDays(today, pmsDelta),
    confidence: confidence,
    ovulationConfidence: confidence == 0 ? 0 : (confidence * 0.72).clamp(0.3, 0.78),
    fertilityToday: fertilityLevel(day, length),
  );
}

String percentLabel(double value) => '${(value * 100).round()}%';
