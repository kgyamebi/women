import 'package:eva_ai/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final morning = DateTime(2026, 10, 21, 9);
  final sarah = HealthProfile.draft('Sarah', now: morning);

  test('a regular day 12 reads as late follicular with the morning brief', () {
    final brief = buildBrief(sarah, morning);
    expect(brief.cycle.day, 12);
    expect(brief.cycle.phase, CyclePhase.lateFollicular);
    expect(brief.greeting, 'Good morning');
    expect(brief.headline, 'Today your body is likely entering the late follicular phase.');
    expect(brief.energyLine, 'Energy is expected to rise 18%.');
    expect(brief.recommendations, ['Strength training', 'Higher protein intake', 'Hydration focus']);
    expect(brief.signals[0].value, 'Positive');
    expect(brief.signals[1].value, 'Low');
    expect(brief.signals[3].value, '96%');
    expect(brief.whispers.map((whisper) => whisper.message), [
      'Your energy may peak this afternoon.',
      'Hydration recommended.',
    ]);
    expect(brief.cycle.nextPeriod, DateTime(2026, 11, 7));
    expect(brief.cycle.ovulation, DateTime(2026, 10, 23));
  });

  test('the middle of the night protects sleep', () {
    final night = DateTime(2026, 10, 21, 1, 55);
    final brief = buildBrief(HealthProfile.draft('Sarah', now: night), night);
    expect(brief.greeting, 'Still with you');
    expect(brief.energyLine, 'Energy is expected to rise 18% after you sleep.');
    expect(brief.recommendations, ['Protect sleep', 'Dim the room', 'Leave training for morning']);
    expect(brief.whispers.map((whisper) => whisper.message), ['Consider an earlier bedtime tonight.']);
  });

  test('irregular rhythms keep calendar confidence modest', () {
    final brief = buildBrief(sarah.copyWith(regular: false, focus: 'pcos', contexts: ['pcos']), morning);
    expect(brief.cycle.confidence, lessThanOrEqualTo(0.74));
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
  });
}
