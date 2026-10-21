import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:eva_ai/features/today/today_page.dart';
import 'package:flutter/material.dart';

class RhythmPage extends StatelessWidget {
  const RhythmPage({super.key});

  static const _flows = ['None', 'Light', 'Medium', 'Heavy'];
  static const _moods = ['Calm', 'Bright', 'Tender', 'Low', 'Frayed'];
  static const _symptoms = ['Headache', 'Cramp', 'Bloat', 'Acne', 'Fatigue', 'Craving', 'Tenderness', 'Insomnia'];
  static const _energy = [('Depleted', 0.15), ('Soft', 0.35), ('Steady', 0.55), ('Bright', 0.75), ('Electric', 0.95)];

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final brief = controller.brief;
    final palette = evaOf(context);
    final today = isoDay(dateOnly(controller.now()));
    final log = controller.profile.logOn(today);
    final cycle = brief.cycle;
    final trust = cycleTrust(controller.profile);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Column(
                  children: [
                    const Align(alignment: Alignment.centerLeft, child: Eyebrow(text: 'Rhythm')),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('A calendar, not a blood test', style: EvaType.display(40, palette.ink)),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Predictions stay honest about how they were made.',
                        style: EvaType.ui(15, palette.muted),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (!controller.profile.timingConfirmed)
                      Text(
                        'Not enough information yet. Save a period date before a day, a fertile window, or a next period is estimated.',
                        style: EvaType.ui(15, palette.ink, height: 1.4),
                      )
                    else ...[
                      CycleDial(
                        length: cycle.length,
                        today: cycle.day,
                        periodLength: controller.profile.periodLength,
                      ),
                      const SizedBox(height: 8),
                      _prediction(palette, 'Next period', prettyDay(cycle.nextPeriod), trust.label),
                      _prediction(palette, 'Ovulation estimate', prettyDay(cycle.ovulation), 'Estimate, not a test'),
                      _prediction(
                        palette,
                        'Fertile window',
                        '${prettyDay(cycle.fertileStart)} – ${prettyDay(cycle.fertileEnd)}',
                        'Not contraception',
                      ),
                      _prediction(palette, 'PMS window', prettyDay(cycle.pmsStart), 'Often, not always'),
                      const SizedBox(height: 8),
                      Text(trust.evidence, style: EvaType.ui(13, palette.faint, height: 1.4)),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      'Temperature or an ovulation test would make this physiological. The window is not a promise, and it is not birth control.',
                      style: EvaType.ui(13, palette.faint, height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    Align(alignment: Alignment.centerLeft, child: Text('Today, in words', style: EvaType.display(28, palette.ink))),
                    const SizedBox(height: 12),
                    _label(palette, 'Flow'),
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
                    if (log?.flow == 3) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Soaking through protection every hour is a reason to seek urgent care.',
                        style: EvaType.ui(13, palette.warningInk),
                      ),
                    ],
                    const SizedBox(height: 14),
                    _label(palette, 'Mood'),
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
                    const SizedBox(height: 14),
                    _label(palette, 'Energy'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final item in _energy)
                          WordChip(
                            label: item.$1,
                            selected: log?.energy == item.$2,
                            onTap: () => controller.updateToday(energy: item.$2, setEnergy: true),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _label(palette, 'Body'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final symptom in _symptoms)
                          WordChip(
                            label: symptom,
                            selected: log?.symptoms.contains(symptom.toLowerCase()) ?? false,
                            onTap: () {
                              final current = [...?log?.symptoms];
                              final id = symptom.toLowerCase();
                              if (current.contains(id)) {
                                current.remove(id);
                              } else {
                                current.add(id);
                              }
                              controller.updateToday(symptoms: current);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SoftButton(
                      label: 'Adjust the rhythm',
                      primary: false,
                      onPressed: () => openTimingSheet(context),
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

  Widget _label(EvaPalette palette, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.4)),
      ),
    );
  }

  Widget _prediction(EvaPalette palette, String label, String value, String meta) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassPanel(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        radius: 20,
        child: Row(
          children: [
            Expanded(child: Text(label, style: EvaType.ui(14, palette.muted))),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value, textAlign: TextAlign.end, style: EvaType.ui(14, palette.ink, weight: FontWeight.w600)),
                  Text(meta, textAlign: TextAlign.end, style: EvaType.ui(12, palette.faint)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
