import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:eva_ai/features/launch/launch_page.dart';
import 'package:eva_ai/features/shell/app_shell.dart';
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
            title: 'EVA AI',
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
