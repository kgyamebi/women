import 'package:eva_ai/domain/health_models.dart';
import 'package:eva_ai/domain/view_models.dart';

PregnancyStory pregnancyStory(DateTime lmp, DateTime today) {
  final days = calendarDaysBetween(lmp, today);
  final safeDays = days < 0 ? 0 : days;
  final week = safeDays ~/ 7;
  final extra = safeDays % 7;
  final due = shiftDays(lmp, 280);

  const chapters = <int, (String, String, String, String)>{
    4: (
      'a poppy seed',
      'A test can turn positive around now.',
      'The usual comparison is a poppy seed. Dating still starts from the last menstrual period, before anything is visible.',
      'A first prenatal visit is often scheduled once a test is positive.',
    ),
    8: (
      'a raspberry',
      'Organs are forming. Tiredness and nausea are common.',
      'Many people feel wiped out. Small meals sometimes sit better than large ones. Tell a clinician about bleeding, severe pain, or fainting.',
      'A dating visit is commonly offered around now.',
    ),
    12: (
      'a lime',
      'The first trimester is ending for many people.',
      'Energy sometimes starts to return. Nausea can linger. Genetic screening is a conversation, not an obligation.',
      'Ask which screening, if any, fits the care you want.',
    ),
    16: (
      'an avocado',
      'Movement may still be too early to feel.',
      'Especially in a first pregnancy, kicks often come later. Body changes can start to show. Pelvic pain that is sudden or one-sided needs a clinician.',
      'This is a good week to write questions down while visits are still spaced out.',
    ),
    20: (
      'a banana',
      'Halfway by the usual count.',
      'Anatomy scans are often scheduled around now. Feeling movement becomes more common, and the pattern matters more than a single hour.',
      'An anatomy scan is commonly offered between 18 and 22 weeks.',
    ),
    24: (
      'an ear of corn',
      'Hearing is developing.',
      'Glucose screening is often discussed in this stretch. Swelling that is sudden, or a headache with vision changes, is a same-day clinical concern.',
      'Ask when glucose screening is planned.',
    ),
    28: (
      'an eggplant',
      'The third trimester, by the common definition.',
      'Kicks are usually a daily pattern by now. If the baby is much quieter than their usual self, call the care team the same day.',
      'Visits often become more regular from here.',
    ),
    32: (
      'a squash',
      'Practice contractions can appear.',
      'Sleep gets more awkward. A contraction timer is a notebook, not a decision. Follow the labor rule your own care team gave you.',
      'Ask what contraction pattern they want you to call about.',
    ),
    36: (
      'a papaya',
      'Lungs are maturing.',
      'Many babies settle head-down. Not all do, and position is a clinical check, not something to force.',
      'Visits are often weekly. Confirm the plan for labor.',
    ),
    40: (
      'a watermelon',
      'A due date is an estimate.',
      'Going past it is common. Induction, monitoring, and waiting are decisions for you and your care team, not for an app.',
      'Confirm who to call overnight.',
    ),
  };

  if (week < 4) {
    return PregnancyStory(
      week: week,
      extraDays: extra,
      due: due,
      size: 'too early to compare',
      headline: 'Clinical dating has started from the last menstrual period.',
      body: 'A pregnancy may not be visible or even detectable yet. EVA will not invent a fetal photo or a promise.',
      visit: 'If you have a positive test, bleeding, or pain, contact a clinician rather than waiting for a weekly update.',
    );
  }
  if (week > 42) {
    return PregnancyStory(
      week: week,
      extraDays: extra,
      due: due,
      size: 'a care-team question',
      headline: 'This is past the usual dating window.',
      body: 'Dates this far along belong in a conversation with your care team. EVA will not guess what should happen next.',
      visit: 'Call the clinician following this pregnancy.',
    );
  }

  var key = 4;
  for (final candidate in chapters.keys) {
    if (candidate <= week) key = candidate;
  }
  final chapter = chapters[key]!;
  return PregnancyStory(
    week: week,
    extraDays: extra,
    due: due,
    size: chapter.$1,
    headline: chapter.$2,
    body: chapter.$3,
    visit: chapter.$4,
  );
}

NutritionPlan nutritionFor(HealthProfile profile, CycleSnapshot cycle, PregnancyStory? pregnancy) {
  if (profile.pregnant && pregnancy != null) {
    final early = pregnancy.week < 14;
    return NutritionPlan(
      title: early ? 'Small, steady plates' : 'Protein, iron, and color',
      why: 'Needs rise in pregnancy. EVA suggests foods, and your clinician chooses supplements.',
      plates: [
        Plate(
          meal: 'Breakfast',
          detail: early
              ? 'Toast or oats with yogurt, fruit, and a few nuts if they sit well.'
              : 'Eggs or tofu, fruit, and something with vitamin C.',
        ),
        const Plate(
          meal: 'Lunch',
          detail: 'Lentils, beans, or fish that your clinician has cleared, with greens and rice or bread.',
        ),
        const Plate(
          meal: 'Dinner',
          detail: 'A palm of protein, a colorful vegetable, and a starch you actually like.',
        ),
      ],
      focuses: const [
        NutrientFocus(
          name: 'Folate',
          detail: 'Leafy greens, lentils, and beans. Many public-health bodies suggest folic acid before and early in pregnancy. Confirm the supplement with a clinician.',
        ),
        NutrientFocus(
          name: 'Iron',
          detail: 'Beans, lentils, meat, and fortified grains. Pair them with fruit. Do not start high-dose iron unless a clinician asks you to.',
        ),
        NutrientFocus(
          name: 'Protein',
          detail: 'Include a protein food at each meal so energy lasts longer than the plate.',
        ),
      ],
    );
  }

  switch (cycle.phase) {
    case CyclePhase.menstrual:
      return const NutritionPlan(
        title: 'Warm, iron-aware meals',
        why: 'Bleeding uses iron. This is a food pattern, not a supplement order.',
        plates: [
          Plate(meal: 'Breakfast', detail: 'Oats with pumpkin seeds, berries, and yogurt or soy milk.'),
          Plate(meal: 'Lunch', detail: 'Lentil soup or a beef and greens bowl, plus fruit.'),
          Plate(meal: 'Dinner', detail: 'Salmon or chickpeas, roasted vegetables, and rice.'),
        ],
        focuses: [
          NutrientFocus(name: 'Iron', detail: 'Lentils, red meat, tofu, and fortified grains. Add citrus or peppers.'),
          NutrientFocus(name: 'Magnesium', detail: 'Pumpkin seeds, dark chocolate, beans, and leafy greens.'),
          NutrientFocus(name: 'Protein', detail: 'A clear protein source at each meal helps iron-rich food actually become a meal.'),
        ],
      );
    case CyclePhase.lateFollicular:
    case CyclePhase.ovulatory:
      return const NutritionPlan(
        title: 'Higher protein, steady hydration',
        why: 'Modeled energy is higher. Use it for training and for meals that last, not for restriction.',
        plates: [
          Plate(meal: 'Breakfast', detail: 'Greek yogurt or tofu scramble, fruit, and oats.'),
          Plate(meal: 'Lunch', detail: 'Chicken, tempeh, or tuna with a whole grain and a large salad.'),
          Plate(meal: 'Dinner', detail: 'Fish or beans, potatoes, and a vegetable you cook until sweet.'),
        ],
        focuses: [
          NutrientFocus(name: 'Protein', detail: 'Eggs, dairy or soy, fish, beans, or meat at each meal.'),
          NutrientFocus(name: 'Iron', detail: 'Keep iron foods in the week even when bleeding has stopped.'),
          NutrientFocus(name: 'Magnesium', detail: 'Seeds, beans, and cocoa. Useful around training days.'),
        ],
      );
    case CyclePhase.earlyFollicular:
      return const NutritionPlan(
        title: 'Rebuild, gently',
        why: 'The bleed is ending or just over. Appetite can be uneven. Consistency beats a perfect menu.',
        plates: [
          Plate(meal: 'Breakfast', detail: 'Eggs or yogurt, toast, and fruit.'),
          Plate(meal: 'Lunch', detail: 'A grain bowl with beans and something green.'),
          Plate(meal: 'Dinner', detail: 'Soup with protein, bread, and olive oil.'),
        ],
        focuses: [
          NutrientFocus(name: 'Iron', detail: 'Replace what bleeding used. Food first.'),
          NutrientFocus(name: 'Protein', detail: 'Include it even in smaller breakfasts.'),
          NutrientFocus(name: 'Magnesium', detail: 'Nuts, seeds, and greens.'),
        ],
      );
    case CyclePhase.earlyLuteal:
    case CyclePhase.lateLuteal:
      return const NutritionPlan(
        title: 'Satisfying plates, stable energy',
        why: 'Appetite often rises before a period. Feed it with meals, not a rule about cravings being a failure.',
        plates: [
          Plate(meal: 'Breakfast', detail: 'Oats, peanut butter, and a piece of fruit.'),
          Plate(meal: 'Lunch', detail: 'Rice, beans or chicken, avocado, and salsa.'),
          Plate(meal: 'Dinner', detail: 'Pasta or potatoes with a clear protein and vegetables.'),
        ],
        focuses: [
          NutrientFocus(name: 'Magnesium', detail: 'People often want chocolate here. Cocoa, seeds, and beans fit the craving and the mineral.'),
          NutrientFocus(name: 'Protein', detail: 'Add protein so a sweet snack is not the whole meal.'),
          NutrientFocus(name: 'Iron', detail: 'Stock iron foods before bleeding starts again.'),
        ],
      );
  }
}

TrainingPlan trainingFor(HealthProfile profile, CycleSnapshot cycle, Daypart part) {
  if (part == Daypart.night) {
    return const TrainingPlan(
      title: 'Leave the session for morning',
      why: 'It is the middle of the night. The intelligent workout is sleep.',
      blocks: [
        'Dim the lights and put the phone down.',
        'Unclench the jaw. Slow the exhale.',
        'If you are wired, stretch hips and calves for four quiet minutes.',
      ],
      caution: 'Skip intensity until you have slept.',
    );
  }
  if (profile.pregnant) {
    return const TrainingPlan(
      title: 'A walk, if it feels good',
      why: 'Pregnancy training should follow how you feel and what your clinician has cleared.',
      blocks: [
        'Ten to twenty minutes of easy walking.',
        'A few slow squats or pelvic tilts only if they feel ordinary.',
        'Stop for pain, bleeding, dizziness, or contractions.',
      ],
      caution: 'Do not start a new intense program from an app during pregnancy.',
    );
  }

  switch (cycle.phase) {
    case CyclePhase.lateFollicular:
    case CyclePhase.ovulatory:
      return const TrainingPlan(
        title: 'Strength, full range',
        why: 'This is the modeled high-energy window. Lift, then stop while the last reps are still clean.',
        blocks: [
          'Five minutes of easy walking or cycling.',
          'Squat or sit-to-stand, hinge or hip bridge, and a push — three rounds.',
          'A short carry or a brisk walk to finish.',
        ],
        caution: 'Pain that is sharp, or dizziness, ends the session. Soreness can wait until tomorrow.',
      );
    case CyclePhase.menstrual:
      return const TrainingPlan(
        title: 'Mobility and a walk',
        why: 'Bleeding day effort should be optional. A walk counts.',
        blocks: [
          'Fifteen minute walk, or ten if that is the honest number.',
          'Open the hips and upper back with slow breathing.',
          'Skip anything that makes cramps louder.',
        ],
        caution: 'Heavy bleeding with faintness is a reason to rest and contact a clinician, not to train.',
      );
    case CyclePhase.earlyFollicular:
      return const TrainingPlan(
        title: 'Return to strength',
        why: 'Energy is often rebuilding. Keep the loads familiar.',
        blocks: [
          'Warm up until the joints feel awake.',
          'Two or three strength patterns you already know.',
          'Finish before form frays.',
        ],
        caution: 'Add load next week if this week feels boring, not heroic.',
      );
    case CyclePhase.earlyLuteal:
    case CyclePhase.lateLuteal:
      return const TrainingPlan(
        title: 'Steady strength, lower intensity',
        why: 'Keep the habit. Drop the all-out intervals if sleep or mood is frayed.',
        blocks: [
          'The same strength patterns as last week, with a rep in reserve.',
          'Nasal breathing on the easy minutes.',
          'A slow walk if the gym feels like too much.',
        ],
        caution: 'This is not a punishment phase. Consistency is the result.',
      );
  }
}

SkinForecast skinFor(CycleSnapshot cycle) {
  final window = prettyDay(cycle.pmsStart);
  switch (cycle.phase) {
    case CyclePhase.lateFollicular:
    case CyclePhase.ovulatory:
      return SkinForecast(
        today: 'Skin is often calmer in this window. It is a reasonable day to keep the routine you already tolerate.',
        ahead: 'Breakouts, if they visit you, more often cluster near $window, in the late luteal days.',
        routine: const [
          'A gentle cleanser, not a scrub.',
          'Moisturizer on slightly damp skin.',
          'Sunscreen in the morning.',
          'Do not add a new active just because energy is high.',
        ],
      );
    case CyclePhase.lateLuteal:
    case CyclePhase.menstrual:
      return const SkinForecast(
        today: 'This is the window when hormonal spots often show. Treat the skin as reactive, not as a project.',
        ahead: 'The next calmer stretch is usually after bleeding eases.',
        routine: [
          'Keep the cleanser gentle.',
          'Pause new acids and retinoids if the skin stings.',
          'A plain moisturizer and sunscreen are enough.',
          'Picking makes the mark last longer than the cycle does.',
        ],
      );
    case CyclePhase.earlyFollicular:
    case CyclePhase.earlyLuteal:
      return SkinForecast(
        today: 'Skin is in between. Change one thing at a time if you change anything.',
        ahead: 'Watch the days around $window if spots tend to announce a period.',
        routine: const [
          'Cleanse, moisturize, protect.',
          'Introduce one active on a quiet week, never five.',
          'Take a photo only if you want a private record. This build does not upload selfies.',
        ],
      );
  }
}
