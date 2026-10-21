import 'package:eva_ai/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final morning = DateTime(2026, 10, 21, 9);
  final sarah = HealthProfile.draft('Sarah', now: morning);

  test('an unsaved period date does not invent a cycle day', () {
    final brief = buildBrief(sarah, morning);
    expect(brief.orbValue, 'Unknown');
    expect(brief.headline, contains('Not enough information yet'));
    expect(brief.energyLine, contains('No energy estimate'));
    expect(brief.signals[3].value, 'Not enough information yet');
    expect(brief.signals[3].caption, 'No score');
    expect(brief.whispers.map((whisper) => whisper.message).join(' '), isNot(contains('peak')));
    expect(brief.whispers.map((whisper) => whisper.message).join(' '), contains('Hydration'));
  });

  test('a saved period date stays an estimate', () {
    final brief = buildBrief(sarah.copyWith(timingConfirmed: true), morning);
    expect(brief.cycle.day, 12);
    expect(brief.cycle.phase, CyclePhase.lateFollicular);
    expect(brief.headline, contains('late follicular'));
    expect(brief.headline, contains('Not a measurement'));
    expect(brief.energyLine, contains('not a measurement'));
    expect(brief.energyLine, isNot(contains('%')));
    expect(brief.signals[3].value, 'Low');
    expect(brief.cycle.nextPeriod, DateTime(2026, 11, 7));
    expect(brief.cycle.ovulation, DateTime(2026, 10, 23));
    expect(calendarConfidence(sarah.copyWith(timingConfirmed: true)), 0);
  });

  test('the middle of the night protects sleep', () {
    final night = DateTime(2026, 10, 21, 1, 55);
    final brief = buildBrief(HealthProfile.draft('Sarah', now: night), night);
    expect(brief.greeting, 'Still with you');
    expect(brief.energyLine, contains('No energy estimate'));
    expect(brief.recommendations, ['Protect sleep', 'Dim the room', 'Leave training for morning']);
    expect(brief.whispers.map((whisper) => whisper.message).join(' '), contains('earlier bedtime'));
  });

  test('one saved date stays low even when the rhythm is called irregular', () {
    final trust = cycleTrust(sarah.copyWith(timingConfirmed: true, regular: false, focus: 'pcos', contexts: ['pcos']));
    expect(trust.label, 'Low');
    expect(trust.evidence, contains('1 period date'));
  });

  test('pregnancy week 12 uses the clinical count', () {
    final lmp = DateTime(2026, 7, 29);
    final story = pregnancyStory(lmp, morning);
    expect(story.week, 12);
    expect(story.headline, contains('first trimester'));
  });

  test('estrogen leads before ovulation and progesterone leads after', () {
    final follicular = hormonesFor(12, 28);
    final luteal = hormonesFor(21, 28);
    expect(follicular.estrogen, greaterThan(follicular.progesterone));
    expect(luteal.progesterone, greaterThan(luteal.estrogen));
  });

  test('the copilot refuses to diagnose and routes a crisis', () {
    final brief = buildBrief(sarah, morning);
    final headache = copilotReply(
      profile: sarah,
      brief: brief,
      question: 'Why do I always get headaches before my period?',
    );
    expect(headache.toLowerCase(), contains('not diagnose'));
    expect(headache.toLowerCase(), isNot(contains('you have a migraine')));

    final weight = copilotReply(profile: sarah, brief: brief, question: 'Can PCOS cause weight gain?');
    expect(weight, contains('does not mean you have PCOS'));

    final crisis = copilotReply(profile: sarah, brief: brief, question: 'I want to die');
    expect(crisis, contains('988'));
    expect(crisis.toLowerCase(), isNot(contains('method')));

    final quiet = copilotReply(profile: sarah, brief: brief, question: 'selfharm');
    expect(quiet, contains('988'));

    final treatment = copilotReply(profile: sarah, brief: brief, question: 'Should I continue treatment');
    expect(treatment.toLowerCase(), isNot(contains('appetite is data')));

    final brunch = copilotReply(profile: sarah, brief: brief, question: 'Is brunch a problem');
    expect(brunch.toLowerCase(), isNot(contains('training should follow')));

    final weekend = copilotReply(profile: sarah, brief: brief, question: 'How was your weekend');
    expect(weekend.toLowerCase(), isNot(contains('if you are pregnant')));
  });

  test('a logged mood replaces the phase forecast', () {
    final logged = sarah.copyWith(
      logs: const [DailyLog(day: '2026-10-21', mood: 'low')],
    );
    final brief = buildBrief(logged, morning);
    expect(brief.signals[0].label, 'Mood today');
    expect(brief.signals[0].value, 'Low');
  });

  test('the morning forecast is a phase model', () {
    final forecast = dayForecast(sarah, buildBrief(sarah, morning), morning);
    expect(forecast.energy, 68);
    expect(forecast.mood, 'Positive');
    expect(forecast.focus, 'High');
    expect(forecast.modeled, contains('Strong workout potential'));
    expect(briefName(Daypart.night), 'Sleep brief');
  });

  test('safety replies route harm without treatment steps', () {
    expect(safetyNotice('I want to die'), contains('988'));
    expect(safetyNotice('he hit me'), contains('1-800-799-7233'));
    expect(safetyNotice('I was raped'), contains('1-800-656-4673'));
    expect(safetyNotice('I keep purging'), contains('1-800-931-2237'));
    expect(safetyNotice('chest pain'), contains('emergency'));
    expect(safetyNotice('Should I continue treatment').toLowerCase(), isNot(contains('988')));
    for (final reply in [
      safetyNotice('I want to die'),
      safetyNotice('he hit me'),
      safetyNotice('chest pain'),
    ]) {
      expect(reply.toLowerCase(), contains('not a diagnosis'));
      expect(reply.toLowerCase(), isNot(contains('method')));
    }
  });
}
