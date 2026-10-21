import 'dart:async';
import 'dart:convert';

import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/features/connect/connect_page.dart';
import 'package:eva_ai/features/future/future_page.dart';
import 'package:eva_ai/features/shortcuts/shortcuts_page.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return _RememberRoom(id: id, child: _page(id));
  }
}

class _RememberRoom extends StatefulWidget {
  const _RememberRoom({required this.id, required this.child});

  final String id;
  final Widget child;

  @override
  State<_RememberRoom> createState() => _RememberRoomState();
}

class _RememberRoomState extends State<_RememberRoom> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      EvaScope.of(context).noteSeen(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

Widget _page(String id) {
  switch (id) {
    case 'pregnancy':
      return const _PregnancyPage();
      case 'fertility':
        return const _FertilityPage();
      case 'pcos':
        return const _PcosPage();
      case 'menopause':
        return const _MenopausePage();
      case 'mental':
        return const _MentalPage();
      case 'nutrition':
        return const _NutritionPage();
      case 'fitness':
        return const _FitnessPage();
      case 'beauty':
        return const _BeautyPage();
      case 'labs':
        return const _LabsPage();
      case 'community':
        return const _CommunityPage();
      case 'wearables':
        return const _WearablesPage();
      case 'connect':
        return const ConnectPage();
      case 'future':
        return const FuturePage();
      case 'shortcuts':
        return const ShortcutsPage();
      default:
        return const _PrivacyPage();
  }
}

class _FocusButton extends StatelessWidget {
  const _FocusButton({required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final active = controller.profile.focus == mode;
    return SoftButton(
      label: active ? 'This is your focus' : 'Focus EVA here',
      primary: !active,
      onPressed: active ? null : () => controller.setFocus(mode),
    );
  }
}

class _PregnancyPage extends StatelessWidget {
  const _PregnancyPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final profile = controller.profile;
    final story = profile.pregnant ? pregnancyStory(profile.pregnancyLmp ?? profile.lastPeriodStart, controller.now()) : null;
    final kicks = profile.kicksDay == isoDay(dateOnly(controller.now())) ? profile.kicks : 0;
    return StudioScaffold(
      eyebrow: 'Pregnancy',
      title: story == null ? 'Ready when you are' : 'Week ${story.week}',
      lede: story?.headline ?? 'Confirm a last menstrual period and the whole day changes. EVA will not invent a pregnancy.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (story == null) const _PregnancyStart() else ...[
            GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Often compared with ${story.size}.', style: EvaType.display(26, evaOf(context).ink)),
                  const SizedBox(height: 8),
                  Text(story.body, style: EvaType.ui(15, evaOf(context).muted, height: 1.45)),
                  const SizedBox(height: 8),
                  Text(story.visit, style: EvaType.ui(14, evaOf(context).secondary, height: 1.4)),
                  const SizedBox(height: 8),
                  Text('Due estimate ${prettyDay(story.due)}. It is not a deadline.', style: EvaType.ui(13, evaOf(context).faint)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassPanel(
              child: Row(
                children: [
                  Expanded(child: Text('$kicks kicks noted today', style: EvaType.ui(16, evaOf(context).ink))),
                  SoftButton(label: 'Kick', onPressed: controller.addKick),
                ],
              ),
            ),
            const SizedBox(height: 8),
              Text(
              'A personal tally, not a medical kick count, unless your clinician taught you one. A much quieter baby is a same-day call.',
              style: EvaType.ui(13, evaOf(context).faint, height: 1.4),
            ),
            const SizedBox(height: 14),
            Text('This week, as a guide', style: EvaType.ui(13, evaOf(context).faint)),
            const SizedBox(height: 6),
            for (final line in pregnancyGuide(story))
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(line, style: EvaType.ui(15, evaOf(context).ink, height: 1.4)),
              ),
            const SizedBox(height: 16),
            const _ContractionTimer(),
            const SizedBox(height: 16),
            Text('Birth preparation', style: EvaType.display(28, evaOf(context).ink)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final item in ['Hospital bag', 'Route planned', 'Support person', 'Pediatrician', 'Questions written'])
                  WordChip(
                    label: item,
                    selected: profile.birthPrep.contains(item),
                    onTap: () => controller.toggleBirth(item),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const _AppointmentAdder(),
            const SizedBox(height: 12),
            SoftButton(label: 'Leave pregnancy mode', primary: false, onPressed: controller.clearPregnancy),
          ],
          const SizedBox(height: 12),
          const _FocusButton(mode: 'pregnancy'),
        ],
      ),
    );
  }
}

class _PregnancyStart extends StatefulWidget {
  const _PregnancyStart();

  @override
  State<_PregnancyStart> createState() => _PregnancyStartState();
}

class _PregnancyStartState extends State<_PregnancyStart> {
  double _weeks = 8;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Last menstrual period, about ${_weeks.round()} weeks ago', style: EvaType.ui(16, palette.ink)),
        Slider(
          value: _weeks,
          min: 3,
          max: 40,
          divisions: 37,
          activeColor: palette.primary,
          onChanged: (value) => setState(() => _weeks = value),
        ),
        SoftButton(
          label: 'Reshape EVA around this',
          onPressed: () => EvaScope.of(context).confirmPregnancy((_weeks * 7).round()),
        ),
      ],
    );
  }
}

class _ContractionTimer extends StatefulWidget {
  const _ContractionTimer();

  @override
  State<_ContractionTimer> createState() => _ContractionTimerState();
}

class _ContractionTimerState extends State<_ContractionTimer> {
  DateTime? _start;
  Timer? _ticker;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final controller = EvaScope.of(context);
    final elapsed = _start == null ? 0 : DateTime.now().difference(_start!).inSeconds;
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contraction timer', style: EvaType.display(26, palette.ink)),
          const SizedBox(height: 6),
          Text(
            _start == null ? 'A notebook for contractions. Follow the rule your care team gave you.' : _clock(elapsed),
            style: EvaType.ui(15, palette.muted),
          ),
          const SizedBox(height: 12),
          SoftButton(
            label: _start == null ? 'Start' : 'Stop',
            onPressed: () {
              if (_start == null) {
                setState(() => _start = DateTime.now());
                _ticker?.cancel();
                _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
                  if (mounted) setState(() {});
                });
              } else {
                controller.addContraction(_start!, DateTime.now());
                _ticker?.cancel();
                setState(() => _start = null);
              }
            },
          ),
          if (controller.profile.contractions.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final span in controller.profile.contractions.reversed.take(4))
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(_describe(span), style: EvaType.ui(13, palette.muted)),
              ),
            TextButton(onPressed: controller.clearContractions, child: const Text('Clear this session')),
          ],
        ],
      ),
    );
  }

  String _clock(int seconds) => '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';

  String _describe(ContractionSpan span) {
    final start = DateTime.tryParse(span.start);
    final end = DateTime.tryParse(span.end);
    if (start == null || end == null) return span.start;
    final seconds = end.difference(start).inSeconds;
    return '${seconds ~/ 60}m ${seconds % 60}s';
  }
}

class _AppointmentAdder extends StatefulWidget {
  const _AppointmentAdder();

  @override
  State<_AppointmentAdder> createState() => _AppointmentAdderState();
}

class _AppointmentAdderState extends State<_AppointmentAdder> {
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Visits', style: EvaType.display(28, palette.ink)),
        const SizedBox(height: 8),
        for (final visit in controller.profile.appointments)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Expanded(child: Text(visit, style: EvaType.ui(15, palette.ink))),
                IconButton(
                  tooltip: 'Remove visit',
                  onPressed: () => controller.removeAppointment(visit),
                  icon: Icon(Icons.close_rounded, color: palette.muted),
                ),
              ],
            ),
          ),
        TextField(
          controller: _text,
          style: EvaType.ui(16, palette.ink),
          decoration: InputDecoration(
            hintText: 'Dating scan, anatomy scan, a name you use',
            hintStyle: EvaType.ui(16, palette.faint),
            border: InputBorder.none,
          ),
          onSubmitted: _add,
        ),
        SoftButton(
          label: 'Remember this visit',
          primary: false,
          onPressed: _text.text.trim().isEmpty ? null : () => _add(_text.text),
        ),
      ],
    );
  }

  void _add(String value) {
    EvaScope.of(context).addAppointment(value);
    _text.clear();
  }
}

class _FertilityPage extends StatefulWidget {
  const _FertilityPage();

  @override
  State<_FertilityPage> createState() => _FertilityPageState();
}

class _FertilityPageState extends State<_FertilityPage> {
  double _temp = 36.5;
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _ready = true;
    final points = EvaScope.of(context).profile.bbt;
    if (points.isNotEmpty) _temp = points.last.celsius.clamp(35.5, 37.8);
  }

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final cycle = controller.brief.cycle;
    final today = isoDay(dateOnly(controller.now()));
    return StudioScaffold(
      eyebrow: 'Fertility',
      title: cycle.fertilityToday > 0.45 ? 'Inside the model' : 'Outside the peak',
      lede: 'A calendar fertile window is not contraception and not a promise of pregnancy.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${prettyDay(cycle.fertileStart)} to ${prettyDay(cycle.fertileEnd)}', style: EvaType.display(26, palette.ink)),
                const SizedBox(height: 6),
                Text(
                  controller.profile.timingConfirmed
                      ? 'Calendar estimate only. Not a chance of pregnancy, and not contraception.'
                      : 'Not enough information yet. A fertile window is not estimated until a period date is saved.',
                  style: EvaType.ui(15, palette.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text('Cervical fluid', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in ['Dry', 'Sticky', 'Creamy', 'Eggwhite'])
                WordChip(
                  label: item,
                  selected: controller.profile.mucus == item.toLowerCase(),
                  onTap: () => controller.setMucus(item.toLowerCase()),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text('Waking temperature ${_temp.toStringAsFixed(2)} °C', style: EvaType.ui(16, palette.ink)),
          Slider(
            value: _temp,
            min: 35.5,
            max: 37.8,
            activeColor: palette.primary,
            onChanged: (value) => setState(() => _temp = (value * 100).round() / 100),
          ),
          SoftButton(label: 'Save this morning', primary: false, onPressed: () => controller.logBbt(_temp)),
          if (controller.profile.bbt.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              controller.profile.bbt.reversed.take(5).map((point) => '${point.day}  ${point.celsius.toStringAsFixed(2)}').join('\n'),
              style: EvaType.ui(13, palette.muted),
            ),
          ],
          const SizedBox(height: 12),
          WordChip(
            label: controller.profile.intimacyDays.contains(today) ? 'Today noted, privately' : 'Note today, privately',
            selected: controller.profile.intimacyDays.contains(today),
            onTap: controller.toggleIntimacy,
          ),
          const SizedBox(height: 16),
          const _FocusButton(mode: 'fertility'),
        ],
      ),
    );
  }
}

class _PcosPage extends StatefulWidget {
  const _PcosPage();

  @override
  State<_PcosPage> createState() => _PcosPageState();
}

class _PcosPageState extends State<_PcosPage> {
  double _kg = 70;
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _ready = true;
    final points = EvaScope.of(context).profile.weights;
    if (points.isNotEmpty) _kg = points.last.kg.clamp(40, 140);
  }

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final day = isoDay(dateOnly(controller.now()));
    final flags = controller.profile.pcosDays.where((item) => item.day == day).expand((item) => item.flags).toSet();
    return StudioScaffold(
      eyebrow: 'PCOS',
      title: 'Symptoms over a perfect calendar',
      lede: 'Irregular cycles make date math less certain. EVA keeps confidence modest on purpose. This is not a diagnosis.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final flag in ['Fatigue after meals', 'Intense cravings', 'Acne flare', 'Coarse hair', 'Irregular bleed', 'Unrefreshing sleep'])
                WordChip(
                  label: flag,
                  selected: flags.contains(flag),
                  onTap: () => controller.togglePcos(flag),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(_pcosPattern(controller.profile), style: EvaType.ui(15, palette.ink, height: 1.45)),
          const SizedBox(height: 16),
          Text('Weight is a trend, not a grade. ${_kg.toStringAsFixed(1)} kg', style: EvaType.ui(15, palette.ink)),
          Slider(
            value: _kg,
            min: 40,
            max: 140,
            activeColor: palette.primary,
            onChanged: (value) => setState(() => _kg = (value * 10).round() / 10),
          ),
          SoftButton(label: 'Save weight', primary: false, onPressed: () => controller.logWeight(_kg)),
          const SizedBox(height: 12),
          Text(
            'Useful supports are ordinary: protein at breakfast, strength twice a week, and a steady bedtime. Ask a clinician about androgens and metabolic labs if the pattern fits. EVA will not prescribe.',
            style: EvaType.ui(14.5, palette.muted, height: 1.45),
          ),
          const SizedBox(height: 16),
          const _FocusButton(mode: 'pcos'),
        ],
      ),
    );
  }
}

class _MenopausePage extends StatelessWidget {
  const _MenopausePage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final today = isoDay(dateOnly(controller.now()));
    final todays = controller.profile.hotFlashes.where((flash) => flash.at.startsWith(today)).toList();
    final flashes = todays.length;
    final lastStrong = todays.isEmpty ? null : todays.last.strong;
    return StudioScaffold(
      eyebrow: 'Menopause',
      title: flashes == 0 ? 'A quiet log' : '$flashes today',
      lede: 'Heat, sleep, and mood. Hormone therapy is a clinician conversation, not an app setting.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              WordChip(label: 'Gentle flash', selected: lastStrong == false, onTap: () => controller.logHotFlash(false)),
              WordChip(label: 'Strong flash', selected: lastStrong == true, onTap: () => controller.logHotFlash(true)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Log the hour and go back to sleep if you can. A cooler room and a steady wake time help more people than a new gadget. Bring the pattern to a visit if life is being interrupted.',
            style: EvaType.ui(15, palette.muted, height: 1.45),
          ),
          const SizedBox(height: 16),
          const _FocusButton(mode: 'menopause'),
        ],
      ),
    );
  }
}

class _MentalPage extends StatelessWidget {
  const _MentalPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final today = isoDay(dateOnly(controller.now()));
    final log = controller.profile.logOn(today);
    final low = controller.profile.logs.where((item) => item.mood == 'low' || item.mood == 'frayed').length;
    return StudioScaffold(
      eyebrow: 'Mind',
      title: 'Beside the cycle',
      lede: 'Mood can rhyme with a phase. EVA will not score a disorder or label you.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final mood in ['Calm', 'Bright', 'Tender', 'Low', 'Frayed'])
                WordChip(
                  label: mood,
                  selected: log?.mood == mood.toLowerCase(),
                  onTap: () => controller.updateToday(mood: mood.toLowerCase()),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final stress in ['Quiet', 'Humming', 'Loud'])
                WordChip(
                  label: stress,
                  selected: log?.stress == stress.toLowerCase(),
                  onTap: () => controller.updateToday(stress: stress.toLowerCase()),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            low >= 3
                ? 'Several logs have been heavy. If that is more than a hard week, a clinician can help. If you might act on thoughts of suicide, call local emergency services. In the US or Canada, call or text 988.'
                : 'Log a few days and EVA can show whether heaviness clusters before bleeding. There is not enough yet to claim a pattern.',
            style: EvaType.ui(15, palette.muted, height: 1.45),
          ),
          const SizedBox(height: 16),
          const _BreathMinute(),
          const SizedBox(height: 16),
          const _FocusButton(mode: 'mental'),
        ],
      ),
    );
  }
}

class _BreathMinute extends StatefulWidget {
  const _BreathMinute();

  @override
  State<_BreathMinute> createState() => _BreathMinuteState();
}

class _BreathMinuteState extends State<_BreathMinute> {
  Timer? _timer;
  int _left = 0;
  bool _inhale = true;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    setState(() {
      _left = 60;
      _inhale = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_left <= 1) {
        timer.cancel();
        setState(() => _left = 0);
        return;
      }
      setState(() {
        _left -= 1;
        _inhale = ((_left ~/ 5) % 2) == 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final running = _left > 0;
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(running ? (_inhale ? 'Inhale' : 'Longer exhale') : 'One quiet minute', style: EvaType.display(26, palette.ink)),
          const SizedBox(height: 6),
          Text(
            running
                ? '$_left seconds. The exhale is the part that settles a late luteal or a loud day. Stop if you feel dizzy.'
                : 'Four counts in, six counts out. It is a minute, not a program, and it does not treat anxiety.',
            style: EvaType.ui(14.5, palette.muted, height: 1.4),
          ),
          const SizedBox(height: 12),
          SoftButton(
            label: running ? 'Breathing' : 'Start the minute',
            onPressed: running ? null : _start,
          ),
        ],
      ),
    );
  }
}

String _pcosPattern(HealthProfile profile) {
  final counts = <String, int>{};
  for (final day in profile.pcosDays) {
    for (final flag in day.flags) {
      counts[flag] = (counts[flag] ?? 0) + 1;
    }
  }
  if (counts.isEmpty) {
    return 'Log a symptom when it shows up. After a few days, the one that repeats will surface here. A checkbox is not an insulin reading.';
  }
  final top = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  if (top.first.value < 2) return 'One note so far: ${top.first.key}. A pattern needs a repeat.';
  return '${top.first.key} keeps showing up, on ${top.first.value} logged days. Bring that to a visit. EVA will not turn it into an insulin trend.';
}

class _NutritionPage extends StatelessWidget {
  const _NutritionPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final plan = nutritionFor(controller.profile, controller.brief.cycle, controller.brief.pregnancy);
    final noted = controller.profile.mealsNoted.contains(isoDay(dateOnly(controller.now())));
    return StudioScaffold(
      eyebrow: 'Nutrition',
      title: plan.title,
      lede: plan.why,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final plate in plan.plates)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassPanel(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plate.meal, style: EvaType.ui(12, palette.secondary, weight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(plate.detail, style: EvaType.ui(15, palette.ink, height: 1.4)),
                  ],
                ),
              ),
            ),
          for (final focus in plan.focuses)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('${focus.name}. ${focus.detail}', style: EvaType.ui(14, palette.muted, height: 1.4)),
            ),
          const SizedBox(height: 8),
          Text(
            'There is no calorie target. The plate follows your phase, a pregnancy, or menopause. A calorie app cannot see that.',
            style: EvaType.ui(14, palette.muted, height: 1.4),
          ),
          const SizedBox(height: 8),
          SoftButton(
            label: noted ? 'Noted for today' : 'I will eat this way today',
            onPressed: noted ? null : controller.noteMeal,
          ),
        ],
      ),
    );
  }
}

class _FitnessPage extends StatelessWidget {
  const _FitnessPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final plan = trainingFor(controller.profile, controller.brief.cycle, controller.brief.daypart);
    final done = controller.profile.workouts.contains(isoDay(dateOnly(controller.now())));
    return StudioScaffold(
      eyebrow: 'Fitness',
      title: plan.title,
      lede: plan.why,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sleepImpact(controller.brief.cycle.phase) == 'High' && !controller.profile.pregnant)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'This part of the model often comes with higher progesterone and lighter sleep. The session stays familiar. A sample night is not your sleep.',
                style: EvaType.ui(15, palette.ink, height: 1.45),
              ),
            ),
          for (final block in plan.blocks)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(block, style: EvaType.ui(16, palette.ink, height: 1.4)),
            ),
          const SizedBox(height: 8),
          Text(plan.caution, style: EvaType.ui(13.5, palette.warningInk, height: 1.4)),
          const SizedBox(height: 16),
          SoftButton(
            label: done ? 'Moved today' : 'Mark the session',
            onPressed: done ? null : controller.noteWorkout,
          ),
        ],
      ),
    );
  }
}

class _BeautyPage extends StatelessWidget {
  const _BeautyPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final skin = skinFor(controller.brief.cycle);
    final acneDays = controller.profile.logs.where((log) => log.symptoms.contains('acne')).length;
    return StudioScaffold(
      eyebrow: 'Skin',
      title: 'A forecast, not a scan',
      lede: 'This build does not upload selfies. The forecast comes from the cycle model.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (acneDays > 0) ...[
            Text(
              'You logged acne on $acneDays ${acneDays == 1 ? 'day' : 'days'}. The note below is the phase model beside that record, not a cause proven from a photo.',
              style: EvaType.ui(15, palette.ink, height: 1.45),
            ),
            const SizedBox(height: 10),
          ],
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              WordChip(label: 'Clear today', selected: false, onTap: () => controller.hear('Skin felt clear')),
              WordChip(label: 'Breaking out', selected: false, onTap: () => controller.hear('Breaking out')),
            ],
          ),
          const SizedBox(height: 10),
          Text(skin.today, style: EvaType.ui(16, palette.ink, height: 1.45)),
          const SizedBox(height: 10),
          Text(skin.ahead, style: EvaType.ui(15, palette.muted, height: 1.45)),
          const SizedBox(height: 14),
          for (final step in skin.routine)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(step, style: EvaType.ui(15, palette.ink)),
            ),
        ],
      ),
    );
  }
}

class _LabsPage extends StatelessWidget {
  const _LabsPage();

  @override
  Widget build(BuildContext context) {
    return const StudioScaffold(
      eyebrow: 'Labs',
      title: 'Plain language',
      lede: 'A sample of how EVA translates a panel. These are not your results.',
      child: Column(
        children: [
          _LabCard(
            id: 'ferritin',
            name: 'Ferritin',
            line: 'Iron storage. Heavy bleeding can lower it. Fatigue is not specific.',
            body: 'Read the number beside the range printed on the report. EVA will not start high-dose iron. Food sources are lentils, beans, meat, and fortified grains, with fruit alongside.',
          ),
          SizedBox(height: 10),
          _LabCard(
            id: 'tsh',
            name: 'TSH',
            line: 'A pituitary signal to the thyroid. The cutoff is the lab\'s, not a chat\'s.',
            body: 'High or low can mean the thyroid is under-active or over-active, and it can also be a timing or medication story. A clinician reads it with symptoms and sometimes free T4.',
          ),
          SizedBox(height: 10),
          _LabCard(
            id: 'estradiol',
            name: 'Estradiol',
            line: 'Meaningless without the cycle day.',
            body: 'Estrogen rises toward ovulation and falls before bleeding. A single value from an unknown day is easy to misread. Ask what day the blood was drawn.',
          ),
        ],
      ),
    );
  }
}

class _LabCard extends StatefulWidget {
  const _LabCard({required this.id, required this.name, required this.line, required this.body});

  final String id;
  final String name;
  final String line;
  final String body;

  @override
  State<_LabCard> createState() => _LabCardState();
}

class _LabCardState extends State<_LabCard> {
  bool? _open;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final saved = EvaScope.of(context).profile.labsOpened.contains(widget.id);
    final open = _open ?? saved;
    return GlassPanel(
      onTap: () {
        EvaScope.of(context).openLab(widget.id);
        setState(() => _open = !open);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style: EvaType.display(26, palette.ink)),
          const SizedBox(height: 4),
          Text(widget.line, style: EvaType.ui(14, palette.muted)),
          if (open) ...[
            const SizedBox(height: 8),
            Text(widget.body, style: EvaType.ui(14.5, palette.ink, height: 1.45)),
          ],
        ],
      ),
    );
  }
}

class _CommunityPage extends StatefulWidget {
  const _CommunityPage();

  @override
  State<_CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<_CommunityPage> {
  String _space = 'Rhythm';
  final _body = TextEditingController();

  @override
  void initState() {
    super.initState();
    _body.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final posts = [
      ...seedPosts.where((post) => post.space == _space),
      ...controller.profile.posts.where((post) => post.space == _space),
    ];
    return StudioScaffold(
      eyebrow: 'Community',
      title: _space,
      lede: 'The notes already here are written examples, not other people. Yours stay on this device. Nobody here is your clinician.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final space in studioSpaces)
                WordChip(label: space, selected: _space == space, onTap: () => setState(() => _space = space)),
            ],
          ),
          const SizedBox(height: 12),
          WordChip(
            label: controller.profile.communityVerified ? 'Showing your name' : 'Anonymous as ${controller.profile.communityAlias}',
            selected: controller.profile.communityVerified,
            onTap: () => controller.setCommunityVerified(!controller.profile.communityVerified),
          ),
          const SizedBox(height: 12),
          for (final post in posts)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassPanel(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.id.startsWith('seed-') ? 'Example · ${post.author}' : post.author,
                      style: EvaType.ui(12, palette.secondary, weight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(post.body, style: EvaType.ui(15, palette.ink, height: 1.4)),
                  ],
                ),
              ),
            ),
          TextField(
            controller: _body,
            maxLength: 280,
            maxLines: 3,
            style: EvaType.ui(15, palette.ink),
            decoration: InputDecoration(
              hintText: 'Share what helped, not a diagnosis',
              hintStyle: EvaType.ui(15, palette.faint),
              border: InputBorder.none,
              counterStyle: EvaType.ui(11, palette.faint),
            ),
          ),
          SoftButton(
            label: 'Share',
            onPressed: _body.text.trim().isEmpty
                ? null
                : () {
                    controller.publish(_space, _body.text);
                    _body.clear();
                  },
          ),
        ],
      ),
    );
  }
}

class _WearablesPage extends StatelessWidget {
  const _WearablesPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final night = controller.brief.wearable;
    return StudioScaffold(
      eyebrow: 'Wearables',
      title: 'Sleep, when you allow it',
      lede: 'Apple Watch, Garmin, Fitbit, Samsung, and Oura would arrive through HealthKit and Health Connect. This build can preview a night without sending it anywhere.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final source in ['Apple Watch', 'Oura Ring', 'Garmin', 'Fitbit', 'Samsung Watch'])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('$source  ·  not connected in this build', style: EvaType.ui(15, palette.ink)),
            ),
          const SizedBox(height: 8),
          SoftButton(
            label: controller.profile.wearableSample ? 'Hide the sample night' : 'Preview a ring night',
            onPressed: () => controller.setWearable(!controller.profile.wearableSample),
          ),
          if (night != null) ...[
            const SizedBox(height: 12),
            GlassPanel(
              child: Text(
                'Sleep ${night.sleep}\nHRV ${night.hrv}\nResting heart ${night.restingHeart}\nTemperature ${night.temperature}',
                style: EvaType.ui(16, palette.ink, height: 1.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrivacyPage extends StatelessWidget {
  const _PrivacyPage();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    return StudioScaffold(
      eyebrow: 'Privacy',
      title: 'Yours, on this device',
      lede: 'Educational information only. Not a doctor, not a diagnosis, not contraception. These notices describe this build. Have counsel review them before a public store submission.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordChip(
            label: controller.profile.localFirst ? 'Local-first is on' : 'Local-first is off',
            selected: controller.profile.localFirst,
            onTap: () => controller.setLocalFirst(!controller.profile.localFirst),
          ),
          const SizedBox(height: 14),
          Text('Privacy', style: EvaType.display(22, palette.ink)),
          const SizedBox(height: 6),
          Text(
            'The profile you type stays on this device until you delete it. Nothing is sold. EVA does not use the notes to train a model. If you launch with Supabase, the same profile is stored in that project.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 12),
          Text('Terms', style: EvaType.display(22, palette.ink)),
          const SizedBox(height: 6),
          Text(
            'EVA is educational guidance, not a medical device, not contraception, and not for emergencies. You make medical decisions with a clinician. You must be 16 or older.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 12),
          Text('Cookies', style: EvaType.display(22, palette.ink)),
          const SizedBox(height: 6),
          Text(
            'This build does not set advertising cookies. The browser may keep the local profile in site storage so the app can open again.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 12),
          Text('Health data', style: EvaType.display(22, palette.ink)),
          const SizedBox(height: 6),
          Text(
            'Cycle notes, symptoms, and chat are health data you choose to type. Storage starts only after you confirm you are 16 or older and agree. You can export or delete it below.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 12),
          Text('Retention', style: EvaType.display(22, palette.ink)),
          const SizedBox(height: 6),
          Text(
            'Notes stay until you delete the profile. There is no separate archive. A copy you already exported is yours to delete.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 12),
          Text('GDPR and CCPA', style: EvaType.display(22, palette.ink)),
          const SizedBox(height: 6),
          Text(
            'Access and portability are the export button. Correction is editing your notes. Deletion is the delete button. This build does not run a request desk and does not claim a certified program. To opt out of storage, delete the profile and stop using EVA.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 16),
          SoftButton(
            label: 'Export this profile',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: jsonEncode(controller.profile.toJson())));
              controller.say('Exported to the clipboard. A copy you keep is yours to delete.');
            },
          ),
          const SizedBox(height: 8),
          SoftButton(
            label: 'Delete this profile',
            onPressed: () => showEvaSheet(
              context,
              title: 'Delete the profile?',
              body: 'This clears the on-device profile. If Supabase is configured, it also removes that profile row and signs out. It cannot delete the authentication user, or a copy you already exported.',
              child: SoftButton(
                label: 'Delete',
                onPressed: () async {
                  final message = await controller.deleteAll();
                  if (!context.mounted) return;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  controller.say(message);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
