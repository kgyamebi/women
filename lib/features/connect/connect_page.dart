import 'package:eva_ai/app/eva_controller.dart';
import 'package:eva_ai/core/theme/eva_theme.dart';
import 'package:eva_ai/core/widgets/eva_widgets.dart';
import 'package:eva_ai/domain/domain.dart';
import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final _name = TextEditingController();
  final _ask = TextEditingController();
  String _role = 'partner';
  String? _selected;
  String _answer = '';

  @override
  void dispose() {
    _name.dispose();
    _ask.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final profile = controller.profile;
    final palette = evaOf(context);
    final people = profile.circle;
    final selected = people.where((person) => person.id == _selected).cast<CirclePerson?>().firstWhere(
          (person) => person != null,
          orElse: () => people.isEmpty ? null : people.first,
        );
    final view = selected == null ? null : partnerView(profile, selected, controller.now());
    final twin = selected == null ? null : relationshipTwin(selected);

    return StudioScaffold(
      eyebrow: 'EVA Connect',
      title: 'Because health journeys are rarely traveled alone.',
      lede: 'You choose who participates. Nothing is shared until you grant it, and you can take it back in one tap.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This circle stays on your profile. EVA does not message another phone or a clinic from here.',
            style: EvaType.ui(14, palette.muted),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _name,
            style: EvaType.ui(16, palette.ink),
            decoration: const InputDecoration(hintText: 'Their name'),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final role in circleRoles)
                WordChip(
                  label: role.$2,
                  selected: _role == role.$1,
                  onTap: () => setState(() => _role = role.$1),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SoftButton(
            label: 'Add to the circle',
            primary: true,
            onPressed: () {
              controller.addCircle(_name.text, _role);
              _name.clear();
              final circle = controller.profile.circle;
              setState(() => _selected = circle.isEmpty ? _selected : circle.last.id);
            },
          ),
          const SizedBox(height: 18),
          if (people.isEmpty)
            Text('Your circle is empty. Until you add someone, there is nothing to see.', style: EvaType.ui(15, palette.ink))
          else ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final person in people)
                  WordChip(
                    label: person.name,
                    selected: person.id == (selected?.id),
                    onTap: () => setState(() {
                      _selected = person.id;
                      _answer = '';
                    }),
                  ),
              ],
            ),
            if (selected != null && view != null && twin != null) ...[
              const SizedBox(height: 16),
              _PersonView(
                person: selected,
                view: view,
                twin: twin,
                ask: _ask,
                answer: _answer,
                onAsk: () => setState(() {
                  _answer = partnerReply(
                    profile: profile,
                    person: selected,
                    now: controller.now(),
                    question: _ask.text,
                  );
                }),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _PersonView extends StatelessWidget {
  const _PersonView({
    required this.person,
    required this.view,
    required this.twin,
    required this.ask,
    required this.answer,
    required this.onAsk,
  });

  final CirclePerson person;
  final PartnerView view;
  final RelationshipTwin twin;
  final TextEditingController ask;
  final String answer;
  final VoidCallback onAsk;

  @override
  Widget build(BuildContext context) {
    final controller = EvaScope.of(context);
    final palette = evaOf(context);
    final today = isoDay(controller.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${person.name} · ${circleRoleLabel(person.role)}', style: EvaType.display(28, palette.ink)),
        const SizedBox(height: 8),
        Text(view.overview, style: EvaType.ui(16, palette.ink, weight: FontWeight.w500)),
        const SizedBox(height: 14),
        Text('What they may understand', style: EvaType.ui(13, palette.faint)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in connectPermissions)
              WordChip(
                label: item.$2,
                selected: person.allows(item.$1),
                onTap: () => controller.toggleCirclePermission(person.id, item.$1),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SoftButton(label: 'Remove ${person.name}', onPressed: () => controller.removeCircle(person.id)),
        const SizedBox(height: 16),
        GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Their view', style: EvaType.ui(13, palette.faint)),
              const SizedBox(height: 8),
              Text(view.brief, style: EvaType.ui(16, palette.ink, weight: FontWeight.w500)),
              for (final line in view.lines) ...[
                const SizedBox(height: 8),
                Text(line, style: EvaType.ui(15, palette.ink)),
              ],
              if (view.lines.isEmpty) ...[
                const SizedBox(height: 8),
                Text('No health detail is visible.', style: EvaType.ui(15, palette.muted)),
              ],
            ],
          ),
        ),
        if (view.crisis) ...[
          const SizedBox(height: 12),
          GlassPanel(
            child: Text(
              'If this is an emergency, contact local emergency services. In the US or Canada, call or text 988. Stay with them. Do not treat this screen as a diagnosis.',
              style: EvaType.ui(15, palette.ink, weight: FontWeight.w500),
            ),
          ),
        ],
        if (view.support.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Ways to help', style: EvaType.ui(13, palette.faint)),
          for (final line in view.support)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(line, style: EvaType.ui(15, palette.ink)),
            ),
        ],
        const SizedBox(height: 12),
        for (final line in view.understand)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(line, style: EvaType.ui(15, palette.muted)),
          ),
        for (final line in view.journey)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(line, style: EvaType.ui(15, palette.ink)),
          ),
        if (view.missions.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Care missions', style: EvaType.ui(13, palette.faint)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final mission in view.missions)
                WordChip(
                  label: mission,
                  selected: person.missionDays.contains('$today|$mission'),
                  onTap: () => controller.completeMission(person.id, mission),
                ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        Text('One tap', style: EvaType.ui(13, palette.faint)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            WordChip(label: "I'm here", selected: false, onTap: () => controller.circleCheckIn(person.id)),
            WordChip(label: 'Want company?', selected: false, onTap: () => controller.circleCheckIn(person.id)),
            WordChip(label: 'I can take a task', selected: false, onTap: () => controller.circleCheckIn(person.id)),
          ],
        ),
        const SizedBox(height: 16),
        Text('Shared goals', style: EvaType.ui(13, palette.faint)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final goal in const ['Sleep', 'Steps', 'Hydration', 'Nutrition', 'Meditation', 'Workout', 'Fertility', 'Pregnancy'])
              WordChip(
                label: goal,
                selected: person.goals.contains(goal),
                onTap: () => controller.addCircleGoal(person.id, goal),
              ),
          ],
        ),
        if (person.role == 'pregnancyPartner' || person.role == 'ttc') ...[
          const SizedBox(height: 16),
          Text(person.role == 'ttc' ? 'Conception planning' : 'Parenthood preparation', style: EvaType.ui(13, palette.faint)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in person.role == 'ttc'
                  ? const ['Questions for the doctor', 'Appointment day', 'Shared note']
                  : const ['Financial plan', 'Sleep plan', 'Hospital bag', 'Feeding questions', 'Who to call'])
                WordChip(
                  label: item,
                  selected: person.memories.any((memory) => memory.title == item),
                  onTap: () => controller.addCircleMemory(person.id, item),
                ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        Text('Emotional timeline', style: EvaType.ui(13, palette.faint)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in const ['First kick', 'Positive test', 'Health milestone', 'Goal kept', 'Recovery'])
              WordChip(
                label: item,
                selected: person.memories.any((memory) => memory.title == item),
                onTap: () => controller.addCircleMemory(person.id, item),
              ),
          ],
        ),
        for (final memory in person.memories)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('${prettyDay(tryParseDay(memory.day) ?? controller.now())} · ${memory.title}', style: EvaType.ui(14, palette.ink)),
          ),
        const SizedBox(height: 16),
        Text('Relationship twin', style: EvaType.ui(13, palette.faint)),
        const SizedBox(height: 8),
        Text(twin.showingUp, style: EvaType.ui(15, palette.ink)),
        const SizedBox(height: 4),
        Text(twin.support, style: EvaType.ui(15, palette.ink)),
        const SizedBox(height: 4),
        Text(twin.together, style: EvaType.ui(15, palette.ink)),
        const SizedBox(height: 4),
        Text(twin.insight, style: EvaType.ui(15, palette.muted)),
        const SizedBox(height: 16),
        TextField(
          controller: ask,
          style: EvaType.ui(16, palette.ink),
          decoration: const InputDecoration(hintText: 'Ask: how can I support her today?'),
          onSubmitted: (_) => onAsk(),
        ),
        const SizedBox(height: 8),
        SoftButton(label: 'Ask their guide', primary: true, onPressed: onAsk),
        if (answer.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(answer, style: EvaType.ui(15, palette.ink)),
        ],
      ],
    );
  }
}
