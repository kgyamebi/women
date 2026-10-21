import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:eva_ai/features/studio/experience_page.dart';
import 'package:eva_ai/features/today/today_page.dart';
import 'package:flutter/material.dart';

class YouPage extends StatelessWidget {
  const YouPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final profile = controller.profile;
    final signals = profileSignals(profile);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Eyebrow(text: 'Your profile'),
                    const SizedBox(height: 8),
                    Text(profile.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: EvaType.display(48, palette.ink)),
                    const SizedBox(height: 6),
                    Text(
                      '$signals of 7 signals in the profile. The rest arrives as you live with EVA, not as a setup form.',
                      style: EvaType.ui(15, palette.muted, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _weekLine(controller),
                      style: EvaType.ui(15, palette.ink, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        WordChip(label: 'Change name', selected: false, onTap: () => _rename(context)),
                        WordChip(label: 'Adjust rhythm', selected: false, onTap: () => openTimingSheet(context)),
                        WordChip(label: 'Change focus', selected: false, onTap: () => openIntentionSheet(context)),
                        WordChip(label: 'Update context', selected: false, onTap: () => openContextSheet(context)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _stat(palette, 'Streak', profile.streak == 0 ? 'Begin' : '${profile.streak}d')),
                        const SizedBox(width: 12),
                        Expanded(child: _stat(palette, 'Focus', _focusLabel(profile.focus))),
                        const SizedBox(width: 12),
                        Expanded(child: _stat(palette, 'Alias', profile.communityAlias)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Life stage', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.4)),
                    const SizedBox(height: 8),
                    Text(stageLine(profile.focus), style: EvaType.ui(14, palette.ink, height: 1.4)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final stage in lifeStages)
                          WordChip(
                            label: stage.$2,
                            selected: profile.focus == stage.$1,
                            onTap: () => controller.setFocus(stage.$1),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Appearance', style: EvaType.ui(13, palette.muted, weight: FontWeight.w600, tracking: 0.4)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final theme in [('system', 'System'), ('dark', 'Dark'), ('light', 'Light')])
                          WordChip(
                            label: theme.$2,
                            selected: profile.theme == theme.$1,
                            onTap: () => controller.setTheme(theme.$1),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Milestones', style: EvaType.display(30, palette.ink)),
                    const SizedBox(height: 8),
                    if (profile.milestones.isEmpty)
                      Text('They will appear quietly. No confetti.', style: EvaType.ui(14, palette.muted))
                    else
                      for (final id in profile.milestones)
                        if (milestoneCopy[id] != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(milestoneCopy[id]!, style: EvaType.ui(16, palette.ink)),
                          ),
                    const SizedBox(height: 12),
                    Text('Watching quietly', style: EvaType.display(30, palette.ink)),
                    const SizedBox(height: 8),
                    if (controller.brief.notes.isEmpty)
                      Text(
                        'No alerts. EVA speaks up only when a pattern repeats, and it will not diagnose you.',
                        style: EvaType.ui(14.5, palette.muted, height: 1.4),
                      )
                    else
                      for (final note in controller.brief.notes)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GlassPanel(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(note.title, style: EvaType.ui(14, palette.ink, weight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(note.body, style: EvaType.ui(14, palette.muted, height: 1.4)),
                              ],
                            ),
                          ),
                        ),
                    const SizedBox(height: 8),
                    SoftButton(
                      label: 'Privacy vault',
                      primary: false,
                      onPressed: () => Navigator.of(context).push(evaRoute(const ExperiencePage(id: 'privacy'))),
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

  Widget _stat(EvaPalette palette, String label, String value) {
    return GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: EvaType.ui(12, palette.muted)),
          const SizedBox(height: 6),
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: EvaType.display(22, palette.ink)),
        ],
      ),
    );
  }

  String _weekLine(EvaController controller) {
    final start = dateOnly(shiftDays(controller.now(), -6));
    final notes = controller.profile.logs.where((log) {
      final day = tryParseDay(log.day);
      return day != null && !day.isBefore(start);
    }).length;
    if (notes == 0) {
      return 'This week is still quiet, and the brief still shows up morning, afternoon, evening, and night. You do not have to log for it to be here.';
    }
    return 'This week, $notes ${notes == 1 ? 'note' : 'notes'}. The brief keeps the day. The notes make the forecast personal.';
  }

  void _rename(BuildContext context) {
    final controller = EvaScope.of(context);
    final text = TextEditingController(text: controller.profile.name);
    showEvaSheet(
      context,
      title: 'What should I call you?',
      body: 'The name stays with this profile. The community alias updates with it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: text,
            autofocus: true,
            style: EvaType.ui(18, evaOf(context).ink),
            decoration: InputDecoration(
              hintText: 'Your name',
              hintStyle: EvaType.ui(18, evaOf(context).faint),
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              controller.setName(value);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
          SoftButton(
            label: 'Save',
            onPressed: () {
              controller.setName(text.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ).whenComplete(text.dispose);
  }

  String _focusLabel(String focus) {
    switch (focus) {
      case 'pregnancy':
        return 'Pregnancy';
      case 'fertility':
        return 'Fertility';
      case 'pcos':
        return 'PCOS';
      case 'menopause':
        return 'Menopause';
      case 'mental':
        return 'Mind';
      default:
        return stageLabel(focus);
    }
  }
}
