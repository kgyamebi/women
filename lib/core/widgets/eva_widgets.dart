import 'dart:math' as math;
import 'dart:ui';

import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmbientField extends StatefulWidget {
  const AmbientField({super.key, this.calm = false});

  final bool calm;

  @override
  State<AmbientField> createState() => _AmbientFieldState();
}

class _AmbientFieldState extends State<AmbientField> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 28));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.disableAnimationsOf(context);
    if (reduce) {
      _controller.value = 0.2;
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _AuroraPainter(
              t: _controller.value,
              palette: palette,
              calm: widget.calm,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter({required this.t, required this.palette, required this.calm});

  final double t;
  final EvaPalette palette;
  final bool calm;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..color = palette.bg);
    final travel = calm ? 0.45 : 1.0;
    final alpha = calm ? 0.62 : 1.0;
    void blob(Offset center, double radius, Color color) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            color.withValues(alpha: (palette.dark ? 0.55 : 0.38) * alpha),
            color.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    final angle = t * math.pi * 2 * travel;
    blob(
      Offset(size.width * (0.18 + 0.08 * math.sin(angle)), size.height * 0.18),
      size.width * 0.62,
      palette.primary,
    );
    blob(
      Offset(size.width * (0.86 + 0.05 * math.cos(angle)), size.height * (0.32 + 0.04 * math.sin(angle))),
      size.width * 0.5,
      palette.accent,
    );
    blob(
      Offset(size.width * 0.42, size.height * (0.92 + 0.03 * math.cos(angle))),
      size.width * 0.58,
      palette.secondary,
    );

    final rng = math.Random(7);
    final dust = Paint()..color = palette.ink.withValues(alpha: palette.dark ? 0.18 : 0.08);
    for (var i = 0; i < 22; i++) {
      final seed = rng.nextDouble();
      final x = (seed * size.width + math.sin(angle + i) * 12) % size.width;
      final y = (rng.nextDouble() * size.height + t * size.height * 0.15) % size.height;
      canvas.drawCircle(Offset(x, y), rng.nextDouble() * 1.4 + 0.4, dust);
    }

    final vignette = Paint()
      ..shader = RadialGradient(
        radius: 1.05,
        colors: [
          const Color(0x00000000),
          palette.bg.withValues(alpha: palette.dark ? 0.72 : 0.35),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, vignette);
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.palette.dark != palette.dark || oldDelegate.calm != calm;
  }
}

class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 28,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final panel = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: palette.glass,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: palette.line),
            boxShadow: [
              BoxShadow(color: palette.shadow, blurRadius: 28, offset: const Offset(0, 16)),
            ],
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
    if (onTap == null) return panel;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: panel),
    );
  }
}

class EvaMark extends StatelessWidget {
  const EvaMark({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return CustomPaint(
      size: Size.square(size),
      painter: _MarkPainter(palette),
    );
  }
}

class _MarkPainter extends CustomPainter {
  _MarkPainter(this.palette);

  final EvaPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [palette.primary.withValues(alpha: 0.9), palette.accent.withValues(alpha: 0.1)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, glow);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.92);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.58),
      -0.6,
      4.2,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _MarkPainter oldDelegate) => oldDelegate.palette.dark != palette.dark;
}

class PhaseOrb extends StatefulWidget {
  const PhaseOrb({super.key, required this.kicker, required this.value, required this.color});

  final String kicker;
  final String value;
  final Color color;

  @override
  State<PhaseOrb> createState() => _PhaseOrbState();
}

class _PhaseOrbState extends State<PhaseOrb> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 16));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 0.35;
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return SizedBox(
      width: 118,
      height: 118,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _OrbPainter(t: _controller.value, color: widget.color, palette: palette),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.value,
                    style: EvaType.display(22, palette.ink, height: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter({required this.t, required this.color, required this.palette});

  final double t;
  final Color color;
  final EvaPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: 0.55), color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
    canvas.drawCircle(
      center,
      radius * 0.72,
      Paint()
        ..color = palette.dark ? const Color.fromRGBO(12, 10, 22, 0.72) : const Color.fromRGBO(255, 255, 255, 0.78),
    );
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..shader = SweepGradient(
        transform: GradientRotation(t * math.pi * 2),
        colors: [
          color.withValues(alpha: 0),
          color,
          palette.accent,
          color.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.78));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.78),
      t * math.pi * 2,
      4.4,
      false,
      ring,
    );
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) => oldDelegate.t != t || oldDelegate.color != color;
}

class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.primary = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final enabled = onPressed != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onPressed!();
              },
        child: ExcludeSemantics(child: AnimatedOpacity(
          duration: const Duration(milliseconds: 180),
          opacity: enabled ? 1 : 0.4,
          child: Container(
            height: 54,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: primary ? palette.primary : palette.glass,
              border: Border.all(color: primary ? Colors.transparent : palette.line),
            ),
            child: Text(
              label,
              style: EvaType.ui(16, primary ? palette.onPrimary : palette.ink, weight: FontWeight.w600),
            ),
          ),
        )),
      ),
    ),
    );
  }
}

class WordChip extends StatelessWidget {
  const WordChip({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width - 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? palette.primary.withValues(alpha: palette.dark ? 0.85 : 0.92) : palette.glass,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: selected ? Colors.transparent : palette.line),
          ),
          child: Text(
            label,
            softWrap: true,
            style: EvaType.ui(14.5, selected ? palette.onPrimary : palette.ink, weight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class Eyebrow extends StatelessWidget {
  const Eyebrow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: EvaType.ui(11, evaOf(context).muted, weight: FontWeight.w600, tracking: 1.6, height: 1.2),
    );
  }
}

class HormoneChart extends StatelessWidget {
  const HormoneChart({
    super.key,
    required this.series,
    required this.todayIndex,
    this.selectedIndex,
    this.onSelect,
    this.height = 220,
    this.compact = false,
  });

  final List<HormonePoint> series;
  final int todayIndex;
  final int? selectedIndex;
  final ValueChanged<int>? onSelect;
  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        void select(Offset local) {
          if (onSelect == null || series.isEmpty) return;
          final index = (local.dx / constraints.maxWidth * series.length).floor().clamp(0, series.length - 1);
          onSelect!(index);
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) => select(details.localPosition),
          onHorizontalDragUpdate: (details) => select(details.localPosition),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: CustomPaint(
              painter: _HormonePainter(
                series: series,
                todayIndex: todayIndex,
                selectedIndex: selectedIndex,
                compact: compact,
                estrogen: palette.primary,
                progesterone: palette.accent,
                testosterone: palette.warning,
                cortisol: palette.success,
                ink: palette.muted,
                grid: palette.line,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HormonePainter extends CustomPainter {
  _HormonePainter({
    required this.series,
    required this.todayIndex,
    required this.selectedIndex,
    required this.compact,
    required this.estrogen,
    required this.progesterone,
    required this.testosterone,
    required this.cortisol,
    required this.ink,
    required this.grid,
  });

  final List<HormonePoint> series;
  final int todayIndex;
  final int? selectedIndex;
  final bool compact;
  final Color estrogen;
  final Color progesterone;
  final Color testosterone;
  final Color cortisol;
  final Color ink;
  final Color grid;

  Path _smooth(Size size, double Function(HormonePoint) read) {
    final path = Path();
    if (series.isEmpty) return path;
    final points = <Offset>[];
    for (var i = 0; i < series.length; i++) {
      final x = series.length == 1 ? 0.0 : i / (series.length - 1) * size.width;
      final y = size.height - 10 - read(series[i]) * (size.height - 20);
      points.add(Offset(x, y));
    }
    path.moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final mid = Offset((current.dx + next.dx) / 2, (current.dy + next.dy) / 2);
      path.quadraticBezierTo(current.dx, current.dy, mid.dx, mid.dy);
    }
    path.lineTo(points.last.dx, points.last.dy);
    return path;
  }

  void _stroke(Canvas canvas, Path path, Color color, {required bool glow}) {
    if (glow) {
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7
          ..color = color.withValues(alpha: 0.28)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
    }
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = glow ? 2.2 : 1.6
        ..strokeCap = StrokeCap.round
        ..color = color,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!compact) {
      final gridPaint = Paint()
        ..color = grid
        ..strokeWidth = 1;
      for (var i = 1; i <= 3; i++) {
        final y = size.height * i / 4;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }
    }
    _stroke(canvas, _smooth(size, (point) => point.estrogen), estrogen, glow: !compact);
    _stroke(canvas, _smooth(size, (point) => point.progesterone), progesterone, glow: !compact);
    if (!compact) {
      _stroke(canvas, _smooth(size, (point) => point.testosterone), testosterone, glow: true);
      _stroke(canvas, _smooth(size, (point) => point.cortisol), cortisol, glow: true);
    }
    final raw = selectedIndex ?? todayIndex;
    if (raw >= 0 && series.isNotEmpty) {
      final index = raw.clamp(0, math.max(0, series.length - 1));
      final x = series.length == 1 ? 0.0 : index / (series.length - 1) * size.width;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), Paint()..color = ink.withValues(alpha: 0.45));
    }
  }

  @override
  bool shouldRepaint(covariant _HormonePainter oldDelegate) {
    return oldDelegate.todayIndex != todayIndex ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.series.length != series.length;
  }
}

class CycleDial extends StatelessWidget {
  const CycleDial({
    super.key,
    required this.length,
    required this.today,
    required this.periodLength,
    this.selected,
    this.onSelect,
  });

  final int length;
  final int today;
  final int periodLength;
  final int? selected;
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return SizedBox(
      width: 280,
      height: 280,
      child: GestureDetector(
        onTapDown: (details) {
          if (onSelect == null) return;
          final center = const Offset(140, 140);
          final delta = details.localPosition - center;
          var angle = math.atan2(delta.dy, delta.dx) + math.pi / 2;
          if (angle < 0) angle += math.pi * 2;
          final day = (angle / (math.pi * 2) * length).floor() + 1;
          onSelect!(day.clamp(1, length));
        },
        child: CustomPaint(
          painter: _DialPainter(
            length: length,
            today: today,
            periodLength: periodLength,
            selected: selected ?? today,
            palette: palette,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Day ${selected ?? today}', style: EvaType.display(36, palette.ink)),
                Text(phaseLabel(phaseFor(selected ?? today, length, periodLength)), style: EvaType.ui(13, palette.muted)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  _DialPainter({
    required this.length,
    required this.today,
    required this.periodLength,
    required this.selected,
    required this.palette,
  });

  final int length;
  final int today;
  final int periodLength;
  final int selected;
  final EvaPalette palette;

  Color _color(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return palette.accent;
      case CyclePhase.earlyFollicular:
        return palette.secondary;
      case CyclePhase.lateFollicular:
        return palette.primary;
      case CyclePhase.ovulatory:
        return palette.warning;
      case CyclePhase.earlyLuteal:
        return palette.success;
      case CyclePhase.lateLuteal:
        return palette.accent.withValues(alpha: 0.7);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;
    for (var day = 1; day <= length; day++) {
      final angle = -math.pi / 2 + (day - 1) / length * math.pi * 2;
      final point = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      final phase = phaseFor(day, length, periodLength);
      final active = day == today;
      final chosen = day == selected;
      canvas.drawCircle(
        point,
        active ? 7 : chosen ? 5.5 : 3.2,
        Paint()..color = _color(phase).withValues(alpha: active || chosen ? 1 : 0.75),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) => oldDelegate.selected != selected || oldDelegate.today != today;
}

class EvaNav extends StatelessWidget {
  const EvaNav({super.key, required this.index, required this.onChanged, this.rail = false});

  final int index;
  final ValueChanged<int> onChanged;
  final bool rail;

  static const items = [
    ('Today', Icons.wb_twilight_rounded),
    ('Rhythm', Icons.all_inclusive_rounded),
    ('Ask', Icons.auto_awesome_rounded),
    ('Twin', Icons.bubble_chart_rounded),
    ('You', Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final entries = [
      for (var i = 0; i < items.length; i++)
        _NavItem(
          label: items[i].$1,
          icon: items[i].$2,
          selected: index == i,
          featured: i == 2 && !rail,
          fill: rail,
          onTap: () => onChanged(i),
        ),
    ];
    final bar = ClipRRect(
      borderRadius: BorderRadius.circular(rail ? 32 : 30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: palette.glass,
            borderRadius: BorderRadius.circular(rail ? 32 : 30),
            border: Border.all(color: palette.line),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: rail ? 8 : 6, vertical: rail ? 14 : 8),
            child: rail
                ? Column(
                    children: [
                      const SizedBox(height: 6),
                      const EvaMark(size: 34),
                      const SizedBox(height: 18),
                      for (final entry in entries) Expanded(child: entry),
                      Text('OS', style: EvaType.ui(11, palette.faint, tracking: 1.4, weight: FontWeight.w600)),
                      const SizedBox(height: 8),
                    ],
                  )
                : Row(
                    children: [for (final entry in entries) Expanded(child: entry)],
                  ),
          ),
        ),
      ),
    );
    if (!rail) return bar;
    return SizedBox(width: 86, child: bar);
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.featured,
    required this.fill,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool featured;
  final bool fill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final color = selected ? palette.ink : palette.muted;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.selectionClick();
            onTap();
          },
          child: SizedBox(
            width: double.infinity,
            child: fill
                ? Center(child: _mark(palette, color))
                : Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: _mark(palette, color)),
          ),
        ),
      ),
    );
  }

  Widget _mark(EvaPalette palette, Color color) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutCubic,
                  width: featured ? 46 : 36,
                  height: featured ? 46 : 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: featured ? LinearGradient(colors: [palette.primary, palette.accent]) : null,
                    color: featured ? null : (selected ? palette.primary.withValues(alpha: 0.16) : Colors.transparent),
                  ),
                  child: Icon(icon, size: featured ? 22 : 20, color: featured ? Colors.white : color),
                ),
                const SizedBox(height: 4),
                Text(label, style: EvaType.ui(10.5, featured ? palette.ink : color, weight: FontWeight.w500, height: 1)),
              ],
            ),
    );
  }
}

Route<T> evaRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 180),
    reverseTransitionDuration: const Duration(milliseconds: 160),
    pageBuilder: (context, animation, secondary) => page,
    transitionsBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.035), end: Offset.zero).animate(curved),
          child: child,
        ),
      );
    },
  );
}

Future<void> showEvaSheet(
  BuildContext context, {
  required String title,
  required String body,
  Widget? child,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final palette = evaOf(context);
      final height = MediaQuery.sizeOf(context).height;
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height * 0.86),
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
              decoration: BoxDecoration(
                color: palette.dark ? const Color(0xF0141220) : const Color(0xF2FFFFFF),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: palette.line),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(color: palette.faint, borderRadius: BorderRadius.circular(99)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(title, style: EvaType.display(28, palette.ink)),
                    const SizedBox(height: 10),
                    Text(body, style: EvaType.ui(15, palette.muted, height: 1.45)),
                    if (child != null) ...[const SizedBox(height: 16), child],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class StudioScaffold extends StatelessWidget {
  const StudioScaffold({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.lede,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String lede;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const AmbientField(),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 12, 22, 40),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: Icon(Icons.arrow_back_rounded, color: palette.ink),
                        style: IconButton.styleFrom(
                          backgroundColor: palette.glass,
                          side: BorderSide(color: palette.line),
                          minimumSize: const Size(44, 44),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Eyebrow(text: eyebrow),
                    const SizedBox(height: 8),
                    Text(title, style: EvaType.display(42, palette.ink)),
                    const SizedBox(height: 10),
                    Text(lede, style: EvaType.ui(16, palette.muted, height: 1.45)),
                    const SizedBox(height: 22),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LegendDot extends StatelessWidget {
  const LegendDot({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: EvaType.ui(12, evaOf(context).muted)),
      ],
    );
  }
}
