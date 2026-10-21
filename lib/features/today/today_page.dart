import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:eva_ai/features/shell/eva_search.dart';
import 'package:eva_ai/features/studio/experience_page.dart';
import 'package:eva_ai/features/studio/studio_catalog.dart';
import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final brief = controller.brief;
    final palette = evaOf(context);
    final profile = controller.profile;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 860;
            final story = _StoryColumn(brief: brief, profile: profile, palette: palette);
            final side = _SideColumn(brief: brief, palette: palette);
            return ListView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 96),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: story),
                              const SizedBox(width: 18),
                              Expanded(child: side),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [story, const SizedBox(height: 14), side],
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StoryColumn extends StatelessWidget {
  const _StoryColumn({required this.brief, required this.profile, required this.palette});

  final DailyBrief brief;
  final HealthProfile profile;
  final EvaPalette palette;

  @override
  Widget build(BuildContext context) {
    final question = _nextQuestion(profile);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(text: prettyStamp(EvaScope.of(context).now())),
        const SizedBox(height: 12),
        Text(brief.greeting, style: EvaType.ui(18, palette.muted)),
        Text(profile.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: EvaType.display(54, palette.ink)),
        const SizedBox(height: 14),
        const _CommandCenter(),
        const SizedBox(height: 18),
        GlassPanel(
          child: Row(
            children: [
              Semantics(
                label: '${brief.orbKicker}, ${brief.orbValue}',
                child: PhaseOrb(kicker: brief.orbKicker, value: brief.orbValue, color: palette.primary),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(brief.orbKicker, style: EvaType.ui(13, palette.secondary, weight: FontWeight.w600, tracking: 0.4)),
                    const SizedBox(height: 6),
                    Text(brief.headline, maxLines: 4, overflow: TextOverflow.ellipsis, style: EvaType.display(26, palette.ink, height: 1.15)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(brief.energyLine, style: EvaType.ui(16, palette.ink, weight: FontWeight.w500)),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: TextButton(
          onPressed: () => openTimingSheet(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(44, 36),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          child: Text(brief.assumption, textAlign: TextAlign.left, style: EvaType.ui(13.5, palette.muted)),
        ),
        ),
        const SizedBox(height: 8),
        const _OneTap(),
        const SizedBox(height: 8),
        const _EasyDay(),
        const SizedBox(height: 8),
        GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(briefName(brief.daypart), style: EvaType.display(26, palette.ink)),
              const SizedBox(height: 4),
              Text(brief.recommendTitle, style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.6)),
              const SizedBox(height: 12),
              for (final item in brief.recommendations) ...[
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: palette.success),
                      ),
                      child: Icon(Icons.check_rounded, size: 14, color: palette.successInk),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(item, style: EvaType.ui(16, palette.ink, weight: FontWeight.w500))),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
        if (brief.whispers.isNotEmpty) ...[
          const SizedBox(height: 12),
          GlassPanel(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                for (final whisper in brief.whispers)
                  Row(
                    children: [
                      Expanded(child: Text(whisper.message, style: EvaType.ui(14.5, palette.ink))),
                      IconButton(
                        tooltip: 'Dismiss',
                        onPressed: () => EvaScope.of(context).dismissWhisper(whisper.id),
                        icon: Icon(Icons.close_rounded, size: 18, color: palette.faint),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
        if (question != null) ...[
          const SizedBox(height: 12),
          GlassPanel(
            onTap: () => _openQuestion(context, question),
            child: Row(
              children: [
                const EvaMark(size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EVA has one question', style: EvaType.ui(12, palette.secondary, weight: FontWeight.w600)),
                      Text(_questionLabel(question), style: EvaType.ui(15, palette.ink, weight: FontWeight.w500)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: palette.muted),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _SideColumn extends StatelessWidget {
  const _SideColumn({required this.brief, required this.palette});

  final DailyBrief brief;
  final EvaPalette palette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SignalGrid(signals: brief.signals),
        if (brief.notes.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final note in brief.notes) ...[
            GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note.title, style: EvaType.ui(14, note.urgent ? palette.warningInk : palette.ink, weight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(note.body, style: EvaType.ui(14, palette.muted, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
        if (brief.wearable != null) ...[
          const SizedBox(height: 12),
          GlassPanel(
            child: Row(
              children: [
                Expanded(child: _mini('Sleep', brief.wearable!.sleep)),
                Expanded(child: _mini('HRV', brief.wearable!.hrv)),
                Expanded(child: _mini('Resting', brief.wearable!.restingHeart)),
                Expanded(child: _mini('Temp', brief.wearable!.temperature)),
              ],
            ),
          ),
        ],
        if (brief.showCycleChart) ...[
          const SizedBox(height: 12),
          GlassPanel(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hormone sketch', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600)),
                const SizedBox(height: 8),
                HormoneChart(
                  series: hormoneSeries(brief.cycle.length),
                  todayIndex: brief.cycle.day - 1,
                  height: 92,
                  compact: true,
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Studio', style: EvaType.display(28, palette.ink)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 156,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: orderedStudio(EvaScope.of(context).profile.focus, wearableSample: EvaScope.of(context).profile.wearableSample).length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final link = orderedStudio(EvaScope.of(context).profile.focus, wearableSample: EvaScope.of(context).profile.wearableSample)[index];
              return SizedBox(
                width: 210,
                child: GlassPanel(
                  onTap: () => Navigator.of(context).push(evaRoute(ExperiencePage(id: link.id))),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Eyebrow(text: link.eyebrow),
                      const Spacer(),
                      Text(link.title, style: EvaType.display(26, palette.ink)),
                      const SizedBox(height: 4),
                      Text(link.line, maxLines: 2, overflow: TextOverflow.ellipsis, style: EvaType.ui(13, palette.muted)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _mini(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: EvaType.ui(11, palette.faint, tracking: 0.4)),
        const SizedBox(height: 4),
        Text(value, style: EvaType.ui(13, palette.ink, weight: FontWeight.w600)),
      ],
    );
  }
}

class _SignalGrid extends StatelessWidget {
  const _SignalGrid({required this.signals});

  final List<Signal> signals;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return Column(
      children: [
        for (var i = 0; i < signals.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: _tile(context, palette, signals[i])),
              const SizedBox(width: 12),
              Expanded(
                child: i + 1 < signals.length ? _tile(context, palette, signals[i + 1]) : const SizedBox.shrink(),
              ),
            ],
          ),
          if (i + 2 < signals.length) const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _tile(BuildContext context, EvaPalette palette, Signal signal) {
    return GlassPanel(
      onTap: () => showEvaSheet(context, title: signal.label, body: signal.detail),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(signal.label, style: EvaType.ui(12.5, palette.muted)),
          const SizedBox(height: 8),
          Text(signal.value, maxLines: 3, overflow: TextOverflow.ellipsis, style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 4),
          Text(signal.caption, maxLines: 2, overflow: TextOverflow.ellipsis, style: EvaType.ui(12, palette.faint)),
        ],
      ),
    );
  }
}

String? _nextQuestion(HealthProfile profile) {
  if (!profile.answered.contains('timing')) return 'timing';
  if (!profile.answered.contains('intention')) return 'intention';
  if (!profile.answered.contains('context')) return 'context';
  return null;
}

String _questionLabel(String id) {
  switch (id) {
    case 'timing':
      return 'When did your last bleed begin?';
    case 'intention':
      return 'What should we focus on?';
    default:
      return 'Anything I should hold gently?';
  }
}

class _CommandCenter extends StatelessWidget {
  const _CommandCenter();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final brief = controller.brief;
    final forecast = dayForecast(controller.profile, brief, controller.now());
    final trust = cycleTrust(controller.profile);
    final actions = orderedStudio(controller.profile.focus, wearableSample: controller.profile.wearableSample);
    StudioLink? byId(String id) {
      for (final link in actions) {
        if (link.id == id) return link;
      }
      return null;
    }

    void open(String id) => Navigator.of(context).push(evaRoute(ExperiencePage(id: id)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${brief.orbValue} · ${brief.orbKicker}',
          style: EvaType.ui(15, palette.secondary, weight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _forecastStat(
                palette,
                'Energy',
                trust.dated ? (forecast.rising == null ? 'Steady' : forecast.rising! ? 'Higher' : 'Lower') : 'Unknown',
                null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _forecastStat(
                palette,
                'Mood',
                _knownMood(controller, trust.dated) ? forecast.mood : 'Unknown',
                null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: _forecastStat(palette, 'Focus', trust.dated ? forecast.focus : 'Unknown', null)),
          ],
        ),
        const SizedBox(height: 8),
        Text(trust.dated ? 'Phase table, not a measurement. ${trust.evidence}' : trust.evidence, style: EvaType.ui(12, palette.faint)),
        const SizedBox(height: 8),
        Text(stageLine(controller.profile.focus), style: EvaType.ui(14, palette.ink, height: 1.4)),
        const SizedBox(height: 6),
        Text(pulseLine(controller.profile, controller.now()), style: EvaType.ui(14, palette.muted, height: 1.4)),
        const SizedBox(height: 10),
        for (final line in forecast.modeled)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(line, style: EvaType.ui(15, palette.ink, weight: FontWeight.w500)),
          ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (byId('fitness') != null) WordChip(label: 'Workout', selected: false, onTap: () => open('fitness')),
            if (byId('nutrition') != null) WordChip(label: 'Nutrition', selected: false, onTap: () => open('nutrition')),
            if (byId('mental') != null) WordChip(label: 'Mood', selected: false, onTap: () => open('mental')),
            if (byId('wearables') != null) WordChip(label: 'Sleep', selected: false, onTap: () => open('wearables')),
            WordChip(label: 'Fertility', selected: false, onTap: () => open('fertility')),
            WordChip(label: 'Labs', selected: false, onTap: () => open('labs')),
            WordChip(label: 'Symptom', selected: false, onTap: () => controller.requestSection(1)),
            WordChip(label: 'Search', selected: false, onTap: () => openEvaSearch(context)),
            WordChip(label: 'Connect', selected: false, onTap: () => open('connect')),
            WordChip(label: 'Week', selected: false, onTap: () => open('future')),
          ],
        ),
        const SizedBox(height: 12),
        const _TellEva(),
      ],
    );
  }

  bool _knownMood(EvaController controller, bool dated) {
    final mood = controller.profile.logOn(isoDay(controller.now()))?.mood ?? '';
    return dated || mood.isNotEmpty;
  }

  Widget _forecastStat(EvaPalette palette, String label, String value, bool? rising) {
    return GlassPanel(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: EvaType.ui(12, palette.muted)),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: EvaType.display(22, palette.ink))),
              if (rising != null) ...[
                const SizedBox(width: 4),
                Icon(rising ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, size: 16, color: palette.secondary),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TellEva extends StatefulWidget {
  const _TellEva();

  @override
  State<_TellEva> createState() => _TellEvaState();
}

class _TellEvaState extends State<_TellEva> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _send() {
    final value = _text.text;
    _text.clear();
    EvaScope.of(context).hear(value);
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _text,
              style: EvaType.ui(15, palette.ink),
              decoration: InputDecoration(
                hintText: 'Say it: I slept horribly',
                hintStyle: EvaType.ui(15, palette.faint),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _send(),
            ),
          ),
          IconButton(
            tooltip: 'Send',
            onPressed: _send,
            icon: Icon(Icons.arrow_upward_rounded, color: palette.ink),
          ),
        ],
      ),
    );
  }
}

class _EasyDay extends StatelessWidget {
  const _EasyDay();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final now = controller.now();
    final today = controller.profile.logOn(isoDay(dateOnly(now)));
    final prior = latestPriorLog(controller.profile, now);
    final yesterday = isoDay(shiftDays(now, -1));
    final usual = usualNotes(controller.profile);
    final canSave = today != null && logHasContent(today);
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Less typing', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.6)),
          const SizedBox(height: 8),
          Text(
            'Copies only notes you already made. Nothing here is a prediction.',
            style: EvaType.ui(14.5, palette.ink, height: 1.4),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (controller.profile.shortcuts.isNotEmpty || prior != null)
                WordChip(label: 'Nothing new', selected: false, onTap: controller.nothingNew),
              if (prior != null && prior.day != yesterday) WordChip(label: 'Copy ${prior.day}', selected: false, onTap: controller.copyLastNote),
              if (canSave) WordChip(label: 'Save today as a shortcut', selected: false, onTap: controller.saveTodayShortcut),
              WordChip(label: 'Drank water', selected: today?.symptoms.contains('water') ?? false, onTap: controller.markWater),
              WordChip(label: 'Moved', selected: controller.profile.workouts.contains(isoDay(dateOnly(now))), onTap: controller.markMoved),
              if (controller.canUndoLazy) WordChip(label: 'Undo', selected: false, onTap: controller.undoLazy),
              for (final shortcut in controller.profile.shortcuts)
                WordChip(label: shortcut.name, selected: false, onTap: () => controller.applyShortcut(shortcut.id)),
            ],
          ),
          const SizedBox(height: 12),
          Text('Usual, from your notes', style: EvaType.ui(12, palette.faint)),
          const SizedBox(height: 6),
          if (usual.isEmpty)
            Text('The same note on two days will sit here as one tap.', style: EvaType.ui(14, palette.muted, height: 1.4))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final note in usual)
                  WordChip(
                    label: '${noteLabel(note.symptom)} · ${note.count}',
                    selected: today?.symptoms.contains(note.symptom) ?? false,
                    onTap: () => controller.addUsual(note.symptom),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _OneTap extends StatelessWidget {
  const _OneTap();

  static const _flows = ['None', 'Light', 'Medium', 'Heavy'];
  static const _moods = ['Calm', 'Bright', 'Tender', 'Low', 'Frayed'];

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final today = isoDay(dateOnly(controller.now()));
    final log = controller.profile.logOn(today);
    final previous = controller.profile.logOn(isoDay(shiftDays(controller.now(), -1)));
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('One tap', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.6)),
          const SizedBox(height: 8),
          Text(learnedLine(controller.profile, controller.now()), style: EvaType.ui(14.5, palette.ink, height: 1.4)),
          if (previous != null) ...[
            const SizedBox(height: 10),
            WordChip(label: 'Same as yesterday', selected: false, onTap: controller.repeatYesterday),
          ],
          const SizedBox(height: 12),
          Text('Flow', style: EvaType.ui(12, palette.faint)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < _flows.length; i++)
                WordChip(
                  label: _flows[i],
                  selected: log?.flow == i,
                  onTap: () => controller.updateToday(flow: i),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text('Mood', style: EvaType.ui(12, palette.faint)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final mood in _moods)
                WordChip(
                  label: mood,
                  selected: log?.mood == mood.toLowerCase(),
                  onTap: () => controller.updateToday(mood: mood.toLowerCase()),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

void _openQuestion(BuildContext context, String id) {
  switch (id) {
    case 'timing':
      openTimingSheet(context);
    case 'intention':
      openIntentionSheet(context);
    default:
      openContextSheet(context);
  }
}

void openTimingSheet(BuildContext context) {
  showEvaSheet(
    context,
    title: 'When did bleeding begin?',
    body: 'Nothing is saved until you tap Use this rhythm. Until then, EVA is not using a period date.',
    child: const _TimingEditor(),
  );
}

void openIntentionSheet(BuildContext context) {
  showEvaSheet(
    context,
    title: 'What are we here for?',
    body: 'Choose as many as you like. I will lead with the one that changes the day the most.',
    child: const _IntentionEditor(),
  );
}

void openContextSheet(BuildContext context) {
  showEvaSheet(
    context,
    title: 'Anything I should hold gently?',
    body: 'This changes confidence and language. It is not a diagnosis, and none of these is a fine answer.',
    child: const _ContextEditor(),
  );
}

class _TimingEditor extends StatefulWidget {
  const _TimingEditor();

  @override
  State<_TimingEditor> createState() => _TimingEditorState();
}

class _TimingEditorState extends State<_TimingEditor> {
  late int _days;
  late int _length;
  late bool _regular;

  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _ready = true;
    final profile = EvaScope.of(context).profile;
    final now = EvaScope.of(context).now();
    _days = profile.timingConfirmed ? calendarDaysBetween(profile.lastPeriodStart, now).clamp(0, 60) : 0;
    _length = profile.cycleLength;
    _regular = profile.regular;
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final now = EvaScope.of(context).now();
    final saved = EvaScope.of(context).profile.timingConfirmed;
    final previewStart = shiftDays(now, -_days);
    final preview = projectCycle(
      HealthProfile.draft('preview').copyWith(lastPeriodStart: previewStart, cycleLength: _length, regular: _regular, timingConfirmed: true),
      now,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$_days days ago', style: EvaType.display(36, palette.ink)),
        Text(
          saved
              ? 'Saved date. Use this rhythm replaces it. Preview: day ${preview.day}, ${phaseLabel(preview.phase)}.'
              : 'Not saved. This preview is not your history. Day ${preview.day}, ${phaseLabel(preview.phase)}, only if you confirm.',
          style: EvaType.ui(14, palette.secondary, weight: FontWeight.w600),
        ),
        Slider(
          value: _days.toDouble(),
          min: 0,
          max: 45,
          divisions: 45,
          label: '$_days',
          activeColor: palette.primary,
          onChanged: (value) => setState(() => _days = value.round()),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final length in [24, 26, 28, 30, 32, 35])
              WordChip(
                label: '$length days',
                selected: _length == length,
                onTap: () => setState(() => _length = length),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: [
            WordChip(label: 'Regular', selected: _regular, onTap: () => setState(() => _regular = true)),
            WordChip(label: 'Irregular', selected: !_regular, onTap: () => setState(() => _regular = false)),
          ],
        ),
        const SizedBox(height: 16),
        SoftButton(
          label: 'Use this rhythm',
          onPressed: () {
            EvaScope.of(context).confirmTiming(daysAgo: _days, length: _length, regular: _regular);
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 8),
        SoftButton(
          label: saved ? 'Keep the saved date' : 'Don\'t save a date',
          primary: false,
          onPressed: () {
            EvaScope.of(context).answer('timing');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _IntentionEditor extends StatefulWidget {
  const _IntentionEditor();

  @override
  State<_IntentionEditor> createState() => _IntentionEditorState();
}

class _IntentionEditorState extends State<_IntentionEditor> {
  final _selected = <String>{};

  static const _options = [
    ('rhythm', 'Understand my rhythm'),
    ('conceive', 'Try to conceive'),
    ('pregnant', 'I am pregnant'),
    ('pcos', 'Live with PCOS'),
    ('menopause', 'Menopause'),
    ('mind', 'Steady my mind'),
    ('skin', 'Skin'),
    ('strength', 'Strength'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in _options)
              WordChip(
                label: option.$2,
                selected: _selected.contains(option.$1),
                onTap: () => setState(() {
                  if (_selected.contains(option.$1)) {
                    _selected.remove(option.$1);
                  } else {
                    _selected.add(option.$1);
                  }
                }),
              ),
          ],
        ),
        const SizedBox(height: 16),
        SoftButton(
          label: 'Keep going',
          onPressed: _selected.isEmpty
              ? null
              : () {
                  EvaScope.of(context).setIntentions(_selected.toList());
                  Navigator.pop(context);
                },
        ),
        const SizedBox(height: 8),
        SoftButton(
          label: 'Not now',
          primary: false,
          onPressed: () {
            EvaScope.of(context).answer('intention');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _ContextEditor extends StatefulWidget {
  const _ContextEditor();

  @override
  State<_ContextEditor> createState() => _ContextEditorState();
}

class _ContextEditorState extends State<_ContextEditor> {
  final _selected = <String>{};

  static const _options = [
    ('pcos', 'PCOS'),
    ('endo', 'Endometriosis'),
    ('anxiety', 'Anxiety'),
    ('thyroid', 'Thyroid'),
    ('menopause', 'Menopause'),
    ('pregnant', 'Pregnant now'),
    ('irregular', 'Cycles are irregular'),
    ('none', 'None of these'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in _options)
              WordChip(
                label: option.$2,
                selected: _selected.contains(option.$1),
                onTap: () => setState(() {
                  if (option.$1 == 'none') {
                    _selected
                      ..clear()
                      ..add('none');
                  } else {
                    _selected.remove('none');
                    if (_selected.contains(option.$1)) {
                      _selected.remove(option.$1);
                    } else {
                      _selected.add(option.$1);
                    }
                  }
                }),
              ),
          ],
        ),
        const SizedBox(height: 16),
        SoftButton(
          label: 'That is enough for now',
          onPressed: _selected.isEmpty
              ? null
              : () {
                  EvaScope.of(context).setContexts(_selected.toList());
                  Navigator.pop(context);
                },
        ),
        const SizedBox(height: 8),
        SoftButton(
          label: 'Nothing to add',
          primary: false,
          onPressed: () {
            EvaScope.of(context).setContexts(const ['none']);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
