import 'package:eva_ai/app/eva_app.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/domain/domain.dart';
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
  testWidgets('desktop controls answer', (tester) async {
    await _walk(tester, const Size(1280, 800));
  });

  testWidgets('phone controls answer', (tester) async {
    await _walk(tester, const Size(390, 844));
  });
}

Future<void> _walk(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(EvaApp(repository: _Memory()));
  await tester.pump(const Duration(milliseconds: 1700));
  await tester.pump(const Duration(milliseconds: 800));
  _check(tester);

  expect(find.text('What should I call you?'), findsOneWidget);
  await tester.enterText(find.byType(TextField), 'Sarah');
  await tester.pump();
  await tester.tap(find.text('Enter'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 800));
  _check(tester);

  expect(find.text('Sarah'), findsWidgets);
  expect(find.textContaining('follicular'), findsWidgets);

  await _nav(tester, 'Rhythm');
  expect(find.text('A calendar, not a blood test').hitTestable(), findsOneWidget);
  await _reveal(tester, size, 'Headache');
  await tester.tap(find.text('Headache').hitTestable());
  await tester.pump();
  _check(tester);

  await _nav(tester, 'Ask');
  const prompt = 'Can PCOS cause weight gain?';
  await _reveal(tester, size, prompt);
  await tester.tap(find.text(prompt).hitTestable());
  await tester.pump();
  expect(find.textContaining('does not mean you have PCOS'), findsOneWidget);
  _check(tester);

  await _nav(tester, 'Twin');
  expect(find.text('A sketch of a cycle').hitTestable(), findsOneWidget);
  _check(tester);

  await _nav(tester, 'You');
  await _reveal(tester, size, 'Dark');
  await tester.tap(find.text('Dark').hitTestable());
  await tester.pump();
  expect(find.text('Dark').hitTestable(), findsWidgets);
  _check(tester);

  await _nav(tester, 'Today');
  await _reveal(tester, size, 'Pregnancy');
  await tester.tap(find.text('Pregnancy').hitTestable());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  expect(find.text('Reshape EVA around this'), findsOneWidget);
  await tester.tap(find.text('Reshape EVA around this'));
  await tester.pump();
  await _reveal(tester, size, 'Kick');
  await tester.tap(find.text('Kick').hitTestable());
  await tester.pump();
  expect(find.textContaining('Kick noted'), findsWidgets);
  await tester.tap(find.byIcon(Icons.arrow_back_rounded));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  _check(tester);
}

Future<void> _nav(WidgetTester tester, String label) async {
  await tester.tap(find.descendant(of: find.byType(EvaNav), matching: find.text(label)));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  _check(tester);
}

Future<void> _reveal(WidgetTester tester, Size size, String label) async {
  final target = find.text(label).hitTestable();
  for (var i = 0; i < 8 && target.evaluate().isEmpty; i++) {
    await tester.dragFrom(Offset(size.width / 2, size.height / 2), const Offset(0, -320));
    await tester.pump(const Duration(milliseconds: 200));
  }
  expect(target, findsOneWidget);
}

void _check(WidgetTester tester) {
  final exception = tester.takeException();
  if (exception != null) {
    fail('$exception');
  }
}
