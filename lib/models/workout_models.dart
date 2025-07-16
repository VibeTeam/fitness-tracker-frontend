import 'package:json_annotation/json_annotation.dart';

part 'workout_models.g.dart';

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: 'ID')
  final int id;
  @JsonKey(name: 'Name')
  final String name;

  MuscleGroup({required this.id, required this.name});

  factory MuscleGroup.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupToJson(this);
}

@JsonSerializable()
class WorkoutType {
  @JsonKey(name: 'ID')
  final int id;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'MuscleGroupID')
  final int muscleGroupId;
  @JsonKey(name: 'MuscleGroup')
  final MuscleGroup? muscleGroup;

  WorkoutType({
    required this.id,
    required this.name,
    required this.muscleGroupId,
    this.muscleGroup,
  });

  factory WorkoutType.fromJson(Map<String, dynamic> json) =>
      _$WorkoutTypeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutTypeToJson(this);
}

@JsonSerializable()
class WorkoutSession {
  @JsonKey(name: 'ID')
  final int id;
  @JsonKey(name: 'WorkoutTypeID')
  final int workoutTypeId;
  @JsonKey(name: 'UserID')
  final int userId;
  @JsonKey(name: 'Datetime')
  final String datetime;
  @JsonKey(name: 'WorkoutType')
  final WorkoutType? workoutType;
  @JsonKey(name: 'Details')
  final List<WorkoutDetail>? details;

  WorkoutSession({
    required this.id,
    required this.workoutTypeId,
    required this.userId,
    required this.datetime,
    this.workoutType,
    this.details,
  });

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutSessionToJson(this);
}

@JsonSerializable()
class WorkoutDetail {
  @JsonKey(name: 'ID')
  final int id;
  @JsonKey(name: 'WorkoutSessionID')
  final int workoutSessionId;
  @JsonKey(name: 'DetailName')
  final String detailName;
  @JsonKey(name: 'DetailValue')
  final String detailValue;

  WorkoutDetail({
    required this.id,
    required this.workoutSessionId,
    required this.detailName,
    required this.detailValue,
  });

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutDetailToJson(this);
}

// Статические описания упражнений
class ExerciseDescription {
  static const Map<String, String> descriptions = {
    'Bench press':
        'Classic barbell exercise to build overall chest strength and mass',
    'Incline bench press':
        'Targets the upper chest and shoulders using an inclined bench',
    'Decline bench press':
        'Emphasizes the lower chest using a declined bench position',
    'Dumbbell press':
        'Increases chest activation and improves muscle balance using dumbbells',
    'Chest fly': 'Isolates the chest muscles with a wide arc motion',
    'Cable crossover':
        'Constant tension exercise that targets inner chest definition',
    'Crunches':
        'Core-tightening exercise that emphasizes upper abdominal contraction for muscle tone',
    'Leg Raises':
        'Lower-ab focused movement that builds core control and enhances midsection definition',
    'Russian Twists':
        'Rotational core exercise that sharpens obliques and improves trunk stability',
    'Plank':
        'Static hold that builds deep core endurance and full-body stabilization',
    'Bicycle Crunches':
        'Dynamic ab movement combining flexion and rotation to target the entire core',
    'Mountain Climbers':
        'Fast-paced cardio-core hybrid that activates abs while improving agility and endurance',
    'Pull-Ups':
        'Essential bodyweight movement for building lat width and upper-body strength.',
    'Deadlifts':
        'Full posterior chain builder that develops raw strength and back density.',
    'Bent-Over Rows':
        'Compound pulling exercise that thickens the mid-back and improves posture.',
    'Lat Pulldowns':
        'Machine-based vertical pull that widens the lats and strengthens the upper back.',
    'Superman Hold':
        'Isometric move that builds lower back endurance and reinforces spinal alignment.',
    'Reverse Flys':
        'Isolation exercise that enhances rear deltoid and upper-back definition.',
    'Bicep Curls':
        'Classic arm-building movement for developing peak size and shape in the biceps.',
    'Tricep Dips':
        'Bodyweight push exercise that builds mass and definition in the triceps.',
    'Hammer Curls':
        'Bicep and forearm builder that emphasizes arm thickness and grip strength.',
    'Overhead Tricep Extension':
        'Stretch-focused movement that targets the long head of the triceps for fuller development.',
    'Concentration Curls':
        'Focused isolation exercise for maximum bicep contraction and peak shaping.',
    'Close-Grip Push-Ups':
        'Compound upper-body move that targets triceps while also working the chest.',
    'Squats':
        'Foundational lower-body exercise for building strength, mass, and functional mobility.',
    'Lunges':
        'Unilateral leg movement that improves balance, stability, and muscular symmetry.',
    'Leg Press':
        'Machine-based compound exercise for developing quad, hamstring, and glute power.',
    'Romanian Deadlifts':
        'Posterior-chain dominant lift that emphasizes hamstring stretch and glute activation.',
    'Step-Ups':
        'Functional strength exercise that targets quads and glutes with added balance work.',
    'Calf Raises':
        'Isolation movement for developing lower leg strength, size, and endurance.',
    'Shoulder Press':
        'Compound lift that builds deltoid mass and upper-body pressing power.',
    'Lateral Raises':
        'Isolation movement that adds width and definition to the side delts.',
    'Front Raises':
        'Targeted exercise that builds front deltoid strength and shoulder shape.',
    'Arnold Press':
        'Rotational pressing variation that fully engages all heads of the deltoid.',
    'Reverse Pec Deck Flys':
        'Machine exercise for rear delts that improves shoulder balance and posture.',
    'Upright Rows':
        'Compound pull that targets traps and lateral delts for a fuller shoulder look.',
  };

  static String getDescription(String exerciseName) {
    return descriptions[exerciseName] ?? 'Exercise description not available';
  }
}
