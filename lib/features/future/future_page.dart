import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:eva_ai/features/studio/studio_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FuturePage extends StatelessWidget {
  const FuturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final profile = controller.profile;
    final now = controller.now();
    final week = seeAhead(profile, now);
    final memory = recall(profile, now);
    final found = discoveries(profile, now);
    final index = wellbeing(profile, now);
    final chapters = lifeChapters(profile);
    final reports = healthReports(profile, now);
    final rooms = {for (final link in studioLinks) link.id: link.title};

    return StudioScaffold(
      eyebrow: 'EVA Future',
      title: 'See your next 7 days',
      lede: week.note,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stageLine(profile.focus), style: EvaType.ui(15, palette.ink, height: 1.45)),
          const SizedBox(height: 8),
          Text(companionLine(profile, now), style: EvaType.ui(15, palette.muted, height: 1.45)),
          const SizedBox(height: 16),
          Text('Limit: ${week.confidence}', style: EvaType.ui(13, palette.faint)),
          const SizedBox(height: 10),
          for (final day in week.days) ...[
            _DayCard(day: day),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 16),
          Text('Memory', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          Text(memory.line, style: EvaType.ui(15, palette.ink, height: 1.45)),
          const SizedBox(height: 16),
          Text('Discoveries', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          for (final line in found)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(line, style: EvaType.ui(15, palette.ink, height: 1.45)),
            ),
          const SizedBox(height: 8),
          Text('Coach', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          Text(coachLine(profile, now), style: EvaType.ui(15, palette.ink, height: 1.45)),
          const SizedBox(height: 16),
          Text('Wellbeing', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          Text(index.caption, style: EvaType.ui(15, palette.ink, weight: FontWeight.w500, height: 1.4)),
          const SizedBox(height: 8),
          for (final part in index.parts)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '${part.name} · ${part.score ?? 'left out'} · ${part.detail}',
                style: EvaType.ui(14, palette.muted, height: 1.35),
              ),
            ),
          const SizedBox(height: 12),
          Text('Life story', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          for (final chapter in chapters)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('${chapter.label}. ${chapter.line}', style: EvaType.ui(15, palette.ink, height: 1.4)),
            ),
          const SizedBox(height: 12),
          Text('Reports', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          for (final report in reports) ...[
            Text(report.span, style: EvaType.ui(13, palette.faint)),
            const SizedBox(height: 4),
            for (final line in report.lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(line, style: EvaType.ui(15, palette.ink, height: 1.4)),
              ),
            const SizedBox(height: 6),
            SoftButton(
              label: 'Copy ${report.span.toLowerCase()}',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: report.shareText));
                controller.say('Copied. Share it only if you want to.');
              },
            ),
            const SizedBox(height: 12),
          ],
          Text('Relationship twin', style: EvaType.display(28, palette.ink)),
          const SizedBox(height: 8),
          Text(togetherLine(profile, now), style: EvaType.ui(15, palette.ink, height: 1.45)),
          const SizedBox(height: 16),
          Text(supervisorLine(profile, rooms), style: EvaType.ui(14, palette.muted, height: 1.4)),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({required this.day});

  final Horizon day;

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${day.label} · ${day.phase}', style: EvaType.ui(13, palette.secondary, weight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('Energy ${day.energy} · Mood ${day.mood} · Focus ${day.focus}', style: EvaType.ui(15, palette.ink, weight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text('Sleep ${day.sleep}. ${day.cravings}.', style: EvaType.ui(14, palette.muted, height: 1.35)),
          Text('Skin: ${day.skin}. Workout: ${day.workout}.', style: EvaType.ui(14, palette.muted, height: 1.35)),
          Text('Stress: ${day.stress}. ${day.symptom}', style: EvaType.ui(14, palette.muted, height: 1.35)),
          Text(day.event, style: EvaType.ui(14, palette.ink, height: 1.35)),
        ],
      ),
    );
  }
}
