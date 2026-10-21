import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:eva_ai/features/connect/connect_page.dart';
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
    final sarah = HealthProfile.draft('Sarah', now: now).copyWith(timingConfirmed: true);

  test('a new person sees nothing', () {
    const person = CirclePerson(id: '1', name: 'Alex', role: 'partner');
    final view = partnerView(sarah, person, now);
    expect(view.closed, isTrue);
    expect(view.overview, contains('Nothing is shared'));
    expect(view.lines, isEmpty);
    expect(view.crisis, isFalse);
    expect(view.brief, contains('No daily brief'));
  });

  test('phase appears only after it is granted, and disappears when revoked', () {
    const closed = CirclePerson(id: '1', name: 'Alex', role: 'partner');
    final granted = closed.copyWith(permissions: const ['phase', 'energy', 'support']);
    final open = partnerView(sarah, granted, now);
    expect(open.lines.join(' '), contains('Estimate'));
    expect(open.lines.join(' '), contains('Late follicular'));
    expect(open.support, isNotEmpty);
    expect(open.brief, isNot(contains('No daily brief')));

    final revoked = granted.copyWith(permissions: const ['support']);
    final after = partnerView(sarah, revoked, now);
    expect(after.lines.join(' '), isNot(contains('follicular')));
    expect(after.lines.join(' '), isNot(contains('Energy')));
    expect(after.support, isNotEmpty);
  });

  test('a severe note reaches a trusted contact without a diagnosis or a method', () {
    final heavy = sarah.copyWith(
      logs: [DailyLog(day: isoDay(now), flow: 3, symptoms: const ['soaking'])],
    );
    const trusted = CirclePerson(id: '1', name: 'Alex', role: 'caregiver', permissions: ['symptoms', 'support']);
    final view = partnerView(heavy, trusted, now);
    expect(view.crisis, isTrue);
    final reply = partnerReply(
      profile: heavy,
      person: trusted,
      now: now,
      question: 'I want to die',
    );
    expect(reply, contains('988'));
    expect(reply.toLowerCase(), contains('not a diagnosis'));
    expect(reply.toLowerCase(), isNot(contains('method')));
  });

  test('fertility stays hidden until granted, and is not called contraception', () {
    const person = CirclePerson(id: '1', name: 'Alex', role: 'ttc', permissions: ['phase']);
    final hidden = partnerReply(profile: sarah, person: person, now: now, question: 'When is ovulation?');
    expect(hidden, contains('not shared'));
    final granted = person.copyWith(permissions: const ['fertility']);
    final reply = partnerReply(profile: sarah, person: granted, now: now, question: 'When is ovulation?');
    expect(reply.toLowerCase(), contains('not contraception'));
  });

  testWidgets('the circle stays closed until a permission is granted', (tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = EvaController(
      repository: _Memory(),
      clock: () => DateTime.utc(2026, 10, 21, 9),
    );
    addTearDown(controller.dispose);
    controller.setName('Sarah');

    await tester.pumpWidget(
      EvaScope(
        controller: controller,
        child: MaterialApp(
          theme: evaTheme(EvaPalette.darkTheme),
          home: const ConnectPage(),
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField).first, 'Alex');
    await tester.tap(find.text('Add to the circle'));
    await tester.pump();
    expect(find.textContaining('Nothing is shared with Alex'), findsOneWidget);

    final phase = find.text('Current phase').hitTestable();
    for (var i = 0; phase.evaluate().isEmpty && i < 12; i++) {
      await tester.dragFrom(const Offset(400, 500), const Offset(0, -340));
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(phase, findsOneWidget);
    await tester.tap(phase);
    await tester.pump();
    expect(find.textContaining('No period date is saved'), findsWidgets);

    await tester.tap(find.text('Current phase').hitTestable());
    await tester.pump();
    expect(find.textContaining('Late follicular'), findsNothing);
    expect(find.textContaining('No health detail is visible'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2300));
  });

  test('the relationship twin celebrates and does not grade', () {
    const person = CirclePerson(id: '1', name: 'Alex', role: 'partner', checkIns: 2, missionDays: ['a', 'b'], goals: ['Sleep']);
    final twin = relationshipTwin(person);
    expect(twin.showingUp, contains('Showing up'));
    expect(twin.support.toLowerCase(), contains('not a grade'));
    expect(twin.insight.toLowerCase(), isNot(contains('fail')));
  });
}
