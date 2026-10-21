import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';

class TwinPage extends StatefulWidget {
  const TwinPage({super.key});

  @override
  State<TwinPage> createState() => _TwinPageState();
}

class _TwinPageState extends State<TwinPage> {
  int? _day;

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final cycle = controller.brief.cycle;
    final day = _day ?? cycle.day;
    final twin = buildTwin(controller.profile, day);
    final paused = controller.profile.pregnant || controller.profile.focus == 'menopause';
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Eyebrow(text: 'Hormone twin'),
                    const SizedBox(height: 8),
                    Text('A sketch of a cycle', style: EvaType.display(46, palette.ink)),
                    const SizedBox(height: 8),
                    Text(
                      paused
                          ? 'This drawing is a textbook menstrual cycle. It is paused as a portrait of you while pregnancy or menopause is leading.'
                          : 'Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood.',
                      style: EvaType.ui(15.5, palette.muted, height: 1.45),
                    ),
                    const SizedBox(height: 16),
                    GlassPanel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HormoneChart(
                            series: hormoneSeries(cycle.length),
                            todayIndex: cycle.day - 1,
                            selectedIndex: day - 1,
                            height: 240,
                            onSelect: paused ? null : (index) => setState(() => _day = index + 1),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 14,
                            runSpacing: 6,
                            children: [
                              LegendDot(color: palette.primary, label: 'Estrogen'),
                              LegendDot(color: palette.accent, label: 'Progesterone'),
                              LegendDot(color: palette.warning, label: 'Testosterone'),
                              LegendDot(color: palette.success, label: 'Cortisol'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text('Day ${twin.day} · ${phaseLabel(twin.phase)}', style: EvaType.display(28, palette.ink)),
                    const SizedBox(height: 8),
                    Text(twin.personal, style: EvaType.ui(14.5, palette.muted, height: 1.4)),
                    const SizedBox(height: 14),
                    _metricWrap(twin.hormones),
                    const SizedBox(height: 16),
                    Text('Typical associations', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.5)),
                    const SizedBox(height: 8),
                    _metricWrap(twin.forecasts),
                    const SizedBox(height: 16),
                    Text(
                      'Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.',
                      style: EvaType.ui(12.5, palette.faint, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricWrap(List<TwinMetric> metrics) {
    final palette = evaOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 640 ? 4 : 2;
        final width = (constraints.maxWidth - (columns - 1) * 10) / columns;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final metric in metrics)
              SizedBox(
                width: width,
                child: GlassPanel(
                  padding: const EdgeInsets.all(14),
                  radius: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(metric.label, style: EvaType.ui(12, palette.muted)),
                      const SizedBox(height: 6),
                      Text(metric.value, style: EvaType.display(22, palette.ink)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: metric.level.clamp(0, 1),
                          minHeight: 4,
                          backgroundColor: palette.line,
                          color: palette.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
