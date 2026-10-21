import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';

class LaunchSplash extends StatelessWidget {
  const LaunchSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AmbientField(calm: daypartOf(DateTime.now()) == Daypart.night),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(offset: Offset(0, 18 * (1 - value)), child: child),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const EvaMark(size: 72),
                  const SizedBox(height: 22),
                  Text('EVA', style: EvaType.display(64, palette.ink, weight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(
                    'Educational guidance. Not a doctor, not a diagnosis, not contraception.',
                    style: EvaType.ui(16, palette.muted),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NameCeremony extends StatefulWidget {
  const NameCeremony({super.key});

  @override
  State<NameCeremony> createState() => _NameCeremonyState();
}

class _NameCeremonyState extends State<NameCeremony> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final ready = _name.text.trim().isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const AmbientField(),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const Eyebrow(text: 'A quiet introduction'),
                      const SizedBox(height: 12),
                      Text('What should I call you?', style: EvaType.display(48, palette.ink)),
                      const SizedBox(height: 8),
                      Text(
                        'I will use it when I greet you. You can change it later.',
                        style: EvaType.ui(16, palette.muted),
                      ),
                      const SizedBox(height: 28),
                      TextField(
                        controller: _name,
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        style: EvaType.display(40, palette.ink),
                        cursorColor: palette.accent,
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => _enter(context),
                        decoration: InputDecoration(
                          hintText: 'Your name',
                          hintStyle: EvaType.display(40, palette.faint),
                          border: InputBorder.none,
                        ),
                      ),
                      Container(height: 1, color: palette.line),
                      const Spacer(),
                      SoftButton(
                        label: 'Enter',
                        onPressed: ready ? () => _enter(context) : null,
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _enter(BuildContext context) {
    EvaScope.of(context).setName(_name.text);
  }
}

class LaunchGate extends StatelessWidget {
  const LaunchGate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    if (controller.minorBlocked) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text('EVA is not for anyone under 16.', style: EvaType.display(40, palette.ink)),
                const SizedBox(height: 12),
                Text(
                  'No health notes were saved. A parent or clinician is the right place for care under 16.',
                  style: EvaType.ui(16, palette.muted, height: 1.4),
                ),
                const Spacer(),
                SoftButton(label: 'Back', onPressed: controller.clearMinorBlock),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      );
    }
    final affirmed = controller.profile.ageAffirmed;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
              children: [
                const Eyebrow(text: 'Before anything is stored'),
                const SizedBox(height: 12),
                Text('Educational guidance', style: EvaType.display(42, palette.ink)),
                const SizedBox(height: 10),
                Text(
                  'EVA is not a doctor, not a diagnosis, and not contraception. It stores the notes you type on this device so it can show them back to you.',
                  style: EvaType.ui(16, palette.muted, height: 1.45),
                ),
                const SizedBox(height: 18),
                WordChip(label: 'I am 16 or older', selected: affirmed, onTap: controller.affirmAge),
                const SizedBox(height: 8),
                WordChip(label: 'I am under 16', selected: false, onTap: controller.blockMinor),
                const SizedBox(height: 18),
                SoftButton(
                  label: 'Agree and continue',
                  onPressed: affirmed ? controller.acceptHealthConsent : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
