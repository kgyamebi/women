import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/domain/domain.dart';
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
  test('every logged action confirms and persists', () async {
    final repo = _Memory();
    final clock = DateTime.utc(2026, 10, 21, 9);
    final controller = EvaController(repository: repo, clock: () => clock);
    addTearDown(controller.dispose);
    controller.affirmAge();
    controller.acceptHealthConsent();

    controller.setName('Sarah');
    expect(controller.profile.name, 'Sarah');
    expect(controller.toast, 'Welcome, Sarah');
    controller.setIntentions(const ['pregnant']);
    expect(controller.profile.pregnant, isTrue);
    expect(controller.profile.pregnancyLmp, isNull);
    expect(controller.brief.pregnancy, isNull);

    controller.confirmTiming(daysAgo: 11, length: 28, regular: true);
    expect(controller.toast, 'Rhythm updated');
    expect(controller.brief.cycle.phase, CyclePhase.lateFollicular);
    expect(controller.brief.cycle.day, 12);

    controller.addAppointment('   ');
    expect(controller.profile.appointments, isEmpty);
    controller.addAppointment('Dating scan');
    expect(controller.toast, 'Visit remembered');
    controller.removeAppointment('Dating scan');
    expect(controller.profile.appointments, isEmpty);
    expect(controller.toast, 'Visit removed');

    controller.publish('Rhythm', '   ');
    expect(controller.profile.posts, isEmpty);
    controller.publish('Rhythm', 'A walk helped the cramp.');
    expect(controller.profile.posts, hasLength(1));
    expect(controller.toast, 'Shared in Rhythm');

    controller.setFocus('pregnancy');
    expect(controller.toast, 'Pregnancy is the focus');
    controller.setFocus('cycle');
    expect(controller.toast, 'Cycle is the focus');
    controller.hear("I'm exhausted.");
    expect(controller.profile.logOn('2026-10-21')?.mood, 'low');
    controller.hear('Should I continue treatment');
    expect(controller.profile.chat.last.text.toLowerCase(), isNot(contains('appetite is data')));

    controller.logBbt(36.6);
    controller.logWeight(64);
    expect(controller.profile.bbt, hasLength(1));
    expect(controller.profile.weights, hasLength(1));
    await controller.saved;
    expect(repo.stored?.name, 'Sarah');
  });
}
