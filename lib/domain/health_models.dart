const _unset = Object();

String isoDay(DateTime d) {
  final y = d.year.toString().padLeft(4, '0');
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime shiftDays(DateTime day, int days) {
  final base = dateOnly(day);
  return DateTime(base.year, base.month, base.day + days);
}

int calendarDaysBetween(DateTime start, DateTime end) {
  final from = DateTime.utc(start.year, start.month, start.day);
  final to = DateTime.utc(end.year, end.month, end.day);
  return to.difference(from).inDays;
}

DateTime? tryParseDay(dynamic raw) {
  if (raw is! String || raw.isEmpty) return null;
  final parsed = DateTime.tryParse(raw);
  if (parsed == null) return null;
  return DateTime(parsed.year, parsed.month, parsed.day);
}

String prettyDay(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  const weeks = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  return '${weeks[d.weekday - 1]} · ${d.day} ${months[d.month - 1]}';
}

String prettyStamp(DateTime d) {
  final suffix = d.hour >= 12 ? 'PM' : 'AM';
  final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final minute = d.minute.toString().padLeft(2, '0');
  return '${prettyDay(d)} · $hour:$minute $suffix';
}

String aliasFor(String name) {
  const adjectives = ['Quiet', 'Silver', 'Gentle', 'Lunar', 'Amber', 'Soft', 'Kind', 'Still'];
  const nouns = ['Cedar', 'Harbor', 'Wren', 'Moss', 'Dawn', 'River', 'Lumen', 'Fern'];
  var hash = 0;
  for (final unit in name.codeUnits) {
    hash = (hash * 33 + unit) & 0x7fffffff;
  }
  return '${adjectives[hash % adjectives.length]} ${nouns[(hash ~/ adjectives.length) % nouns.length]}';
}

List<String> _strings(dynamic value) {
  if (value is! List) return const [];
  return List<String>.unmodifiable(value.map((item) => item.toString()));
}

class DailyLog {
  const DailyLog({
    required this.day,
    this.flow = 0,
    this.mood = '',
    this.stress = '',
    this.energy,
    this.symptoms = const [],
  });

  final String day;
  final int flow;
  final String mood;
  final String stress;
  final double? energy;
  final List<String> symptoms;

  DailyLog copyWith({
    int? flow,
    String? mood,
    String? stress,
    Object? energy = _unset,
    List<String>? symptoms,
  }) {
    return DailyLog(
      day: day,
      flow: flow ?? this.flow,
      mood: mood ?? this.mood,
      stress: stress ?? this.stress,
      energy: energy == _unset ? this.energy : energy as double?,
      symptoms: symptoms ?? this.symptoms,
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'flow': flow,
        'mood': mood,
        'stress': stress,
        'energy': energy,
        'symptoms': symptoms,
      };

  factory DailyLog.fromJson(Map<String, dynamic> json) {
    return DailyLog(
      day: json['day'] as String? ?? '',
      flow: (json['flow'] as num?)?.toInt() ?? 0,
      mood: json['mood'] as String? ?? '',
      stress: json['stress'] as String? ?? '',
      energy: (json['energy'] as num?)?.toDouble(),
      symptoms: _strings(json['symptoms']),
    );
  }
}

class LogShortcut {
  const LogShortcut({
    required this.id,
    required this.name,
    required this.flow,
    required this.mood,
    required this.stress,
    this.energy,
    this.symptoms = const [],
  });

  final String id;
  final String name;
  final int flow;
  final String mood;
  final String stress;
  final double? energy;
  final List<String> symptoms;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'flow': flow,
        'mood': mood,
        'stress': stress,
        'energy': energy,
        'symptoms': symptoms,
      };

  factory LogShortcut.fromJson(Map<String, dynamic> json) {
    return LogShortcut(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      flow: (json['flow'] as num?)?.toInt() ?? 0,
      mood: json['mood'] as String? ?? '',
      stress: json['stress'] as String? ?? '',
      energy: (json['energy'] as num?)?.toDouble(),
      symptoms: _strings(json['symptoms']),
    );
  }
}

class ChatTurn {
  const ChatTurn({required this.role, required this.text, required this.at});

  final String role;
  final String text;
  final String at;

  Map<String, dynamic> toJson() => {'role': role, 'text': text, 'at': at};

  factory ChatTurn.fromJson(Map<String, dynamic> json) {
    return ChatTurn(
      role: json['role'] as String? ?? 'eva',
      text: json['text'] as String? ?? '',
      at: json['at'] as String? ?? '',
    );
  }
}

class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.space,
    required this.author,
    required this.body,
    required this.verified,
    required this.mine,
  });

  final String id;
  final String space;
  final String author;
  final String body;
  final bool verified;
  final bool mine;

  Map<String, dynamic> toJson() => {
        'id': id,
        'space': space,
        'author': author,
        'body': body,
        'verified': verified,
        'mine': mine,
      };

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'] as String? ?? '',
      space: json['space'] as String? ?? 'Rhythm',
      author: json['author'] as String? ?? 'Anonymous',
      body: json['body'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
      mine: json['mine'] as bool? ?? false,
    );
  }
}

class BbtPoint {
  const BbtPoint({required this.day, required this.celsius});

  final String day;
  final double celsius;

  Map<String, dynamic> toJson() => {'day': day, 'celsius': celsius};

  factory BbtPoint.fromJson(Map<String, dynamic> json) {
    return BbtPoint(
      day: json['day'] as String? ?? '',
      celsius: (json['celsius'] as num?)?.toDouble() ?? 36.5,
    );
  }
}

class ContractionSpan {
  const ContractionSpan({required this.start, required this.end});

  final String start;
  final String end;

  Map<String, dynamic> toJson() => {'start': start, 'end': end};

  factory ContractionSpan.fromJson(Map<String, dynamic> json) {
    return ContractionSpan(
      start: json['start'] as String? ?? '',
      end: json['end'] as String? ?? '',
    );
  }
}

class HotFlash {
  const HotFlash({required this.at, required this.strong});

  final String at;
  final bool strong;

  Map<String, dynamic> toJson() => {'at': at, 'strong': strong};

  factory HotFlash.fromJson(Map<String, dynamic> json) {
    return HotFlash(
      at: json['at'] as String? ?? '',
      strong: json['strong'] as bool? ?? false,
    );
  }
}

class WeightPoint {
  const WeightPoint({required this.day, required this.kg});

  final String day;
  final double kg;

  Map<String, dynamic> toJson() => {'day': day, 'kg': kg};

  factory WeightPoint.fromJson(Map<String, dynamic> json) {
    return WeightPoint(
      day: json['day'] as String? ?? '',
      kg: (json['kg'] as num?)?.toDouble() ?? 0,
    );
  }
}

class DayFlags {
  const DayFlags({required this.day, this.flags = const []});

  final String day;
  final List<String> flags;

  Map<String, dynamic> toJson() => {'day': day, 'flags': flags};

  factory DayFlags.fromJson(Map<String, dynamic> json) {
    return DayFlags(
      day: json['day'] as String? ?? '',
      flags: _strings(json['flags']),
    );
  }
}

class CircleMemory {
  const CircleMemory({required this.title, required this.day, required this.note});

  final String title;
  final String day;
  final String note;

  Map<String, dynamic> toJson() => {'title': title, 'day': day, 'note': note};

  factory CircleMemory.fromJson(Map<String, dynamic> json) {
    return CircleMemory(
      title: json['title'] as String? ?? '',
      day: json['day'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );
  }
}

class CirclePerson {
  const CirclePerson({
    required this.id,
    required this.name,
    required this.role,
    this.permissions = const [],
    this.missionDays = const [],
    this.goals = const [],
    this.memories = const [],
    this.checkIns = 0,
  });

  final String id;
  final String name;
  final String role;
  final List<String> permissions;
  final List<String> missionDays;
  final List<String> goals;
  final List<CircleMemory> memories;
  final int checkIns;

  bool allows(String key) => permissions.contains(key);

  CirclePerson copyWith({
    String? name,
    String? role,
    List<String>? permissions,
    List<String>? missionDays,
    List<String>? goals,
    List<CircleMemory>? memories,
    int? checkIns,
  }) {
    return CirclePerson(
      id: id,
      name: name ?? this.name,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      missionDays: missionDays ?? this.missionDays,
      goals: goals ?? this.goals,
      memories: memories ?? this.memories,
      checkIns: checkIns ?? this.checkIns,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'permissions': permissions,
        'missionDays': missionDays,
        'goals': goals,
        'memories': memories.map((memory) => memory.toJson()).toList(),
        'checkIns': checkIns,
      };

  factory CirclePerson.fromJson(Map<String, dynamic> json) {
    final memories = json['memories'];
    return CirclePerson(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? 'partner',
      permissions: _strings(json['permissions']),
      missionDays: _strings(json['missionDays']),
      goals: _strings(json['goals']),
      memories: memories is List
          ? memories
              .whereType<Map>()
              .map((item) => CircleMemory.fromJson(item.map((key, value) => MapEntry(key.toString(), value))))
              .toList()
          : const [],
      checkIns: (json['checkIns'] as num?)?.toInt() ?? 0,
    );
  }
}

class HealthProfile {
  HealthProfile({
    required this.name,
    required this.lastPeriodStart,
    required this.timingConfirmed,
    required this.cycleLength,
    required this.periodLength,
    required this.regular,
    required this.pregnant,
    required this.pregnancyLmp,
    required this.focus,
    required List<String> intentions,
    required List<String> contexts,
    required this.wearableSample,
    required this.streak,
    required this.streakDay,
    required List<String> milestones,
    required List<DailyLog> logs,
    required List<ChatTurn> chat,
    required List<String> dismissed,
    required this.localFirst,
    required this.communityAlias,
    required this.communityVerified,
    required List<CommunityPost> posts,
    required List<BbtPoint> bbt,
    required this.mucus,
    required List<String> intimacyDays,
    required this.kicksDay,
    required this.kicks,
    required List<ContractionSpan> contractions,
    required List<HotFlash> hotFlashes,
    required List<WeightPoint> weights,
    required List<DayFlags> pcosDays,
    required List<String> appointments,
    required List<String> birthPrep,
    required this.theme,
    required List<String> labsOpened,
    required List<String> answered,
    required List<String> mealsNoted,
    required List<String> workouts,
    required List<CirclePerson> circle,
    required List<LogShortcut> shortcuts,
    required this.ageAffirmed,
    required this.healthConsentAt,
    required this.revision,
    required List<String> audit,
  })  : intentions = List<String>.unmodifiable(intentions),
        contexts = List<String>.unmodifiable(contexts),
        milestones = List<String>.unmodifiable(milestones),
        logs = List<DailyLog>.unmodifiable(logs),
        chat = List<ChatTurn>.unmodifiable(chat),
        dismissed = List<String>.unmodifiable(dismissed),
        posts = List<CommunityPost>.unmodifiable(posts),
        bbt = List<BbtPoint>.unmodifiable(bbt),
        intimacyDays = List<String>.unmodifiable(intimacyDays),
        contractions = List<ContractionSpan>.unmodifiable(contractions),
        hotFlashes = List<HotFlash>.unmodifiable(hotFlashes),
        weights = List<WeightPoint>.unmodifiable(weights),
        pcosDays = List<DayFlags>.unmodifiable(pcosDays),
        appointments = List<String>.unmodifiable(appointments),
        birthPrep = List<String>.unmodifiable(birthPrep),
        labsOpened = List<String>.unmodifiable(labsOpened),
        answered = List<String>.unmodifiable(answered),
        mealsNoted = List<String>.unmodifiable(mealsNoted),
        workouts = List<String>.unmodifiable(workouts),
        circle = List<CirclePerson>.unmodifiable(circle),
        shortcuts = List<LogShortcut>.unmodifiable(shortcuts),
        audit = List<String>.unmodifiable(audit);

  final String name;
  final DateTime lastPeriodStart;
  final bool timingConfirmed;
  final int cycleLength;
  final int periodLength;
  final bool regular;
  final bool pregnant;
  final DateTime? pregnancyLmp;
  final String focus;
  final List<String> intentions;
  final List<String> contexts;
  final bool wearableSample;
  final int streak;
  final String? streakDay;
  final List<String> milestones;
  final List<DailyLog> logs;
  final List<ChatTurn> chat;
  final List<String> dismissed;
  final bool localFirst;
  final String communityAlias;
  final bool communityVerified;
  final List<CommunityPost> posts;
  final List<BbtPoint> bbt;
  final String mucus;
  final List<String> intimacyDays;
  final String? kicksDay;
  final int kicks;
  final List<ContractionSpan> contractions;
  final List<HotFlash> hotFlashes;
  final List<WeightPoint> weights;
  final List<DayFlags> pcosDays;
  final List<String> appointments;
  final List<String> birthPrep;
  final String theme;
  final List<String> labsOpened;
  final List<String> answered;
  final List<String> mealsNoted;
  final List<String> workouts;
  final List<CirclePerson> circle;
  final List<LogShortcut> shortcuts;
  final bool ageAffirmed;
  final String? healthConsentAt;
  final int revision;
  final List<String> audit;

  bool get healthReady => ageAffirmed && (healthConsentAt?.isNotEmpty ?? false);

  factory HealthProfile.draft(String name, {DateTime? now}) {
    final clock = dateOnly(now ?? DateTime.now());
    final clean = name.trim();
    return HealthProfile(
      name: clean,
      lastPeriodStart: shiftDays(clock, -11),
      timingConfirmed: false,
      cycleLength: 28,
      periodLength: 5,
      regular: true,
      pregnant: false,
      pregnancyLmp: null,
      focus: 'cycle',
      intentions: const [],
      contexts: const [],
      wearableSample: false,
      streak: 0,
      streakDay: null,
      milestones: const [],
      logs: const [],
      chat: const [],
      dismissed: const [],
      localFirst: true,
      communityAlias: clean.isEmpty ? 'Quiet Cedar' : aliasFor(clean),
      communityVerified: false,
      posts: const [],
      bbt: const [],
      mucus: '',
      intimacyDays: const [],
      kicksDay: null,
      kicks: 0,
      contractions: const [],
      hotFlashes: const [],
      weights: const [],
      pcosDays: const [],
      appointments: const [],
      birthPrep: const [],
      theme: 'system',
      labsOpened: const [],
      answered: const [],
      mealsNoted: const [],
      workouts: const [],
      circle: const [],
      shortcuts: const [],
      ageAffirmed: false,
      healthConsentAt: null,
      revision: 0,
      audit: const [],
    );
  }

  DailyLog? logOn(String day) {
    for (final log in logs) {
      if (log.day == day) return log;
    }
    return null;
  }

  HealthProfile compacted() {
    List<T> tail<T>(List<T> items, int max) =>
        items.length > max ? items.sublist(items.length - max) : items;
    return copyWith(
      logs: tail(logs, 420),
      chat: tail(chat, 40),
      posts: tail(posts, 80),
      bbt: tail(bbt, 120),
      contractions: tail(contractions, 40),
      hotFlashes: tail(hotFlashes, 80),
      weights: tail(weights, 90),
      pcosDays: tail(pcosDays, 120),
      dismissed: tail(dismissed, 60),
      circle: tail(circle, 24),
    );
  }

  HealthProfile copyWith({
    String? name,
    DateTime? lastPeriodStart,
    bool? timingConfirmed,
    int? cycleLength,
    int? periodLength,
    bool? regular,
    bool? pregnant,
    Object? pregnancyLmp = _unset,
    String? focus,
    List<String>? intentions,
    List<String>? contexts,
    bool? wearableSample,
    int? streak,
    Object? streakDay = _unset,
    List<String>? milestones,
    List<DailyLog>? logs,
    List<ChatTurn>? chat,
    List<String>? dismissed,
    bool? localFirst,
    String? communityAlias,
    bool? communityVerified,
    List<CommunityPost>? posts,
    List<BbtPoint>? bbt,
    String? mucus,
    List<String>? intimacyDays,
    Object? kicksDay = _unset,
    int? kicks,
    List<ContractionSpan>? contractions,
    List<HotFlash>? hotFlashes,
    List<WeightPoint>? weights,
    List<DayFlags>? pcosDays,
    List<String>? appointments,
    List<String>? birthPrep,
    String? theme,
    List<String>? labsOpened,
    List<String>? answered,
    List<String>? mealsNoted,
    List<String>? workouts,
    List<CirclePerson>? circle,
    List<LogShortcut>? shortcuts,
    bool? ageAffirmed,
    Object? healthConsentAt = _unset,
    int? revision,
    List<String>? audit,
  }) {
    return HealthProfile(
      name: name ?? this.name,
      lastPeriodStart: lastPeriodStart ?? this.lastPeriodStart,
      timingConfirmed: timingConfirmed ?? this.timingConfirmed,
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      regular: regular ?? this.regular,
      pregnant: pregnant ?? this.pregnant,
      pregnancyLmp: pregnancyLmp == _unset ? this.pregnancyLmp : pregnancyLmp as DateTime?,
      focus: focus ?? this.focus,
      intentions: intentions ?? this.intentions,
      contexts: contexts ?? this.contexts,
      wearableSample: wearableSample ?? this.wearableSample,
      streak: streak ?? this.streak,
      streakDay: streakDay == _unset ? this.streakDay : streakDay as String?,
      milestones: milestones ?? this.milestones,
      logs: logs ?? this.logs,
      chat: chat ?? this.chat,
      dismissed: dismissed ?? this.dismissed,
      localFirst: localFirst ?? this.localFirst,
      communityAlias: communityAlias ?? this.communityAlias,
      communityVerified: communityVerified ?? this.communityVerified,
      posts: posts ?? this.posts,
      bbt: bbt ?? this.bbt,
      mucus: mucus ?? this.mucus,
      intimacyDays: intimacyDays ?? this.intimacyDays,
      kicksDay: kicksDay == _unset ? this.kicksDay : kicksDay as String?,
      kicks: kicks ?? this.kicks,
      contractions: contractions ?? this.contractions,
      hotFlashes: hotFlashes ?? this.hotFlashes,
      weights: weights ?? this.weights,
      pcosDays: pcosDays ?? this.pcosDays,
      appointments: appointments ?? this.appointments,
      birthPrep: birthPrep ?? this.birthPrep,
      theme: theme ?? this.theme,
      labsOpened: labsOpened ?? this.labsOpened,
      answered: answered ?? this.answered,
      mealsNoted: mealsNoted ?? this.mealsNoted,
      workouts: workouts ?? this.workouts,
      circle: circle ?? this.circle,
      shortcuts: shortcuts ?? this.shortcuts,
      ageAffirmed: ageAffirmed ?? this.ageAffirmed,
      healthConsentAt: healthConsentAt == _unset ? this.healthConsentAt : healthConsentAt as String?,
      revision: revision ?? this.revision,
      audit: audit ?? this.audit,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastPeriodStart': isoDay(lastPeriodStart),
        'timingConfirmed': timingConfirmed,
        'cycleLength': cycleLength,
        'periodLength': periodLength,
        'regular': regular,
        'pregnant': pregnant,
        'pregnancyLmp': pregnancyLmp == null ? null : isoDay(pregnancyLmp!),
        'focus': focus,
        'intentions': intentions,
        'contexts': contexts,
        'wearableSample': wearableSample,
        'streak': streak,
        'streakDay': streakDay,
        'milestones': milestones,
        'logs': logs.map((log) => log.toJson()).toList(),
        'chat': chat.map((turn) => turn.toJson()).toList(),
        'dismissed': dismissed,
        'localFirst': localFirst,
        'communityAlias': communityAlias,
        'communityVerified': communityVerified,
        'posts': posts.map((post) => post.toJson()).toList(),
        'bbt': bbt.map((point) => point.toJson()).toList(),
        'mucus': mucus,
        'intimacyDays': intimacyDays,
        'kicksDay': kicksDay,
        'kicks': kicks,
        'contractions': contractions.map((span) => span.toJson()).toList(),
        'hotFlashes': hotFlashes.map((flash) => flash.toJson()).toList(),
        'weights': weights.map((point) => point.toJson()).toList(),
        'pcosDays': pcosDays.map((day) => day.toJson()).toList(),
        'appointments': appointments,
        'birthPrep': birthPrep,
        'theme': theme,
        'labsOpened': labsOpened,
        'answered': answered,
        'mealsNoted': mealsNoted,
        'workouts': workouts,
        'circle': circle.map((person) => person.toJson()).toList(),
        'shortcuts': shortcuts.map((shortcut) => shortcut.toJson()).toList(),
        'ageAffirmed': ageAffirmed,
        'healthConsentAt': healthConsentAt,
        'revision': revision,
        'audit': audit,
      };

  factory HealthProfile.fromJson(Map<String, dynamic> json) {
    List<T> mapList<T>(dynamic value, T Function(Map<String, dynamic>) parse) {
      if (value is! List) return const [];
      return value
          .whereType<Map>()
          .map((item) => parse(item.map((key, val) => MapEntry(key.toString(), val))))
          .toList();
    }

    final start = tryParseDay(json['lastPeriodStart']) ?? shiftDays(DateTime.now(), -11);
    return HealthProfile(
      name: json['name'] as String? ?? '',
      lastPeriodStart: start,
      timingConfirmed: json['timingConfirmed'] as bool? ?? false,
      cycleLength: (json['cycleLength'] as num?)?.toInt() ?? 28,
      periodLength: (json['periodLength'] as num?)?.toInt() ?? 5,
      regular: json['regular'] as bool? ?? true,
      pregnant: json['pregnant'] as bool? ?? false,
      pregnancyLmp: tryParseDay(json['pregnancyLmp']),
      focus: json['focus'] as String? ?? 'cycle',
      intentions: _strings(json['intentions']),
      contexts: _strings(json['contexts']),
      wearableSample: json['wearableSample'] as bool? ?? false,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      streakDay: json['streakDay'] as String?,
      milestones: _strings(json['milestones']),
      logs: mapList(json['logs'], DailyLog.fromJson),
      chat: mapList(json['chat'], ChatTurn.fromJson),
      dismissed: _strings(json['dismissed']),
      localFirst: json['localFirst'] as bool? ?? true,
      communityAlias: json['communityAlias'] as String? ?? 'Quiet Cedar',
      communityVerified: json['communityVerified'] as bool? ?? false,
      posts: mapList(json['posts'], CommunityPost.fromJson),
      bbt: mapList(json['bbt'], BbtPoint.fromJson),
      mucus: json['mucus'] as String? ?? '',
      intimacyDays: _strings(json['intimacyDays']),
      kicksDay: json['kicksDay'] as String?,
      kicks: (json['kicks'] as num?)?.toInt() ?? 0,
      contractions: mapList(json['contractions'], ContractionSpan.fromJson),
      hotFlashes: mapList(json['hotFlashes'], HotFlash.fromJson),
      weights: mapList(json['weights'], WeightPoint.fromJson),
      pcosDays: mapList(json['pcosDays'], DayFlags.fromJson),
      appointments: _strings(json['appointments']),
      birthPrep: _strings(json['birthPrep']),
      theme: json['theme'] as String? ?? 'system',
      labsOpened: _strings(json['labsOpened']),
      answered: _strings(json['answered']),
      mealsNoted: _strings(json['mealsNoted']),
      workouts: _strings(json['workouts']),
      circle: mapList(json['circle'], CirclePerson.fromJson),
      shortcuts: mapList(json['shortcuts'], LogShortcut.fromJson),
      ageAffirmed: json['ageAffirmed'] as bool? ?? false,
      healthConsentAt: json['healthConsentAt'] as String?,
      revision: (json['revision'] as num?)?.toInt() ?? 0,
      audit: _strings(json['audit']),
    );
  }
}

bool saveWouldOverwriteNewer(HealthProfile? stored, HealthProfile incoming) {
  return stored != null && stored.revision > incoming.revision;
}
