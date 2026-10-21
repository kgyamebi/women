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
  String? saveError;
  int? requestedSection;
  Timer? _toastTimer;
  bool _holdSaves = false;
  Future<void> _queue = Future<void>.value();
  DailyLog? _lazyUndo;
  bool _lazyHadLog = false;
  bool _keepUndo = false;
  bool _lazyAddedWater = false;
  bool _lazyAddedMove = false;
  bool minorBlocked = false;
  final List<DateTime> _writes = [];

  bool get canUndoLazy => _lazyHadLog || _lazyUndo != null;

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
    try {
      final loaded = await repository.load();
      if (loaded != null && loaded.name.trim().isNotEmpty) {
        profile = loaded;
      }
    } catch (_) {
      _holdSaves = true;
      saveError = 'The saved profile could not be read. It was not overwritten.';
    }
    ready = true;
    notifyListeners();
  }

  Future<void> retryLoad() async {
    _holdSaves = false;
    saveError = null;
    ready = false;
    notifyListeners();
    await boot();
  }

  void setName(String raw) {
    final name = raw.trim().replaceAll(RegExp(r'[\u0000-\u001F]'), '');
    if (name.isEmpty) return;
    final clipped = name.length > 40 ? name.substring(0, 40) : name;
    if (profile.name.isEmpty) {
      profile = HealthProfile.draft(clipped, now: now()).copyWith(
        ageAffirmed: profile.ageAffirmed,
        healthConsentAt: profile.healthConsentAt,
        audit: profile.audit,
        revision: profile.revision,
        theme: profile.theme,
      );
      flash('Welcome, $clipped');
    } else {
      profile = profile.copyWith(name: clipped, communityAlias: aliasFor(clipped));
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
    if (!_guardHealth()) return;
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
    if (!_guardHealth()) return;
    var focus = 'cycle';
    var regular = profile.regular;
    if (ids.contains('pregnant')) {
      profile = profile.copyWith(
        intentions: ids,
        pregnant: true,
        focus: 'pregnancy',
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

  void affirmAge() {
    minorBlocked = false;
    profile = profile.copyWith(ageAffirmed: true);
    notifyListeners();
  }

  void blockMinor() {
    minorBlocked = true;
    profile = profile.copyWith(ageAffirmed: false, healthConsentAt: null);
    notifyListeners();
  }

  void clearMinorBlock() {
    minorBlocked = false;
    notifyListeners();
  }

  void acceptHealthConsent() {
    if (!profile.ageAffirmed || minorBlocked) return;
    final at = now().toIso8601String();
    final audit = [...profile.audit, 'consent $at'];
    profile = profile.copyWith(
      healthConsentAt: at,
      audit: audit.length > 40 ? audit.sublist(audit.length - 40) : audit,
    );
    _commit();
  }

  bool _guardHealth() {
    if (profile.healthReady) return true;
    flash('Health notes stay off until you are 16 or older and agree to on-device storage.');
    return false;
  }

  bool _guardRate() {
    final cut = now().subtract(const Duration(minutes: 1));
    _writes.removeWhere((time) => time.isBefore(cut));
    if (_writes.length >= 30) {
      flash('Too many notes in a minute. Wait, then try again. Nothing was discarded.');
      return false;
    }
    _writes.add(now());
    return true;
  }

  void updateToday({
    int? flow,
    String? mood,
    String? stress,
    double? energy,
    bool setEnergy = false,
    List<String>? symptoms,
  }) {
    if (!_guardHealth() || !_guardRate()) return;
    if (!_keepUndo) {
      _lazyUndo = null;
      _lazyHadLog = false;
      _lazyAddedWater = false;
      _lazyAddedMove = false;
    }
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

  void repeatYesterday() {
    final previous = profile.logOn(isoDay(shiftDays(now(), -1)));
    if (previous == null) return;
    updateToday(
      flow: previous.flow,
      mood: previous.mood,
      stress: previous.stress,
      energy: previous.energy,
      setEnergy: true,
      symptoms: [...previous.symptoms],
    );
    flash('Today matches yesterday');
    _commit();
  }

  void _armUndo() {
    final existing = profile.logOn(isoDay(dateOnly(now())));
    _lazyUndo = existing;
    _lazyHadLog = true;
    _lazyAddedWater = false;
    _lazyAddedMove = false;
  }

  void _copyOntoToday(DailyLog source, String message, {required bool blanksOnly}) {
    final today = profile.logOn(isoDay(dateOnly(now())));
    final empty = today == null || !logHasContent(today);
    _armUndo();
    _keepUndo = true;
    if (empty || !blanksOnly) {
      updateToday(
        flow: source.flow,
        mood: source.mood,
        stress: source.stress,
        energy: source.energy,
        setEnergy: true,
        symptoms: [...source.symptoms],
      );
    } else {
      updateToday(
        mood: today.mood.isEmpty ? source.mood : null,
        stress: today.stress.isEmpty ? source.stress : null,
        energy: today.energy,
        setEnergy: today.energy == null && source.energy != null,
        symptoms: {...today.symptoms, ...source.symptoms}.toList(),
      );
    }
    _keepUndo = false;
    flash(message);
    _commit();
  }

  void nothingNew() {
    if (profile.shortcuts.isNotEmpty) {
      applyShortcut(profile.shortcuts.last.id);
      return;
    }
    final prior = latestPriorLog(profile, now());
    if (prior == null) {
      flash('Log once. After that, Nothing new can copy it.');
      return;
    }
    _copyOntoToday(prior, 'Copied your note from ${prior.day}. Undo if today is different.', blanksOnly: true);
  }

  void copyLastNote() {
    final prior = latestPriorLog(profile, now());
    final yesterday = isoDay(shiftDays(now(), -1));
    if (prior == null || prior.day == yesterday) return;
    _copyOntoToday(prior, 'Copied your note from ${prior.day}. Undo if today is different.', blanksOnly: true);
  }

  void saveTodayShortcut() {
    final today = profile.logOn(isoDay(dateOnly(now())));
    if (today == null || !logHasContent(today)) {
      flash('Nothing to save yet. One note is enough.');
      return;
    }
    final name = shortcutLabel(today);
    if (name.isEmpty || profile.shortcuts.any((shortcut) => shortcut.name == name)) {
      flash('That shortcut is already saved.');
      return;
    }
    final next = [
      ...profile.shortcuts,
      LogShortcut(
        id: '${profile.shortcuts.length}-$name',
        name: name,
        flow: today.flow,
        mood: today.mood,
        stress: today.stress,
        energy: today.energy,
        symptoms: [...today.symptoms],
      ),
    ];
    profile = profile.copyWith(shortcuts: next.length > 8 ? next.sublist(next.length - 8) : next);
    flash('Saved "$name". Next time it is one tap.');
    _commit();
  }

  void applyShortcut(String id) {
    LogShortcut? shortcut;
    for (final item in profile.shortcuts) {
      if (item.id == id) shortcut = item;
    }
    if (shortcut == null) return;
    _copyOntoToday(
      DailyLog(
        day: '',
        flow: shortcut.flow,
        mood: shortcut.mood,
        stress: shortcut.stress,
        energy: shortcut.energy,
        symptoms: [...shortcut.symptoms],
      ),
      'Copied your shortcut "${shortcut.name}" onto today. Undo if today is different.',
      blanksOnly: true,
    );
  }

  void removeShortcut(String id) {
    profile = profile.copyWith(shortcuts: profile.shortcuts.where((shortcut) => shortcut.id != id).toList());
    flash('Shortcut removed. Your logs are still here.');
    _commit();
  }

  void addUsual(String symptom) {
    final today = profile.logOn(isoDay(dateOnly(now())));
    if (today != null && today.symptoms.contains(symptom)) {
      flash('${noteLabel(symptom)} is already on today.');
      return;
    }
    _armUndo();
    _keepUndo = true;
    updateToday(symptoms: {...?today?.symptoms, symptom}.toList());
    _keepUndo = false;
    flash('Added ${noteLabel(symptom)} from your notes. Undo if today is different.');
    _commit();
  }

  void markWater() {
    final day = isoDay(dateOnly(now()));
    final today = profile.logOn(day);
    if (today != null && today.symptoms.contains('water')) {
      flash('Water is already on today.');
      return;
    }
    _armUndo();
    if (!profile.mealsNoted.contains(day)) {
      profile = profile.copyWith(mealsNoted: [...profile.mealsNoted, day]);
      _lazyAddedWater = true;
    }
    _keepUndo = true;
    updateToday(symptoms: {...?today?.symptoms, 'water'}.toList());
    _keepUndo = false;
    flash('Water noted for today. Undo if that was a slip.');
    _commit();
  }

  void markMoved() {
    if (!_guardHealth()) return;
    final day = isoDay(dateOnly(now()));
    if (profile.workouts.contains(day)) {
      flash('Movement is already on today.');
      return;
    }
    _armUndo();
    profile = profile.copyWith(workouts: [...profile.workouts, day]);
    _lazyAddedMove = true;
    flash('Movement noted for today. Undo if that was a slip.');
    _touchStreak();
    _award('workout');
    _commit();
  }

  void undoLazy() {
    if (!canUndoLazy) return;
    final day = isoDay(dateOnly(now()));
    final logs = [...profile.logs]..removeWhere((log) => log.day == day);
    final previous = _lazyUndo;
    if (previous != null) logs.add(previous);
    var next = profile.copyWith(logs: logs);
    if (_lazyAddedWater) {
      next = next.copyWith(mealsNoted: next.mealsNoted.where((item) => item != day).toList());
    }
    if (_lazyAddedMove) {
      next = next.copyWith(workouts: next.workouts.where((item) => item != day).toList());
    }
    profile = next;
    _lazyUndo = null;
    _lazyHadLog = false;
    _lazyAddedWater = false;
    _lazyAddedMove = false;
    flash('Put today back the way it was.');
    _commit();
  }

  void dismissWhisper(String id) {
    if (profile.dismissed.contains(id)) return;
    profile = profile.copyWith(dismissed: [...profile.dismissed, id]);
    _commit();
  }

  void requestSection(int index) {
    requestedSection = index;
    notifyListeners();
  }

  void noteSeen(String id) {
    final key = 'seen:$id';
    if (profile.answered.contains(key)) return;
    profile = profile.copyWith(answered: [...profile.answered, key]);
    _commit();
  }

  void say(String message) {
    flash(message);
    notifyListeners();
  }

  void hear(String raw) {
    if (!_guardHealth()) return;
    final text = raw.trim();
    if (text.isEmpty) return;
    if (text.length > 2000) {
      flash('That note is too long. Shorten it and send it again.');
      return;
    }
    if (looksLikeCrisis(text)) {
      ask(text);
      requestSection(2);
      return;
    }
    final words = text
        .toLowerCase()
        .replaceAll(RegExp("[^a-z0-9\\s']"), ' ')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toSet();
    final today = profile.logOn(isoDay(dateOnly(now())));
    final symptoms = <String>{...today?.symptoms ?? const []};
    String? mood;
    String? stress;
    double? energy;
    var setEnergy = false;
    var noted = false;

    void mark() => noted = true;
    if (words.any((word) => const {'exhausted', 'tired', 'wiped', 'drained'}.contains(word))) {
      mood = 'low';
      energy = 0.25;
      setEnergy = true;
      mark();
    }
    if (words.contains('cramp') || words.contains('cramps')) {
      symptoms.add('cramp');
      mark();
    }
    if (words.contains('headache') || words.contains('migraine')) {
      symptoms.add('headache');
      mark();
    }
    if (words.contains('acne') || words.contains('breakout') || words.contains('pimple')) {
      symptoms.add('acne');
      mark();
    }
    if (words.contains('anxious') || words.contains('anxiety')) {
      mood = 'frayed';
      stress = 'loud';
      mark();
    }
    final lower = text.toLowerCase();
    if (words.contains('insomnia') ||
        words.contains('restless') ||
        lower.contains('slept terribly') ||
        lower.contains('slept badly') ||
        lower.contains('slept horribly') ||
        lower.contains('slept horrible')) {
      symptoms.add('insomnia');
      mood ??= 'low';
      mark();
    }
    if (words.contains('stressed') || words.contains('stress')) {
      mood ??= 'frayed';
      stress = 'loud';
      mark();
    }
    if (words.contains('craving') || words.contains('cravings')) {
      symptoms.add('craving');
      mark();
    }
    if (words.contains('bloated') || words.contains('bloating') || words.contains('bloat')) {
      symptoms.add('bloating');
      mark();
    }
    if (words.contains('calm')) {
      mood = 'calm';
      mark();
    }
    if (words.contains('happy') || words.contains('bright')) {
      mood = 'bright';
      mark();
    }
    if (words.contains('water') || words.contains('hydrated')) {
      symptoms.add('water');
      final day = isoDay(dateOnly(now()));
      if (!profile.mealsNoted.contains(day)) {
        profile = profile.copyWith(mealsNoted: [...profile.mealsNoted, day]);
      }
      mark();
    }
    if (words.contains('walked') || words.contains('walk') || words.contains('workout') || words.contains('ran') || words.contains('run')) {
      final day = isoDay(dateOnly(now()));
      if (!profile.workouts.contains(day)) {
        profile = profile.copyWith(workouts: [...profile.workouts, day]);
      }
      mark();
    }
    if (lower.contains('breaking out') || (lower.contains('skin') && lower.contains('clear'))) {
      symptoms.add(lower.contains('clear') ? 'skin-clear' : 'acne');
      mark();
    }
    if (!noted) {
      ask(text);
      requestSection(2);
      return;
    }
    updateToday(mood: mood, stress: stress, energy: energy, setEnergy: setEnergy, symptoms: symptoms.toList());
    final at = now().toIso8601String();
    profile = profile.copyWith(
      chat: [
        ...profile.chat,
        ChatTurn(role: 'you', text: text, at: at),
        ChatTurn(role: 'eva', text: 'Kept, so you do not have to repeat it.', at: at),
      ],
    );
    flash('Noted. Change it with one tap if that is off.');
    _commit();
  }

  void ask(String text) {
    if (!_guardHealth() || !_guardRate()) return;
    final clean = text.trim();
    if (clean.isEmpty) return;
    if (clean.length > 2000) {
      flash('That question is too long. Shorten it and send it again.');
      return;
    }
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
    if (!_guardHealth()) return;
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
    if (!_guardHealth()) return;
    if (celsius < 34 || celsius > 42) {
      flash('That temperature is outside the range EVA will store. It was not saved.');
      return;
    }
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
    if (!_guardHealth()) return;
    if (kg < 20 || kg > 300) {
      flash('That weight is outside the range EVA will store. It was not saved.');
      return;
    }
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

  void addCircle(String name, String role) {
    final clean = name.trim();
    if (clean.isEmpty) return;
    profile = profile.copyWith(
      circle: [
        ...profile.circle,
        CirclePerson(
          id: now().microsecondsSinceEpoch.toString(),
          name: clean,
          role: role,
        ),
      ],
    );
    flash('$clean is in the circle. Nothing is shared yet.');
    _commit();
  }

  void removeCircle(String id) {
    profile = profile.copyWith(circle: profile.circle.where((person) => person.id != id).toList());
    flash('Removed. Their access is gone.');
    _commit();
  }

  void toggleCirclePermission(String id, String key) {
    _editCircle(id, (person) {
      final next = [...person.permissions];
      if (next.contains(key)) {
        next.remove(key);
      } else {
        next.add(key);
      }
      return person.copyWith(permissions: next);
    }, 'Permission updated');
  }

  void completeMission(String id, String mission) {
    final stamp = '${isoDay(now())}|$mission';
    _editCircle(id, (person) {
      if (person.missionDays.contains(stamp)) return person;
      return person.copyWith(missionDays: [...person.missionDays, stamp]);
    }, 'Mission kept');
  }

  void addCircleGoal(String id, String title) {
    final clean = title.trim();
    if (clean.isEmpty) return;
    _editCircle(id, (person) {
      if (person.goals.contains(clean)) return person;
      return person.copyWith(goals: [...person.goals, clean]);
    }, 'Goal shared');
  }

  void addCircleMemory(String id, String title) {
    final clean = title.trim();
    if (clean.isEmpty) return;
    _editCircle(id, (person) {
      return person.copyWith(
        memories: [
          ...person.memories,
          CircleMemory(title: clean, day: isoDay(now()), note: ''),
        ],
      );
    }, 'Memory kept');
  }

  void circleCheckIn(String id) {
    _editCircle(id, (person) => person.copyWith(checkIns: person.checkIns + 1), 'Check-in kept');
  }

  void _editCircle(String id, CirclePerson Function(CirclePerson person) change, String message) {
    final people = [...profile.circle];
    final index = people.indexWhere((person) => person.id == id);
    if (index < 0) return;
    people[index] = change(people[index]);
    profile = profile.copyWith(circle: people);
    flash(message);
    _commit();
  }

  void publish(String space, String body) {
    final text = body.trim();
    if (text.isEmpty) return;
    if (!_guardHealth()) return;
    if (text.length > 2000) {
      flash('That note is too long. Shorten it and send it again.');
      return;
    }
    final safety = safetyNotice(text);
    if (safety.isNotEmpty) {
      flash(safety);
      notifyListeners();
      return;
    }
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

  Future<String> deleteAll() async {
    _toastTimer?.cancel();
    toast = null;
    _holdSaves = true;
    try {
      await _queue;
      await repository.clear();
    } catch (_) {
      _holdSaves = false;
      saveError = 'Could not delete. Your profile is still here.';
      notifyListeners();
      return saveError!;
    }
    final receipt = now().toIso8601String();
    profile = HealthProfile.draft('');
    minorBlocked = false;
    saveError = null;
    _holdSaves = false;
    notifyListeners();
    return 'Deletion receipt $receipt. Removed from this device: profile, notes, shortcuts, consent record, and local session data. If Supabase is configured, the profile row is removed and the session is signed out. This app cannot delete the authentication user itself, and it cannot delete a copy you already exported.';
  }

  void retrySave() {
    if (_holdSaves) return;
    _commit();
  }

  Future<void> get saved => _queue;

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
      'teen' => 'Teen years are the focus',
      'college' => 'College is the focus',
      'work' => 'Work is the focus',
      'postpartum' => 'Postpartum is the focus',
      'perimenopause' => 'Perimenopause is the focus',
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
    profile = profile.copyWith(revision: profile.revision + 1);
    notifyListeners();
    if (_holdSaves) return;
    final snapshot = profile;
    _queue = _queue.then((_) async {
      try {
        await repository.save(snapshot);
        if (saveError != null && identical(profile, snapshot)) {
          saveError = null;
          notifyListeners();
        }
      } catch (_) {
        saveError = 'Could not save. Your notes are still on this screen.';
        notifyListeners();
      }
    });
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
