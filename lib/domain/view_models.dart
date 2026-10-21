enum CyclePhase {
  menstrual,
  earlyFollicular,
  lateFollicular,
  ovulatory,
  earlyLuteal,
  lateLuteal,
}

enum Daypart { night, morning, afternoon, evening }

class CycleSnapshot {
  const CycleSnapshot({
    required this.day,
    required this.length,
    required this.phase,
    required this.nextPeriod,
    required this.ovulation,
    required this.fertileStart,
    required this.fertileEnd,
    required this.pmsStart,
    required this.confidence,
    required this.ovulationConfidence,
    required this.fertilityToday,
  });

  final int day;
  final int length;
  final CyclePhase phase;
  final DateTime nextPeriod;
  final DateTime ovulation;
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final DateTime pmsStart;
  final double confidence;
  final double ovulationConfidence;
  final double fertilityToday;
}

class HormonePoint {
  const HormonePoint({
    required this.estrogen,
    required this.progesterone,
    required this.testosterone,
    required this.cortisol,
  });

  final double estrogen;
  final double progesterone;
  final double testosterone;
  final double cortisol;
}

class Signal {
  const Signal({
    required this.label,
    required this.value,
    required this.caption,
    required this.detail,
  });

  final String label;
  final String value;
  final String caption;
  final String detail;
}

class Whisper {
  const Whisper({required this.id, required this.message});

  final String id;
  final String message;
}

class HealthNote {
  const HealthNote({required this.title, required this.body, this.urgent = false});

  final String title;
  final String body;
  final bool urgent;
}

class WearableNight {
  const WearableNight({
    required this.sleep,
    required this.hrv,
    required this.restingHeart,
    required this.temperature,
  });

  final String sleep;
  final String hrv;
  final String restingHeart;
  final String temperature;
}

class PregnancyStory {
  const PregnancyStory({
    required this.week,
    required this.extraDays,
    required this.due,
    required this.size,
    required this.headline,
    required this.body,
    required this.visit,
  });

  final int week;
  final int extraDays;
  final DateTime due;
  final String size;
  final String headline;
  final String body;
  final String visit;
}

class Plate {
  const Plate({required this.meal, required this.detail});

  final String meal;
  final String detail;
}

class NutrientFocus {
  const NutrientFocus({required this.name, required this.detail});

  final String name;
  final String detail;
}

class NutritionPlan {
  const NutritionPlan({
    required this.title,
    required this.why,
    required this.plates,
    required this.focuses,
  });

  final String title;
  final String why;
  final List<Plate> plates;
  final List<NutrientFocus> focuses;
}

class TrainingPlan {
  const TrainingPlan({
    required this.title,
    required this.why,
    required this.blocks,
    required this.caution,
  });

  final String title;
  final String why;
  final List<String> blocks;
  final String caution;
}

class SkinForecast {
  const SkinForecast({
    required this.today,
    required this.ahead,
    required this.routine,
  });

  final String today;
  final String ahead;
  final List<String> routine;
}

class TwinMetric {
  const TwinMetric({required this.label, required this.value, required this.level});

  final String label;
  final String value;
  final double level;
}

class TwinRead {
  const TwinRead({
    required this.day,
    required this.phase,
    required this.point,
    required this.hormones,
    required this.forecasts,
    required this.personal,
  });

  final int day;
  final CyclePhase phase;
  final HormonePoint point;
  final List<TwinMetric> hormones;
  final List<TwinMetric> forecasts;
  final String personal;
}

class DailyBrief {
  const DailyBrief({
    required this.daypart,
    required this.greeting,
    required this.orbKicker,
    required this.orbValue,
    required this.headline,
    required this.energyLine,
    required this.recommendTitle,
    required this.recommendations,
    required this.signals,
    required this.whispers,
    required this.assumption,
    required this.cycle,
    required this.showCycleChart,
    required this.pregnancy,
    required this.wearable,
    required this.notes,
  });

  final Daypart daypart;
  final String greeting;
  final String orbKicker;
  final String orbValue;
  final String headline;
  final String energyLine;
  final String recommendTitle;
  final List<String> recommendations;
  final List<Signal> signals;
  final List<Whisper> whispers;
  final String assumption;
  final CycleSnapshot cycle;
  final bool showCycleChart;
  final PregnancyStory? pregnancy;
  final WearableNight? wearable;
  final List<HealthNote> notes;
}
