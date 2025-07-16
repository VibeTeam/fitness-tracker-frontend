// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroup _$MuscleGroupFromJson(Map<String, dynamic> json) => MuscleGroup(
      id: (json['ID'] as num).toInt(),
      name: json['Name'] as String,
    );

Map<String, dynamic> _$MuscleGroupToJson(MuscleGroup instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
    };

WorkoutType _$WorkoutTypeFromJson(Map<String, dynamic> json) => WorkoutType(
      id: (json['ID'] as num).toInt(),
      name: json['Name'] as String,
      muscleGroupId: (json['MuscleGroupID'] as num).toInt(),
      muscleGroup: json['MuscleGroup'] == null
          ? null
          : MuscleGroup.fromJson(json['MuscleGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkoutTypeToJson(WorkoutType instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'MuscleGroupID': instance.muscleGroupId,
      'MuscleGroup': instance.muscleGroup,
    };

WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) =>
    WorkoutSession(
      id: (json['ID'] as num).toInt(),
      workoutTypeId: (json['WorkoutTypeID'] as num).toInt(),
      userId: (json['UserID'] as num).toInt(),
      datetime: json['Datetime'] as String,
      workoutType: json['WorkoutType'] == null
          ? null
          : WorkoutType.fromJson(json['WorkoutType'] as Map<String, dynamic>),
      details: (json['Details'] as List<dynamic>?)
          ?.map((e) => WorkoutDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutSessionToJson(WorkoutSession instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'WorkoutTypeID': instance.workoutTypeId,
      'UserID': instance.userId,
      'Datetime': instance.datetime,
      'WorkoutType': instance.workoutType,
      'Details': instance.details,
    };

WorkoutDetail _$WorkoutDetailFromJson(Map<String, dynamic> json) =>
    WorkoutDetail(
      id: (json['ID'] as num).toInt(),
      workoutSessionId: (json['WorkoutSessionID'] as num).toInt(),
      detailName: json['DetailName'] as String,
      detailValue: json['DetailValue'] as String,
    );

Map<String, dynamic> _$WorkoutDetailToJson(WorkoutDetail instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'WorkoutSessionID': instance.workoutSessionId,
      'DetailName': instance.detailName,
      'DetailValue': instance.detailValue,
    };
