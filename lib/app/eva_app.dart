import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/features/launch/launch_page.dart';
import 'package:eva_ai/features/shell/app_shell.dart';
import 'package:eva_ai/features/shell/eva_search.dart';
import 'package:flutter/material.dart';

class EvaApp extends StatefulWidget {
  const EvaApp({super.key, required this.repository});

  final HealthRepository repository;

  @override
  State<EvaApp> createState() => _EvaAppState();
}

class _EvaAppState extends State<EvaApp> {
  late final EvaController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EvaController(repository: widget.repository);
    _controller.boot();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EvaScope(
      controller: _controller,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return MaterialApp(
            title: 'EVA',
            debugShowCheckedModeBanner: false,
            scrollBehavior: const EvaScrollBehavior(),
            theme: evaTheme(EvaPalette.lightTheme),
            darkTheme: evaTheme(EvaPalette.darkTheme),
            themeMode: _controller.themeMode,
            builder: (context, child) {
              final toast = EvaScope.of(context).toast;
              return Stack(
                children: [
                  if (child != null) child,
                  if (_controller.ready && _controller.profile.name.isNotEmpty)
                    Positioned(
                      right: 18,
                      bottom: MediaQuery.sizeOf(context).width >= 980 ? 22 : 118,
                      child: const _AskEvaButton(),
                    ),
                  if (toast != null)
                    Positioned(
                      top: MediaQuery.paddingOf(context).top + 12,
                      left: 24,
                      right: 24,
                      child: IgnorePointer(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 360),
                            child: GlassPanel(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              radius: 18,
                              child: Text(toast, textAlign: TextAlign.center, style: EvaType.ui(14, evaOf(context).ink, weight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
            home: const _Root(),
          );
        },
      ),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final child = !controller.ready
        ? const LaunchSplash(key: ValueKey('splash'))
        : controller.minorBlocked || !controller.profile.healthReady
            ? const LaunchGate(key: ValueKey('gate'))
            : controller.profile.name.isEmpty
                ? const NameCeremony(key: ValueKey('name'))
                : const AppShell(key: ValueKey('shell'));
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: child,
    );
  }
}

class _AskEvaButton extends StatelessWidget {
  const _AskEvaButton();

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    return Semantics(
      button: true,
      label: 'Ask EVA',
      child: GestureDetector(
        onTap: () => _open(context),
        child: Container(
          width: 58,
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: palette.primary,
            border: Border.all(color: palette.line),
          ),
          child: const EvaMark(size: 28),
        ),
      ),
    );
  }

  void _open(BuildContext host) {
    final text = TextEditingController();
    final palette = evaOf(host);
    showEvaSheet(
      host,
      title: 'Ask EVA',
      body: 'A sentence is enough. Exhausted, cramps, or a real question. EVA files what it recognizes and answers the rest.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: text,
            autofocus: true,
            style: EvaType.ui(16, palette.ink),
            decoration: InputDecoration(
              hintText: "I'm exhausted",
              hintStyle: EvaType.ui(16, palette.faint),
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              EvaScope.of(host).hear(value);
              Navigator.of(host).pop();
            },
          ),
          SoftButton(
            label: 'Send',
            onPressed: () {
              EvaScope.of(host).hear(text.text);
              Navigator.of(host).pop();
            },
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              WordChip(
                label: 'Search',
                selected: false,
                onTap: () {
                  Navigator.of(host).pop();
                  openEvaSearch(host);
                },
              ),
              WordChip(
                label: 'Full conversation',
                selected: false,
                onTap: () {
                  Navigator.of(host).popUntil((route) => route.isFirst);
                  EvaScope.of(host).requestSection(2);
                },
              ),
            ],
          ),
        ],
      ),
    ).whenComplete(text.dispose);
  }
}
