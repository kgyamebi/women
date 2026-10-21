import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/features/studio/experience_page.dart';
import 'package:eva_ai/features/studio/studio_catalog.dart';
import 'package:flutter/material.dart';

class EvaPlace {
  const EvaPlace({required this.title, required this.line, required this.keys, required this.open});

  final String title;
  final String line;
  final List<String> keys;
  final VoidCallback open;
}

void openEvaSearch(BuildContext context) {
  final controller = EvaScope.of(context);
  final places = _places(context, controller);
  showEvaSheet(
    context,
    title: 'Find anything',
    body: 'Sleep, period, pregnancy, acne, mood, PCOS, workout, lab. Everything you already have, in one list.',
    child: _SearchList(places: places),
  );
}

class _SearchList extends StatefulWidget {
  const _SearchList({required this.places});

  final List<EvaPlace> places;

  @override
  State<_SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<_SearchList> {
  final _query = TextEditingController();

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = evaOf(context);
    final needle = _query.text.trim().toLowerCase();
    final shown = widget.places.where((place) {
      if (needle.isEmpty) return true;
      final haystack = '${place.title} ${place.line} ${place.keys.join(' ')}'.toLowerCase();
      return haystack.contains(needle);
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _query,
          autofocus: true,
          style: EvaType.ui(16, palette.ink),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: EvaType.ui(16, palette.faint),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 8),
        for (final place in shown)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassPanel(
              onTap: () {
                Navigator.of(context).pop();
                place.open();
              },
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.title, style: EvaType.ui(16, palette.ink, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(place.line, style: EvaType.ui(13, palette.muted)),
                ],
              ),
            ),
          ),
        if (shown.isEmpty)
          Text('Nothing under that word. Try sleep, mood, or lab.', style: EvaType.ui(14, palette.muted)),
      ],
    );
  }
}

List<EvaPlace> _places(BuildContext context, EvaController controller) {
  void section(int index) => controller.requestSection(index);
  void studio(String id) => Navigator.of(context).push(evaRoute(ExperiencePage(id: id)));

  return [
    EvaPlace(title: 'Today', line: 'Where you are, and what matters now.', keys: const ['home', 'brief', 'today'], open: () => section(0)),
    EvaPlace(title: 'Rhythm', line: 'Period, flow, symptoms, and the calendar.', keys: const ['period', 'cycle', 'symptom', 'log', 'cramp'], open: () => section(1)),
    EvaPlace(title: 'Ask EVA', line: 'Educational guidance. Not a clinician.', keys: const ['ask', 'chat', 'question'], open: () => section(2)),
    EvaPlace(title: 'Hormone twin', line: 'The illustrated cycle, not a lab.', keys: const ['hormone', 'twin', 'forecast', 'insight'], open: () => section(3)),
    EvaPlace(title: 'You', line: 'Name, focus, privacy, and this week.', keys: const ['profile', 'settings', 'you'], open: () => section(4)),
    for (final link in studioLinks)
      EvaPlace(
        title: link.title,
        line: link.line,
        keys: _keysFor(link.id),
        open: () => studio(link.id),
      ),
  ];
}

List<String> _keysFor(String id) {
  switch (id) {
    case 'wearables':
      return const ['sleep', 'oura', 'ring', 'recovery'];
    case 'beauty':
      return const ['acne', 'skin', 'face', 'breakout'];
    case 'mental':
      return const ['mood', 'anxiety', 'stress', 'breath'];
    case 'fitness':
      return const ['workout', 'exercise', 'training', 'run'];
    case 'nutrition':
      return const ['food', 'meal', 'eat', 'craving'];
    case 'labs':
      return const ['lab', 'blood', 'ferritin', 'result'];
    case 'fertility':
      return const ['fertile', 'ovulation', 'conceive', 'bbt'];
    case 'pregnancy':
      return const ['pregnant', 'baby', 'kick', 'week'];
    case 'pcos':
      return const ['pcos', 'insulin', 'weight'];
    case 'menopause':
      return const ['hot', 'flash', 'perimenopause'];
    case 'community':
      return const ['community', 'friends', 'group'];
    case 'privacy':
      return const ['privacy', 'delete', 'erase'];
    case 'connect':
      return const ['connect', 'partner', 'circle', 'spouse', 'doula'];
    case 'future':
      return const ['future', 'forecast', 'tomorrow', 'week', 'report', 'memory'];
    case 'shortcuts':
      return const ['shortcut', 'shortcuts', 'usual', 'copy', 'quick', 'lazy'];
    default:
      return const [];
  }
}
