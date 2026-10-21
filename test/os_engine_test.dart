import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:eva_ai/features/future/future_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _Memory implements HealthRepository {
  HealthProfile? stored;

  @override
  Future<void> clear() async => stored = null;

  @override
  Future<HealthProfile?> load() async => stored;

  @override
  Future<void> save(HealthProfile profile) async => stored = profile;
}

void main() {
  final now = DateTime.utc(2026, 10, 21, 9);
  final sarah = HealthProfile.draft('Sarah', now: now);

  test('the next week is a calendar model with one confidence for every day', () {
    final week = seeAhead(sarah, now);
    expect(week.days, hasLength(8));
    expect(week.days.first.label, 'Today');
    expect(week.days[1].label, 'Tomorrow');
    expect(week.days[3].label, '3 days');
    expect(week.days[7].label, '7 days');
    expect(week.days.first.phase, 'Unknown');
    expect(week.days.first.energy, 'Not enough information yet');
    expect(week.days.first.event, contains('No period date'));
    expect(week.confidence, 'Not enough information yet');
    expect(week.note, contains('0 period dates'));
    final dated = seeAhead(sarah.copyWith(timingConfirmed: true), now);
    expect(dated.days.first.phase, 'Late follicular');
    expect(dated.days.first.energy, 'Higher estimate');
    expect(dated.days.first.event.toLowerCase(), contains('not contraception'));
    expect(dated.confidence, 'Low');
    expect(week.days[7].day, shiftDays(now, 7));
  });

  test('memory quotes an old sentence and only percentages a real drop', () {
    final remembered = sarah.copyWith(
      logs: [
        for (final offset in [-100, -90, -80, -70]) DailyLog(day: isoDay(shiftDays(now, offset)), symptoms: const ['cramp']),
        DailyLog(day: isoDay(shiftDays(now, -5)), symptoms: const ['cramp']),
      ],
      chat: [
        ChatTurn(role: 'you', text: 'My cramps were terrible.', at: shiftDays(now, -90).toIso8601String()),
      ],
    );
    final memory = recall(remembered, now);
    expect(memory.fromNotes, isTrue);
    expect(memory.line, contains('75%'));
    expect(memory.line, contains('My cramps were terrible.'));
    expect(memory.line.toLowerCase(), contains('not a measurement'));

    final waiting = recall(sarah, now);
    expect(waiting.fromNotes, isFalse);
    expect(waiting.line.toLowerCase(), contains('two different months'));
  });

  test('discoveries and the coach refuse invented precision', () {
    final logged = sarah.copyWith(
      logs: [
        DailyLog(day: isoDay(shiftDays(now, -10)), symptoms: const ['acne', 'insomnia']),
        DailyLog(day: isoDay(shiftDays(now, -3)), symptoms: const ['acne', 'insomnia']),
      ],
    );
    expect(discoveries(logged, now).join(' '), contains('neighborhood'));
    expect(coachLine(sarah, now), isNot(contains('15%')));
    expect(coachLine(sarah, now).toLowerCase(), isNot(contains('diagnos')));
    expect(stageLine('teen').toLowerCase(), isNot(contains('sex')));
    expect(stageLine('perimenopause').toLowerCase(), contains('not a diagnosis'));
  });

  test('wellbeing stays blank until life notes exist, and a heavy week is not a highlight', () {
    expect(wellbeing(sarah, now).score, isNull);
    expect(wellbeing(sarah, now).caption, contains('will not turn the calendar'));

    final mood = sarah.copyWith(logs: [DailyLog(day: isoDay(now), mood: 'calm')]);
    final index = wellbeing(mood, now);
    expect(index.score, isNull);
    expect(index.caption, contains('No wellbeing number'));
    expect(index.parts.firstWhere((part) => part.name == 'Mind').detail, contains('1 mood note'));
    expect(index.parts.firstWhere((part) => part.name == 'Sleep').score, isNull);

    final heavy = sarah.copyWith(logs: [const DailyLog(day: '2026-10-21', flow: 3)]);
    final report = healthReports(heavy, now).first;
    expect(report.lines.join(' '), contains('clinician'));
    expect(report.shareText.toLowerCase(), isNot(contains('method')));
    expect(report.shareText, contains('does not post'));
  });

  test('menopause and pregnancy do not borrow a cycle forecast', () {
    final menopause = seeAhead(sarah.copyWith(focus: 'menopause'), now);
    expect(menopause.days.first.event, contains('Heat'));
    expect(menopause.days.first.symptom.toLowerCase(), contains('guess'));

    final pregnant = seeAhead(
      sarah.copyWith(pregnant: true, pregnancyLmp: DateTime.utc(2026, 7, 29)),
      now,
    );
    expect(pregnant.days.first.energy, 'Led by pregnancy');
    expect(pregnant.confidence, 'Not a cycle score');
  });

  testWidgets('the future page can be read', (tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = EvaController(repository: _Memory(), clock: () => now);
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      EvaScope(
        controller: controller,
        child: MaterialApp(
          theme: evaTheme(EvaPalette.darkTheme),
          home: const FuturePage(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('See your next 7 days'), findsOneWidget);
    expect(find.textContaining('Not enough information yet'), findsWidgets);
    expect(find.textContaining('No wellbeing number'), findsOneWidget);
  });
}
