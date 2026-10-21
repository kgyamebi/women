import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';

class ShortcutsPage extends StatelessWidget {
  const ShortcutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final shortcuts = controller.profile.shortcuts;
    return StudioScaffold(
      eyebrow: 'Less typing',
      title: 'Shortcuts',
      lede: 'A shortcut is a copy of a day you logged. Tapping it writes that copy onto today. It does not decide how today feels.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'On Today, Nothing new uses your latest shortcut. With no shortcut, it copies your latest note. Undo puts today back.',
            style: EvaType.ui(15, palette.ink, height: 1.45),
          ),
          const SizedBox(height: 16),
          if (shortcuts.isEmpty)
            Text(
              'Log something, then tap Save today as a shortcut. Until then this list stays empty.',
              style: EvaType.ui(15, palette.muted, height: 1.45),
            )
          else
            for (final shortcut in shortcuts) ...[
              Row(
                children: [
                  Expanded(child: Text(shortcut.name, style: EvaType.ui(16, palette.ink, weight: FontWeight.w600))),
                  TextButton(onPressed: () => controller.removeShortcut(shortcut.id), child: const Text('Remove')),
                ],
              ),
              Text(_detail(shortcut), style: EvaType.ui(13, palette.faint, height: 1.4)),
              const SizedBox(height: 8),
              WordChip(label: 'Use ${shortcut.name}', selected: false, onTap: () => controller.applyShortcut(shortcut.id)),
              const SizedBox(height: 16),
            ],
        ],
      ),
    );
  }

  String _detail(LogShortcut shortcut) {
    final parts = <String>[];
    if (shortcut.flow > 0 && shortcut.flow < 4) {
      parts.add(const ['', 'Light flow', 'Medium flow', 'Heavy flow'][shortcut.flow]);
    }
    if (shortcut.mood.isNotEmpty) parts.add(shortcut.mood);
    if (shortcut.symptoms.isNotEmpty) parts.add(shortcut.symptoms.map(noteLabel).join(', '));
    if (parts.isEmpty) return 'Saved from a note that had no symptom list.';
    return parts.join(' · ');
  }
}
