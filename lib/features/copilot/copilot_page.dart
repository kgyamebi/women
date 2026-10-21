import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:flutter/material.dart';

class CopilotPage extends StatefulWidget {
  const CopilotPage({super.key});

  @override
  State<CopilotPage> createState() => _CopilotPageState();
}

class _CopilotPageState extends State<CopilotPage> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  int _seen = 0;

  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      if (mounted) setState(() {});
    });
  }

  static const _prompts = [
    'Why do I always get headaches before my period?',
    'Can PCOS cause weight gain?',
    'What does this blood test mean?',
    'What does this discharge color indicate?',
  ];

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final chat = controller.profile.chat;
    if (chat.length != _seen) {
      _seen = chat.length;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_scroll.hasClients) return;
        _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 220), curve: Curves.easeOut);
      });
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
              child: Column(
                children: [
                  Expanded(
                    child: chat.isEmpty
                        ? _empty(context, palette)
                        : ListView.builder(
                            controller: _scroll,
                            itemCount: chat.length,
                            itemBuilder: (context, index) {
                              final turn = chat[index];
                              final mine = turn.role == 'you';
                              return Align(
                                alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 560),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: mine ? palette.primary : palette.glass,
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(color: mine ? Colors.transparent : palette.line),
                                  ),
                                  child: Text(
                                    turn.text,
                                    style: EvaType.ui(15.5, mine ? palette.onPrimary : palette.ink, height: 1.45),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  if (chat.isEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final prompt in _prompts)
                          WordChip(label: prompt, selected: false, onTap: () => _send(context, prompt)),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GlassPanel(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          radius: 22,
                          child: TextField(
                            controller: _input,
                            minLines: 1,
                            maxLines: 4,
                            style: EvaType.ui(15, palette.ink),
                            decoration: InputDecoration(
                              hintText: 'Ask about a symptom, a lab, a mood',
                              hintStyle: EvaType.ui(15, palette.faint),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) => _send(context, value),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SoftButton(
                        label: 'Send',
                        onPressed: _input.text.trim().isEmpty ? null : () => _send(context, _input.text),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Using your cycle, focus, and logs. Educational guidance. Not a diagnosis or an emergency service.',
                    style: EvaType.ui(11.5, palette.faint),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _empty(BuildContext context, EvaPalette palette) {
    final brief = EvaScope.of(context).brief;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EvaMark(size: 56),
        const SizedBox(height: 16),
        Text('Ask EVA', style: EvaType.display(42, palette.ink)),
        const SizedBox(height: 8),
        Text(
          'I already have ${brief.orbKicker.toLowerCase()} in mind. Ask in your own words.',
          style: EvaType.ui(16, palette.muted),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _send(BuildContext context, String text) {
    if (text.trim().isEmpty) return;
    EvaScope.of(context).ask(text);
    _input.clear();
  }
}
