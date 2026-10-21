class StudioLink {
  const StudioLink({
    required this.id,
    required this.eyebrow,
    required this.title,
    required this.line,
  });

  final String id;
  final String eyebrow;
  final String title;
  final String line;
}

List<StudioLink> orderedStudio(String focus, {bool wearableSample = false}) {
  final preferred = switch (focus) {
    'pregnancy' => 'pregnancy',
    'fertility' => 'fertility',
    'pcos' => 'pcos',
    'menopause' => 'menopause',
    'mental' => 'mental',
    'beauty' => 'beauty',
    'fitness' => 'fitness',
    'nutrition' => 'nutrition',
    'perimenopause' => 'menopause',
    'postpartum' || 'teen' || 'college' => 'mental',
    'work' => 'fitness',
    _ => wearableSample ? 'wearables' : null,
  };
  final links = [...studioLinks];
  if (preferred == null) return links;
  final index = links.indexWhere((link) => link.id == preferred);
  if (index > 0) links.insert(0, links.removeAt(index));
  return links;
}

const studioLinks = <StudioLink>[
  StudioLink(id: 'future', eyebrow: 'Ahead', title: 'Future', line: 'The next 7 days, from the calendar and your own notes.'),
  StudioLink(id: 'connect', eyebrow: 'Circle', title: 'Connect', line: 'The people you choose. Nothing is shared until you grant it.'),
  StudioLink(id: 'pregnancy', eyebrow: 'Life mode', title: 'Pregnancy', line: 'The day reshapes around a confirmed pregnancy.'),
  StudioLink(id: 'fertility', eyebrow: 'Life mode', title: 'Fertility', line: 'A calendar window, with the uncertainty left visible.'),
  StudioLink(id: 'pcos', eyebrow: 'Life mode', title: 'PCOS', line: 'Symptoms first. Perfect cycles are not required.'),
  StudioLink(id: 'menopause', eyebrow: 'Life mode', title: 'Menopause', line: 'Heat, sleep, and mood take the foreground.'),
  StudioLink(id: 'mental', eyebrow: 'Life mode', title: 'Mind', line: 'Mood beside the cycle, never a diagnosis.'),
  StudioLink(id: 'nutrition', eyebrow: 'Copilot', title: 'Nutrition', line: 'Plates that change with the phase.'),
  StudioLink(id: 'fitness', eyebrow: 'Copilot', title: 'Fitness', line: 'Training that knows when to be quiet.'),
  StudioLink(id: 'beauty', eyebrow: 'Copilot', title: 'Skin', line: 'A breakout forecast without uploading a face.'),
  StudioLink(id: 'labs', eyebrow: 'Care', title: 'Labs', line: 'Plain language for results. The verdict stays with a clinician.'),
  StudioLink(id: 'community', eyebrow: 'Care', title: 'Community', line: 'Anonymous rooms. Peers, not doctors.'),
  StudioLink(id: 'wearables', eyebrow: 'Care', title: 'Wearables', line: 'Sleep and recovery, when you choose to connect them.'),
  StudioLink(id: 'privacy', eyebrow: 'Care', title: 'Privacy', line: 'What stays on this device, and how to erase it.'),
  StudioLink(id: 'shortcuts', eyebrow: 'Less typing', title: 'Shortcuts', line: 'Reuse a day you already logged. Nothing is guessed.'),
];
