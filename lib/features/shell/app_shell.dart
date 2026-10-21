import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/features/copilot/copilot_page.dart';
import 'package:eva_ai/features/rhythm/rhythm_page.dart';
import 'package:eva_ai/features/today/today_page.dart';
import 'package:eva_ai/features/twin/twin_page.dart';
import 'package:eva_ai/features/you/you_page.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  void select(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 980;
    final calm = controller.brief.daypart.name == 'night';
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AmbientField(calm: calm),
          Padding(
            padding: EdgeInsets.only(left: wide ? 118 : 0, bottom: wide ? 0 : 108),
            child: IndexedStack(
              index: _index,
              children: const [
                TodayPage(),
                RhythmPage(),
                CopilotPage(),
                TwinPage(),
                YouPage(),
              ],
            ),
          ),
          if (wide)
            const Positioned(left: 16, top: 16, bottom: 16, child: _RailProxy())
          else
            const Positioned(left: 16, right: 16, bottom: 14, child: _DockProxy()),
        ],
      ),
    );
  }
}

class _DockProxy extends StatelessWidget {
  const _DockProxy();

  @override
  Widget build(BuildContext context) {
    final shell = context.findAncestorStateOfType<_AppShellState>();
    return EvaNav(
      index: shell?._index ?? 0,
      onChanged: (index) {
        shell?.select(index);
        if (index == 3) EvaScope.of(context).noteTwinOpened();
      },
    );
  }
}

class _RailProxy extends StatelessWidget {
  const _RailProxy();

  @override
  Widget build(BuildContext context) {
    final shell = context.findAncestorStateOfType<_AppShellState>();
    return EvaNav(
      rail: true,
      index: shell?._index ?? 0,
      onChanged: (index) {
        shell?.select(index);
        if (index == 3) EvaScope.of(context).noteTwinOpened();
      },
    );
  }
}
