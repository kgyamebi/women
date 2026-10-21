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
  final now = DateTime.utc(2026, 10, 21);

  test('usual notes wait for the same symptom twice', () {
    final once = HealthProfile.draft('A', now: now).copyWith(
      logs: const [DailyLog(day: '2026-10-20', symptoms: ['headache'])],
    );
    expect(usualNotes(once), isEmpty);

    final twice = once.copyWith(
      logs: [
        ...once.logs,
        const DailyLog(day: '2026-10-19', symptoms: ['headache', 'cramp']),
      ],
    );
    final notes = usualNotes(twice);
    expect(notes, hasLength(1));
    expect(notes.single.symptom, 'headache');
    expect(notes.single.count, 2);
  });

  test('the latest prior note skips today and empty days', () {
    final profile = HealthProfile.draft('A', now: now).copyWith(
      logs: const [
        DailyLog(day: '2026-10-21', symptoms: ['acne']),
        DailyLog(day: '2026-10-18', mood: 'low'),
        DailyLog(day: '2026-10-20'),
      ],
    );
    expect(latestPriorLog(profile, now)?.day, '2026-10-18');
  });

  test('old profiles load with no shortcuts', () {
    final profile = HealthProfile.fromJson({'name': 'Sarah'});
    expect(profile.shortcuts, isEmpty);
  });

  test('nothing new copies a real note and undo restores the day', () async {
    final controller = EvaController(repository: _Memory(), clock: () => now);
    controller.profile = HealthProfile.draft('A', now: now).copyWith(
      logs: const [DailyLog(day: '2026-10-18', mood: 'low', symptoms: ['cramp'])],
      ageAffirmed: true,
      healthConsentAt: '2026-10-21T00:00:00.000Z',
    );
    controller.nothingNew();
    final today = controller.profile.logOn('2026-10-21');
    expect(today?.mood, 'low');
    expect(today?.symptoms, ['cramp']);
    controller.undoLazy();
    expect(controller.profile.logOn('2026-10-21'), isNull);
    await controller.saved;
  });

  test('a shortcut fills only empty fields', () {
    final controller = EvaController(repository: _Memory(), clock: () => now);
    controller.affirmAge();
    controller.acceptHealthConsent();
    controller.profile = HealthProfile.draft('A', now: now);
    controller.affirmAge();
    controller.acceptHealthConsent();
    controller.updateToday(mood: 'calm', symptoms: const ['headache']);
    controller.saveTodayShortcut();
    expect(controller.profile.shortcuts.single.name, 'Calm, Headache');
    controller.updateToday(mood: 'bright');
    controller.applyShortcut(controller.profile.shortcuts.single.id);
    final today = controller.profile.logOn('2026-10-21');
    expect(today?.mood, 'bright');
    expect(today?.symptoms, contains('headache'));
  });

  test('health notes stay off without consent, and an older revision cannot overwrite', () {
    final controller = EvaController(repository: _Memory(), clock: () => now);
    controller.updateToday(mood: 'low');
    expect(controller.profile.logs, isEmpty);
    expect(controller.toast, contains('16 or older'));

    final older = HealthProfile.draft('A', now: now).copyWith(revision: 2);
    final newer = older.copyWith(revision: 5);
    expect(saveWouldOverwriteNewer(newer, older), isTrue);
    expect(saveWouldOverwriteNewer(older, newer), isFalse);
    expect(saveWouldOverwriteNewer(null, older), isFalse);
  });
}
