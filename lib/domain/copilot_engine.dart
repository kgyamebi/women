import 'package:eva_ai/domain/cycle_engine.dart';
import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

String copilotReply({
  required HealthProfile profile,
  required DailyBrief brief,
  required String question,
}) {
  final q = question.toLowerCase().trim();
  if (q.isEmpty) {
    return 'Ask me in a sentence. I will answer from the rhythm we are using, and I will say when I am guessing.';
  }
  final safety = safetyNotice(q);
  if (safety.isNotEmpty) return safety;
  if (profile.pregnant && _has(q, ['headache', 'vision', 'swelling', 'baby quiet', 'no movement', 'bleeding'])) {
    return 'In pregnancy, a headache with vision changes, sudden swelling, heavy bleeding, or a baby who is much quieter than usual belongs with your care team today. I can help you list what you felt. I cannot decide if it is safe to wait.';
  }

  final known = _knownPattern(profile, brief);
  String personal(String body) => known.isEmpty ? body : '$known\n\n$body';

  final name = profile.name.trim().isEmpty ? 'there' : profile.name.trim();
  final phase = phaseLabel(brief.cycle.phase).toLowerCase();
  final window = prettyDay(brief.cycle.pmsStart);

  if (_has(q, ['headache', 'migraine'])) {
    final where = profile.timingConfirmed ? ' The saved date puts the estimate in the $phase. That is not a measurement.' : ' No period date is saved, so this is not placed on your cycle.';
    return personal('Headaches are sometimes discussed alongside the late luteal part of a textbook cycle. That is education, not a finding about you.$where\n\nIf a headache is sudden and the worst you have felt, or it comes with vision changes, weakness, confusion, or a stiff neck, contact urgent care. In pregnancy, a headache with visual change is a same-day clinical call.\n\nI will not diagnose you.');
  }
  if (_has(q, ['pcos', 'weight gain', 'weight'])) {
    return 'PCOS can make weight easier to gain for some people, often through insulin resistance, androgens, sleep, and appetite. It does not happen to everyone with PCOS, and weight gain has many other causes. Reading about it does not mean you have PCOS.\n\nWhat helps a clinical visit is a plain record: cycle spacing, skin, hair growth, and how you feel after meals. Strength training, protein at meals, and a steady bedtime are reasonable supports. They are not a treatment plan.\n\nA clinician can look at androgens and metabolic labs if that fits your story. I will not start you on a medication or a crash diet.';
  }
  if (_has(q, ['ferritin', 'iron'])) {
    return 'Ferritin is a storage form of iron. Heavy periods can draw it down, and low stores can show up as fatigue or hair shedding, though those symptoms are not specific.\n\nThe number only means something next to the reference range printed on your report, and next to why the test was ordered. I would not start high-dose iron from a chat. Food sources are lentils, beans, meat, and fortified grains, with fruit alongside.\n\nBring the report. Ask what range they use and whether a repeat test is needed. This is not a diagnosis.';
  }
  if (_has(q, ['tsh', 'thyroid'])) {
    return 'TSH is a signal from the pituitary to the thyroid. A high or low result can mean the thyroid is under-active or over-active, but the cutoff is the range on your lab sheet, read with symptoms and sometimes with free T4.\n\nI cannot tell you that you have a thyroid condition from a question. If thyroid is already part of your context, keep the doses and follow-up with the clinician who prescribed them.';
  }
  if (_has(q, ['estradiol', 'estrogen test', 'e2'])) {
    return 'Estradiol swings across a cycle. A single number without the cycle day is easy to misread. In the model I am using, estrogen is higher in the late follicular days and dips before bleeding.\n\nYour result has to be read against the day it was drawn and the range for that timing. I can explain the shape. I cannot replace the lab or the person who ordered it.';
  }
  if (_has(q, ['progesterone'])) {
    return 'Progesterone stays low until after ovulation, then rises for about a week. A blood test is sometimes used to ask whether ovulation happened, and the timing of the draw matters more than a single "good" number.\n\nA calendar cannot prove that rise. If you are timing bloodwork, ask the clinician which day they want. I will not call a result normal or abnormal from here.';
  }
  if (_has(q, ['amh', 'ovarian reserve'])) {
    return 'AMH is one signal about the egg supply, not a fertility score and not a countdown. It does not tell you whether you can conceive this month, and it does not diagnose menopause by itself.\n\nThe useful conversation is AMH plus age, cycle history, and what you are hoping for. Bring the number and the range. Leave the meaning with a fertility clinician.';
  }
  if (_has(q, ['blood test', 'lab', 'results', 'hormone test'])) {
    return 'A lab is a snapshot with a range, a date, and a reason. The words on the report are written for clinicians, so EVA translates the name and leaves the verdict alone.\n\nTell me the marker — ferritin, TSH, estradiol, progesterone, AMH — and the cycle day if you know it. I will explain what the test is trying to see. I will not tell you that you are normal, sick, fertile, or infertile.';
  }
  if (_has(q, ['discharge', 'mucus', 'cervical'])) {
    return 'Discharge changes across a cycle. Clear and stretchy fluid often shows up near the fertile window. White or creamy fluid is common. Brown at the edges of a period is often older blood.\n\nColor alone cannot diagnose an infection. Yellow-green or gray discharge, a strong odor, itching, burning, or pelvic pain are reasons to see a clinician. I can help you describe it. I will not name an infection from a sentence.';
  }
  if (_has(q, ['pregnant', 'pregnancy', 'week'])) {
    if (profile.pregnant && brief.pregnancy != null) {
      final story = brief.pregnancy!;
      return 'By the last menstrual period I have, this is week ${story.week}, day ${story.extraDays}. ${story.headline} ${story.body}\n\nThe due estimate is ${prettyDay(story.due)}, and it is an estimate. ${story.visit}';
    }
    return 'If you are pregnant, tell me the first day of the last menstrual period and I will reshape the day around that count. I will not confirm a pregnancy from symptoms. A test and a clinician do that.';
  }
  if (_has(q, ['hot flash', 'menopause', 'perimenopause'])) {
    return 'Hot flashes, broken sleep, and mood shifts are common in the menopause transition, and they are also non-specific. Logging the hour, the intensity, and the night of sleep makes a better visit than a vague "I feel off."\n\nSome people discuss hormone therapy with a clinician. Whether it is appropriate depends on your history, not on an app. I can track the pattern. I will not start or stop a hormone.';
  }
  if (_has(q, ['anxiety', 'depressed', 'depression', 'mood', 'stress'])) {
    return 'Mood and the cycle talk to each other, especially when sleep is short or the late luteal drop lands. You are in the $phase in the model I am using. That can color a day. It does not define you.\n\nI will not score you on a depression scale or tell you that you have a disorder. If mood is heavy for more than a short stretch, a clinician is the right next person. If you might hurt yourself, call emergency services. In the US or Canada, call or text 988.';
  }
  if (_has(q, ['sleep', 'insomnia', 'tired'])) {
    return 'Sleep is the quiet driver under mood, cravings, and training. In this phase the modeled sleep impact is ${sleepImpact(brief.cycle.phase).toLowerCase()}. A high impact means the phase often makes sleep lighter, not that you failed at bedtime.\n\nAn earlier wind-down beats a new supplement. If snoring, gasping, or unrefreshing sleep is the real story, mention it at a visit. I will not prescribe a sleep drug.';
  }
  if (_has(q, ['workout', 'exercise', 'training', 'run', 'lift'])) {
    return 'Training should follow the phase, the night of sleep, and how the first minutes feel. Late follicular days are often the stronger window. Menstrual and late luteal days are better for familiar work than for a test of toughness.\n\nStop for sharp pain, dizziness, or bleeding that feels wrong. I can point at a session. I cannot clear you for exercise the way a clinician can.';
  }
  if (_has(q, ['eat', 'food', 'craving', 'nutrition', 'hungry', 'protein'])) {
    return 'Appetite is data. In the late luteal days it often rises, and feeding it with a real meal works better than arguing with it. Today the suggestion is built around ${brief.recommendations.length >= 2 ? brief.recommendations[1].toLowerCase() : 'a steady plate'}.\n\nI will talk about iron, magnesium, and protein as foods. I will not give you a calorie target or a supplement dose.';
  }
  if (_has(q, ['acne', 'skin', 'breakout', 'pimple'])) {
    return 'Skin often reacts in the late luteal window, around $window in this model, when the hormone sketch shifts. A calm day is a day to keep the routine you tolerate, not to add five new products.\n\nCystic, painful, or scarring acne is worth a clinician, sometimes a dermatologist. I will not prescribe a retinoid or an antibiotic from here.';
  }
  if (_has(q, ['endometriosis', 'endo'])) {
    return 'Endometriosis pain is real, and a normal ultrasound does not always rule it out. What helps a visit is timing: which days hurt, what the pain stops you from doing, and what you have already tried.\n\nI cannot diagnose endometriosis. A clinician decides whether the story fits and what to do next.';
  }
  if (_has(q, ['ovulat', 'fertile', 'conceive', 'bbt', 'basal'])) {
    return 'The fertile window is a calendar estimate: about five days before an estimated ovulation day, through that day. It is not a probability, not contraception, and not a promise that you will or will not conceive.\n\nA temperature shift or an ovulation test belongs with a clinician\'s interpretation. Cervical fluid can line up with the window, and it can also be ambiguous.';
  }
  if (_has(q, ['clinician', 'doctor', 'what should i ask'])) {
    final placed = profile.timingConfirmed
        ? 'A useful question is: "Given the ${brief.cycle.length}-day rhythm I saved, what would you want to check, and what can wait?"'
        : 'No period date is saved. Ask what they would check from the symptoms you can describe.';
    return 'Bring three things, not your whole phone. The dates that mattered, the symptom in one sentence, and the question you actually want answered.\n\n$placed Then let them lead. I will not script a diagnosis.';
  }

  final place = profile.timingConfirmed
      ? 'The saved date estimates the $phase, day ${brief.cycle.day} of ${brief.cycle.length}. ${brief.headline}'
      : 'No period date is saved, so this reply will not name a cycle day.';
  return personal('Educational guidance, $name. $place\n\nI can talk through headaches, labs, discharge, fertility, pregnancy, PCOS, menopause, mood, skin, food, or training. I explain patterns in plain language. I do not diagnose, and I will not pretend a calendar is a blood test.\n\nWhat part do you want to understand?');
}

enum SafetyKind { none, suicide, abuse, assault, eating, pregnancyEmergency, medical }

SafetyKind safetyKind(String text) {
  if (_has(text, const [
    'suicide',
    'suicidal',
    'selfharm',
    'unalive',
    'kill myself',
    'want to die',
    'end my life',
    'self-harm',
    'self harm',
    'hurt myself',
    'better off dead',
    'ending it all',
    'dont want to be alive',
    "don't want to be alive",
  ])) {
    return SafetyKind.suicide;
  }
  if (_has(text, const [
    'hit me',
    'beats me',
    'choked me',
    'afraid of my partner',
    'afraid to go home',
    'domestic abuse',
    'he hits me',
    'she hits me',
    'wont let me leave',
    "won't let me leave",
  ])) {
    return SafetyKind.abuse;
  }
  if (_has(text, const ['raped', 'rape', 'sexual assault', 'was assaulted', 'molested'])) {
    return SafetyKind.assault;
  }
  if (_has(text, const [
    'purging',
    'make myself throw up',
    'made myself throw up',
    'havent eaten in',
    "haven't eaten in",
    'starving myself',
    'making myself sick',
  ])) {
    return SafetyKind.eating;
  }
  if (_has(text, const [
    'soaking a pad',
    'no fetal movement',
    "baby isn't moving",
    'baby is not moving',
    'severe belly pain',
  ])) {
    return SafetyKind.pregnancyEmergency;
  }
  if (_has(text, const [
    'chest pain',
    "can't breathe",
    'cannot breathe',
    'cant breathe',
    'passed out',
    'fainted',
    'fainting',
    'vision loss',
    'worst headache',
    'soaking through',
  ])) {
    return SafetyKind.medical;
  }
  return SafetyKind.none;
}

bool looksLikeCrisis(String text) => safetyKind(text) != SafetyKind.none;

String safetyNotice(String text) {
  const common = ' This is not a diagnosis and not treatment. An app is not the emergency service.';
  return switch (safetyKind(text)) {
    SafetyKind.none => '',
    SafetyKind.suicide =>
      'If you might act on thoughts of suicide or self-harm, call local emergency services now. In the US or Canada, call or text 988.$common',
    SafetyKind.abuse =>
      'If you are in danger now, call local emergency services. In the US, the National Domestic Violence Hotline is 1-800-799-7233. Outside the US, use a local domestic-violence service.$common',
    SafetyKind.assault =>
      'If you are in danger now, call local emergency services. In the US, RAINN is 1-800-656-4673. Outside the US, use a local sexual-assault service.$common',
    SafetyKind.eating =>
      'A clinician is the right person for eating concerns. In the US, the National Eating Disorders Association helpline is 1-800-931-2237. If you have fainted or cannot keep fluids down, call local emergency services.$common',
    SafetyKind.pregnancyEmergency =>
      'Heavy bleeding, severe pain, or a baby who has stopped moving needs local emergency services or a same-day clinician. Do not wait for an app.$common',
    SafetyKind.medical =>
      'Chest pain, trouble breathing, or passing out needs local emergency services now.$common',
  };
}

String _knownPattern(HealthProfile profile, DailyBrief brief) {
  if (!profile.timingConfirmed) return '';
  final counts = <String, int>{};
  for (final log in profile.logs) {
    final day = tryParseDay(log.day);
    if (day == null || projectCycle(profile, day).phase != brief.cycle.phase) continue;
    for (final symptom in log.symptoms) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  if (counts.isEmpty) return '';
  final top = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  if (top.first.value < 2) return '';
  return 'From your own notes, ${top.first.key} has come up ${top.first.value} times in this phase.';
}

bool _has(String question, List<String> keys) {
  final lower = question.toLowerCase();
  final words = lower
      .replaceAll(RegExp("[^a-z0-9\\s']"), ' ')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toSet();
  for (final key in keys) {
    final token = key.toLowerCase();
    if (token.contains(' ') || token.contains('-')) {
      if (lower.contains(token)) return true;
      continue;
    }
    if (words.contains(token)) return true;
  }
  return false;
}
