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
                    'Your personal women\'s health intelligence',
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
