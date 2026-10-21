import 'package:eva_ai/domain/brief_engine.dart';
import 'package:eva_ai/domain/care_plans.dart';
import 'package:eva_ai/domain/copilot_engine.dart';
import 'package:eva_ai/domain/cycle_engine.dart';
import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

const circleRoles = <(String, String)>[
  ('partner', 'Partner'),
  ('spouse', 'Spouse'),
  ('boyfriend', 'Boyfriend'),
  ('girlfriend', 'Girlfriend'),
  ('fiance', 'Fiance'),
  ('ttc', 'Trying to conceive'),
  ('pregnancyPartner', 'Pregnancy partner'),
  ('parent', 'Parent'),
  ('caregiver', 'Caregiver'),
  ('doctor', 'Doctor'),
  ('doula', 'Doula'),
  ('nutritionist', 'Nutritionist'),
  ('therapist', 'Therapist'),
  ('friend', 'Best friend'),
  ('accountability', 'Accountability'),
  ('circle', 'Support circle'),
];

const connectPermissions = <(String, String)>[
  ('phase', 'Current phase'),
  ('energy', 'Energy outlook'),
  ('mood', 'Mood outlook'),
  ('stress', 'Stress outlook'),
  ('support', 'Ways to help'),
  ('fertility', 'Fertility window'),
  ('pregnancy', 'Pregnancy journey'),
  ('kicks', 'Kick tally'),
  ('appointments', 'Visits'),
  ('symptoms', 'Care translations'),
  ('goals', 'Shared goals'),
  ('missions', 'Care missions'),
];

class PartnerView {
  const PartnerView({
    required this.closed,
    required this.overview,
    required this.lines,
    required this.support,
    required this.understand,
    required this.brief,
    required this.crisis,
    required this.missions,
    required this.journey,
  });

  final bool closed;
  final String overview;
  final List<String> lines;
  final List<String> support;
  final List<String> understand;
  final String brief;
  final bool crisis;
  final List<String> missions;
  final List<String> journey;
}

class RelationshipTwin {
  const RelationshipTwin({
    required this.showingUp,
    required this.support,
    required this.together,
    required this.insight,
  });

  final String showingUp;
  final String support;
  final String together;
  final String insight;
}

String circleRoleLabel(String role) {
  for (final item in circleRoles) {
    if (item.$1 == role) return item.$2;
  }
  return 'Partner';
}

PartnerView partnerView(HealthProfile profile, CirclePerson person, DateTime now) {
  final daily = buildBrief(profile, now);
  final forecast = dayForecast(profile, daily, now);
  final lines = <String>[];
  if (person.allows('phase')) {
    lines.add(
      profile.timingConfirmed
          ? 'Estimate: ${daily.orbValue}. ${daily.orbKicker}. From a saved period date, not a measurement.'
          : 'No period date is saved, so no cycle day is shared.',
    );
  }
  if (person.allows('energy')) {
    lines.add(
      profile.timingConfirmed
          ? 'Energy is a phase-table estimate, not a score from the body.'
          : 'No energy estimate is shared until a period date is saved.',
    );
  }
  if (person.allows('mood')) {
    lines.add(
      profile.timingConfirmed
          ? 'Mood outlook is a phase estimate: ${forecast.mood}. Not a measurement.'
          : 'No mood estimate is shared until a period date is saved.',
    );
  }
  if (person.allows('stress')) {
    final stress = profile.logOn(isoDay(now))?.stress;
    lines.add(stress == null || stress.isEmpty ? 'Stress was not logged today.' : 'Stress logged as $stress.');
  }
  if (person.allows('fertility') && !profile.pregnant && profile.timingConfirmed) {
    final cycle = daily.cycle;
    lines.add(
      'Modeled fertile window ${prettyDay(cycle.fertileStart)} to ${prettyDay(cycle.fertileEnd)}. Not contraception, and not a promise.',
    );
  }
  if (person.allows('pregnancy') && profile.pregnant && profile.pregnancyLmp != null) {
    final story = pregnancyStory(profile.pregnancyLmp!, now);
    lines.add('Week ${story.week}, day ${story.extraDays}. ${story.headline}');
  }
  if (person.allows('kicks') && profile.pregnant) {
    final kicks = profile.kicksDay == isoDay(now) ? profile.kicks : 0;
    lines.add('$kicks kicks noted today. A personal tally, not a medical count.');
  }
  if (person.allows('appointments') && profile.appointments.isNotEmpty) {
    lines.add('Visits on the list: ${profile.appointments.join(', ')}.');
  }
  final severe = _severe(profile, now);
  if (person.allows('symptoms') && severe) {
    lines.add('A heavy or urgent note was logged today. That needs a person, not an app diagnosis.');
  }

  final support = person.allows('support')
      ? (!profile.timingConfirmed && !profile.pregnant
          ? const ['Ask what would help. No cycle estimate is available yet.']
          : _support(profile, forecast, daily))
      : const <String>[];
  final understand = _understand(person.role, person.allows('phase') ? daily.cycle.phase : null);
  final missions = person.allows('missions') ? careMissions(profile, now) : const <String>[];
  final journey = _journey(profile, person, now);
  final closed = person.permissions.isEmpty;

  return PartnerView(
    closed: closed,
    overview: closed
        ? 'Nothing is shared with ${person.name} yet.'
        : '${profile.name.isEmpty ? 'They are' : profile.name} is letting ${person.name} understand a chosen part of today.',
    lines: lines,
    support: support,
    understand: understand,
    brief: !profile.timingConfirmed && !profile.pregnant
        ? 'No daily brief until a period date is saved.'
        : _brief(forecast, support, closed),
    crisis: severe && (person.allows('support') || person.allows('symptoms')),
    missions: missions,
    journey: journey,
  );
}

List<String> careMissions(HealthProfile profile, DateTime now) {
  if (profile.pregnant) {
    return const [
      'Ask how she feels',
      'Walk together only if she wants',
      'Write one question for the next visit',
    ];
  }
  final phase = projectCycle(profile, now).phase;
  if (phase == CyclePhase.lateLuteal || phase == CyclePhase.menstrual) {
    return const [
      'Keep plans flexible',
      'Offer one practical help',
      'Ask before suggesting a fix',
    ];
  }
  if (phase == CyclePhase.lateFollicular || phase == CyclePhase.ovulatory) {
    return const [
      'Encourage a plan she already wanted',
      'Offer to move together',
      'Leave room for her energy',
    ];
  }
  return const [
    'Ask how she feels',
    'Drink water together',
    'Send one sincere note',
  ];
}

RelationshipTwin relationshipTwin(CirclePerson person) {
  final missions = person.missionDays.length;
  final goals = person.goals.length;
  return RelationshipTwin(
    showingUp: person.checkIns == 0
        ? 'No check-in yet. One tap is enough.'
        : '${person.checkIns} check-ins. Showing up is the whole point.',
    support: missions == 0 ? 'No mission kept yet. The list is optional.' : '$missions missions kept. That is care, not a grade.',
    together: goals == 0 ? 'No shared goal yet.' : '$goals goals you chose. Finish is optional.',
    insight: missions >= 2 && person.checkIns >= 2
        ? 'Check-ins and missions are both happening. The pattern is showing up together.'
        : goals > 0 && missions > 0
            ? 'A goal plus a small action is how support becomes ordinary.'
            : 'The relationship twin learns only from what you record here. It will not invent a score.',
  );
}

String partnerReply({
  required HealthProfile profile,
  required CirclePerson person,
  required DateTime now,
  required String question,
}) {
  final q = question.toLowerCase().trim();
  final safety = safetyNotice(q);
  if (safety.isNotEmpty) return safety;
  final view = partnerView(profile, person, now);
  if (view.closed) {
    return '${person.name} cannot see a health detail yet. ${profile.name.isEmpty ? 'The owner' : profile.name} has not granted one.';
  }
  if (_asks(q, ['fatigue', 'tired', 'energy'])) {
    if (!person.allows('energy')) return 'Energy is not shared with ${person.name}.';
    return view.lines.where((line) => line.startsWith('Energy')).join(' ');
  }
  if (_asks(q, ['support', 'help', 'today'])) {
    if (!person.allows('support')) return 'Support guidance is not shared yet.';
    return 'Today, the useful help is practical and optional. ${view.support.join(' ')}';
  }
  if (_asks(q, ['pms', 'luteal', 'phase', 'hormone'])) {
    if (!person.allows('phase') && !person.allows('support')) return 'The phase is not shared yet.';
    return '${view.understand.join(' ')} This is education, not a reading of her body.';
  }
  if (_asks(q, ['menopause', 'hot'])) {
    return 'Heat, broken sleep, and mood shifts can travel together in the menopause transition, and they are also non-specific. Ask what she wants, and leave hormone therapy with her clinician.';
  }
  if (_asks(q, ['pregnant', 'baby', 'kick', 'birth'])) {
    if (!person.allows('pregnancy') && !person.allows('kicks')) return 'The pregnancy journey is not shared yet.';
    return view.lines.isEmpty ? 'Pregnancy is the focus, and the dated details are still private.' : view.lines.join(' ');
  }
  if (_asks(q, ['fertile', 'ovulat', 'conceive'])) {
    if (!person.allows('fertility')) return 'The fertile window is not shared yet.';
    return 'The window is a calendar model. It is not contraception and not a promise of pregnancy. ${view.lines.where((line) => line.contains('fertile')).join(' ')}';
  }
  return view.closed
      ? 'Nothing is shared yet.'
      : '${view.overview} ${view.brief} I will not diagnose, and I will not add a detail that was not granted.';
}

List<String> _support(HealthProfile profile, DayForecast forecast, DailyBrief daily) {
  if (profile.pregnant) {
    return const [
      'Ask what would help in the next hour.',
      'Take a task she names, not one you invent.',
      'Keep the evening flexible.',
    ];
  }
  if (forecast.focus == 'High') {
    return const [
      'Encourage a plan she already cares about.',
      'Offer to schedule something that matters.',
      'A shared workout only if she wants company.',
    ];
  }
  if (daily.cycle.phase == CyclePhase.lateLuteal || daily.cycle.phase == CyclePhase.menstrual) {
    return const [
      'Be patient with a slower pace.',
      'Offer practical support.',
      'Keep plans flexible.',
    ];
  }
  return const [
    'Ask one honest question.',
    'Match her energy instead of raising it.',
    'Leave advice until she asks.',
  ];
}

List<String> _understand(String role, CyclePhase? phase) {
  final lines = <String>[
    switch (role) {
      'doctor' || 'doula' || 'therapist' || 'nutritionist' =>
        'A clinician still leads care. This view is context, not a chart you can act on alone.',
      'ttc' => 'Trying to conceive is a shared maybe. The calendar is not a scoreboard.',
      'pregnancyPartner' => 'Pregnancy support is practical. Dating and kicks stay off until they are granted.',
      'parent' || 'caregiver' => 'Caregiving works better when the person names the help.',
      'accountability' => 'Accountability is a shared habit, not a audit of her body.',
      'friend' => 'A friend can be present without holding the whole record.',
      _ => 'A partner helps most by understanding the day, not by managing it.',
    },
  ];
  if (phase == CyclePhase.lateLuteal) {
    lines.add('The late luteal days often ask for a softer pace. That is a pattern, not a verdict about her mood.');
  } else if (phase == CyclePhase.lateFollicular || phase == CyclePhase.ovulatory) {
    lines.add('This part of a cycle is often a higher-energy stretch. It is still her choice how to use it.');
  } else if (phase != null) {
    lines.add('The phase is a calendar estimate. It does not explain every feeling.');
  }
  return lines;
}

List<String> _journey(HealthProfile profile, CirclePerson person, DateTime now) {
  final lines = <String>[];
  if (person.role == 'ttc' && person.allows('fertility') && !profile.pregnant) {
    final cycle = projectCycle(profile, now);
    lines.add('Shared fertility timeline: ovulation estimate ${prettyDay(cycle.ovulation)}.');
    lines.add('Ask a clinician which day matters before any blood test. Bring dates, not a theory.');
  }
  if ((person.role == 'pregnancyPartner' || person.allows('pregnancy')) && profile.pregnant && profile.pregnancyLmp != null) {
    final story = pregnancyStory(profile.pregnancyLmp!, now);
    lines.add('Baby-size metaphor: ${story.size}. It is a teaching image, not a measurement.');
    lines.add('Due estimate ${prettyDay(story.due)}. It is not a deadline.');
    lines.add('Before birth: sleep, the hospital plan, feeding questions, and who to call overnight belong on a shared list.');
  }
  if (person.role == 'doctor' || person.role == 'doula' || person.role == 'therapist' || person.role == 'nutritionist') {
    lines.add('No message is sent to a clinic from this device. A visit is shared only when that permission is on.');
  }
  if (profile.focus == 'menopause') {
    lines.add('Menopause support is about heat, sleep, and patience. Hormone therapy stays with her clinician.');
    lines.add('A shorter fuse is often broken sleep. Ask what kind of company she wants.');
  }
  if (person.role == 'accountability') {
    lines.add('Shared habits stay habits. Missing a day is information, not a failure.');
  }
  return lines;
}

String _brief(DayForecast forecast, List<String> support, bool closed) {
  if (closed) return 'No daily brief until something is granted.';
  final help = support.isEmpty ? 'Ask what would help.' : support.first;
  if (forecast.focus == 'Soft') {
    return 'Today the model expects a lower, softer day. Suggested: $help';
  }
  return 'Today the model expects a ${forecast.focus.toLowerCase()} focus. Suggested: $help';
}

bool _severe(HealthProfile profile, DateTime now) {
  final log = profile.logOn(isoDay(now));
  if (log != null && log.flow >= 3) return true;
  final symptoms = log?.symptoms ?? const <String>[];
  return symptoms.any((symptom) => symptom.contains('faint') || symptom.contains('soaking'));
}

bool _asks(String question, List<String> keys) => keys.any(question.contains);
