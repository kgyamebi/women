import 'dart:async';

import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';

const milestoneCopy = <String, String>{
  'first-log': 'First rhythm note',
  'first-question': 'First question for EVA',
  'twin': 'Hormone twin opened',
  'streak3': 'Three quiet days',
  'focus': 'A focus chosen',
  'wearable': 'A night previewed',
  'meal': 'Ate with the phase',
  'workout': 'Moved with the phase',
  'lab': 'A lab translated',
};

class EvaController extends ChangeNotifier {
  EvaController({required this.repository, DateTime Function()? clock}) : now = clock ?? DateTime.now;

  final HealthRepository repository;
  final DateTime Function() now;

  HealthProfile profile = HealthProfile.draft('');
  bool ready = false;
  String? toast;
  Timer? _toastTimer;

  DailyBrief get brief => buildBrief(profile, now());

  ThemeMode get themeMode {
    switch (profile.theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> boot() async {
    final watch = Stopwatch()..start();
    try {
      final loaded = await repository.load();
      if (loaded != null && loaded.name.trim().isNotEmpty) {
        profile = loaded;
      }
    } catch (_) {
      profile = HealthProfile.draft('');
    }
    final remaining = 1500 - watch.elapsedMilliseconds;
    if (remaining > 0) {
      await Future<void>.delayed(Duration(milliseconds: remaining));
    }
    ready = true;
    notifyListeners();
  }

  void setName(String raw) {
    final name = raw.trim();
    if (name.isEmpty) return;
    if (profile.name.isEmpty) {
      profile = HealthProfile.draft(name, now: now());
      flash('Welcome, $name');
    } else {
      profile = profile.copyWith(name: name, communityAlias: aliasFor(name));
      flash('Name saved');
    }
    _commit();
  }

  void setTheme(String theme) {
    profile = profile.copyWith(theme: theme);
    flash(switch (theme) {
      'dark' => 'Dark',
      'light' => 'Light',
      _ => 'Following the system',
    });
    _commit();
  }

  void confirmTiming({required int daysAgo, required int length, required bool regular}) {
    final start = shiftDays(now(), -daysAgo.clamp(0, 80));
    profile = profile.copyWith(
      lastPeriodStart: start,
      cycleLength: length,
      regular: regular,
      timingConfirmed: true,
      answered: _withAnswer('timing'),
    );
    flash('Rhythm updated');
    _commit();
  }

  void setIntentions(List<String> ids) {
    var focus = 'cycle';
    var regular = profile.regular;
    if (ids.contains('pregnant')) {
      profile = profile.copyWith(
        intentions: ids,
        pregnant: true,
        focus: 'pregnancy',
        pregnancyLmp: profile.pregnancyLmp ?? profile.lastPeriodStart,
        answered: _withAnswer('intention'),
      );
      flash('Focus updated');
      _commit();
      return;
    }
    if (ids.contains('menopause')) {
      focus = 'menopause';
      regular = false;
    } else if (ids.contains('pcos')) {
      focus = 'pcos';
      regular = false;
    } else if (ids.contains('conceive')) {
      focus = 'fertility';
    } else if (ids.contains('mind')) {
      focus = 'mental';
    }
    profile = profile.copyWith(
      intentions: ids,
      focus: focus,
      regular: regular,
      answered: _withAnswer('intention'),
    );
    flash('Focus updated');
    _commit();
  }

  void setContexts(List<String> ids) {
    final cleared = ids.contains('none') || ids.isEmpty;
    final contexts = cleared ? const <String>[] : ids.where((id) => id != 'none').toList();
    var regular = profile.regular;
    var pregnant = profile.pregnant;
    var focus = profile.focus;
    DateTime? lmp = profile.pregnancyLmp;
    if (cleared) {
      regular = true;
    } else {
      if (contexts.contains('pcos') || contexts.contains('irregular') || contexts.contains('menopause')) {
        regular = false;
      }
      if (contexts.contains('menopause')) focus = 'menopause';
      if (contexts.contains('pcos')) focus = 'pcos';
      if (contexts.contains('pregnant')) {
        pregnant = true;
        focus = 'pregnancy';
        lmp ??= profile.lastPeriodStart;
      }
    }
    profile = profile.copyWith(
      contexts: contexts,
      regular: regular,
      pregnant: pregnant,
      focus: focus,
      answered: _withAnswer('context'),
    );
    if (lmp != null && pregnant) {
      profile = profile.copyWith(pregnancyLmp: lmp);
    }
    flash('Context saved');
    _commit();
  }

  void setFocus(String focus) {
    profile = profile.copyWith(focus: focus);
    _award('focus');
    flash(_focusLine(focus));
    _commit();
  }

  void confirmPregnancy(int daysAgo) {
    final lmp = shiftDays(now(), -daysAgo.clamp(0, 320));
    profile = profile.copyWith(
      pregnant: true,
      pregnancyLmp: lmp,
      lastPeriodStart: lmp,
      focus: 'pregnancy',
      timingConfirmed: true,
    );
    flash('Pregnancy is leading the day');
    _commit();
  }

  void clearPregnancy() {
    profile = profile.copyWith(pregnant: false, focus: 'cycle');
    flash('Cycle is the focus');
    _commit();
  }

  void answer(String id) {
    profile = profile.copyWith(answered: _withAnswer(id));
    flash('Kept as it is');
    _commit();
  }

  void updateToday({
    int? flow,
    String? mood,
    String? stress,
    double? energy,
    bool setEnergy = false,
    List<String>? symptoms,
  }) {
    final day = isoDay(dateOnly(now()));
    final logs = [...profile.logs];
    final index = logs.indexWhere((log) => log.day == day);
    var next = index >= 0 ? logs[index] : DailyLog(day: day);
    if (flow != null) next = next.copyWith(flow: flow);
    if (mood != null) next = next.copyWith(mood: mood);
    if (stress != null) next = next.copyWith(stress: stress);
    if (setEnergy) next = next.copyWith(energy: energy);
    if (symptoms != null) next = next.copyWith(symptoms: symptoms);
    if (index >= 0) {
      logs[index] = next;
    } else {
      logs.add(next);
    }
    profile = profile.copyWith(logs: logs);
    _touchStreak();
    _award('first-log');
    _commit();
  }

  void dismissWhisper(String id) {
    if (profile.dismissed.contains(id)) return;
    profile = profile.copyWith(dismissed: [...profile.dismissed, id]);
    _commit();
  }

  void ask(String text) {
    final clean = text.trim();
    if (clean.isEmpty) return;
    final reply = copilotReply(profile: profile, brief: brief, question: clean);
    final at = now().toIso8601String();
    profile = profile.copyWith(
      chat: [
        ...profile.chat,
        ChatTurn(role: 'you', text: clean, at: at),
        ChatTurn(role: 'eva', text: reply, at: at),
      ],
    );
    _award('first-question');
    _commit();
  }

  void noteTwinOpened() => _award('twin');

  void addKick() {
    final day = isoDay(dateOnly(now()));
    final count = profile.kicksDay == day ? profile.kicks + 1 : 1;
    profile = profile.copyWith(kicksDay: day, kicks: count);
    _touchStreak();
    flash('Kick noted');
    _commit();
  }

  void addContraction(DateTime start, DateTime end) {
    profile = profile.copyWith(
      contractions: [
        ...profile.contractions,
        ContractionSpan(start: start.toIso8601String(), end: end.toIso8601String()),
      ],
    );
    flash('Contraction saved');
    _commit();
  }

  void clearContractions() {
    profile = profile.copyWith(contractions: const []);
    flash('Session cleared');
    _commit();
  }

  void logHotFlash(bool strong) {
    profile = profile.copyWith(
      hotFlashes: [...profile.hotFlashes, HotFlash(at: now().toIso8601String(), strong: strong)],
    );
    _touchStreak();
    flash(strong ? 'Strong flash logged' : 'Gentle flash logged');
    _commit();
  }

  void logBbt(double celsius) {
    final day = isoDay(dateOnly(now()));
    final points = [...profile.bbt]..removeWhere((point) => point.day == day);
    points.add(BbtPoint(day: day, celsius: celsius));
    profile = profile.copyWith(bbt: points);
    _touchStreak();
    flash('Temperature saved');
    _commit();
  }

  void setMucus(String mucus) {
    profile = profile.copyWith(mucus: mucus);
    _touchStreak();
    _commit();
  }

  void toggleIntimacy() {
    final day = isoDay(dateOnly(now()));
    final days = [...profile.intimacyDays];
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    profile = profile.copyWith(intimacyDays: days);
    _commit();
  }

  void togglePcos(String flag) {
    final day = isoDay(dateOnly(now()));
    final days = [...profile.pcosDays];
    final index = days.indexWhere((item) => item.day == day);
    final flags = index >= 0 ? [...days[index].flags] : <String>[];
    if (flags.contains(flag)) {
      flags.remove(flag);
    } else {
      flags.add(flag);
    }
    final next = DayFlags(day: day, flags: flags);
    if (index >= 0) {
      days[index] = next;
    } else {
      days.add(next);
    }
    profile = profile.copyWith(pcosDays: days);
    _touchStreak();
    _commit();
  }

  void logWeight(double kg) {
    final day = isoDay(dateOnly(now()));
    final points = [...profile.weights]..removeWhere((point) => point.day == day);
    points.add(WeightPoint(day: day, kg: kg));
    profile = profile.copyWith(weights: points);
    flash('Weight saved');
    _commit();
  }

  void addAppointment(String label) {
    final clean = label.trim();
    if (clean.isEmpty) return;
    profile = profile.copyWith(appointments: [...profile.appointments, clean]);
    flash('Visit remembered');
    _commit();
  }

  void removeAppointment(String label) {
    final next = [...profile.appointments]..remove(label);
    profile = profile.copyWith(appointments: next);
    flash('Visit removed');
    _commit();
  }

  void toggleBirth(String id) {
    final next = [...profile.birthPrep];
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    profile = profile.copyWith(birthPrep: next);
    _commit();
  }

  void noteMeal() {
    final day = isoDay(dateOnly(now()));
    if (profile.mealsNoted.contains(day)) return;
    final known = profile.milestones.contains('meal');
    profile = profile.copyWith(mealsNoted: [...profile.mealsNoted, day]);
    _award('meal');
    if (known) flash('Saved for today');
    _commit();
  }

  void noteWorkout() {
    final day = isoDay(dateOnly(now()));
    if (profile.workouts.contains(day)) return;
    final known = profile.milestones.contains('workout');
    profile = profile.copyWith(workouts: [...profile.workouts, day]);
    _touchStreak();
    _award('workout');
    if (known) flash('Saved for today');
    _commit();
  }

  void openLab(String id) {
    if (!profile.labsOpened.contains(id)) {
      profile = profile.copyWith(labsOpened: [...profile.labsOpened, id]);
    }
    _award('lab');
    _commit();
  }

  void setWearable(bool enabled) {
    profile = profile.copyWith(wearableSample: enabled);
    if (enabled) _award('wearable');
    flash(enabled ? 'Sample night on' : 'Sample night off');
    _commit();
  }

  void setLocalFirst(bool enabled) {
    profile = profile.copyWith(localFirst: enabled);
    _commit();
  }

  void setCommunityVerified(bool enabled) {
    profile = profile.copyWith(communityVerified: enabled);
    _commit();
  }

  void publish(String space, String body) {
    final text = body.trim();
    if (text.isEmpty) return;
    profile = profile.copyWith(
      posts: [
        ...profile.posts,
        CommunityPost(
          id: now().microsecondsSinceEpoch.toString(),
          space: space,
          author: profile.communityVerified ? profile.name : profile.communityAlias,
          body: text,
          verified: profile.communityVerified,
          mine: true,
        ),
      ],
    );
    flash('Shared in $space');
    _commit();
  }

  Future<void> deleteAll() async {
    _toastTimer?.cancel();
    toast = null;
    profile = HealthProfile.draft('');
    try {
      await repository.clear();
    } catch (_) {}
    notifyListeners();
  }

  List<String> _withAnswer(String id) {
    if (profile.answered.contains(id)) return profile.answered;
    return [...profile.answered, id];
  }

  void _touchStreak() {
    final today = isoDay(dateOnly(now()));
    if (profile.streakDay == today) return;
    final yesterday = isoDay(shiftDays(now(), -1));
    final next = profile.streakDay == yesterday ? profile.streak + 1 : 1;
    profile = profile.copyWith(streak: next, streakDay: today);
    if (next >= 3) _award('streak3');
  }

  void flash(String message) {
    toast = message;
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(milliseconds: 2200), () {
      toast = null;
      notifyListeners();
    });
  }

  String _focusLine(String focus) {
    return switch (focus) {
      'pregnancy' => 'Pregnancy is the focus',
      'fertility' => 'Fertility is the focus',
      'pcos' => 'PCOS is the focus',
      'menopause' => 'Menopause is the focus',
      'mental' => 'Mind is the focus',
      'beauty' => 'Skin is the focus',
      'fitness' => 'Strength is the focus',
      'nutrition' => 'Food is the focus',
      _ => 'Cycle is the focus',
    };
  }

  void _award(String id) {
    if (profile.milestones.contains(id) || !milestoneCopy.containsKey(id)) return;
    profile = profile.copyWith(milestones: [...profile.milestones, id]);
    toast = milestoneCopy[id];
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(milliseconds: 2600), () {
      toast = null;
      notifyListeners();
    });
  }

  void _commit() {
    notifyListeners();
    repository.save(profile);
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }
}

class EvaScope extends InheritedNotifier<EvaController> {
  const EvaScope({required EvaController controller, required super.child, super.key}) : super(notifier: controller);

  static EvaController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<EvaScope>();
    assert(scope != null, 'EvaScope is missing');
    return scope!.notifier!;
  }
}
