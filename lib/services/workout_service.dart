import 'dart:convert';
import '../models/workout_models.dart';
import 'http_client.dart';
import 'auth_service.dart';

class WorkoutService {
  static const String baseUrl = 'http://localhost:8080'; // Измените на ваш URL

  // Получение групп мышц
  static Future<List<MuscleGroup>> getMuscleGroups() async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final response = await HttpClient.get(
        '$baseUrl/muscle-groups',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => MuscleGroup.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get muscle groups: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get muscle groups error: $e');
    }
  }

  // Получение типов тренировок по группе мышц
  static Future<List<WorkoutType>> getWorkoutTypesByMuscleGroup(
    int muscleGroupId,
  ) async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final response = await HttpClient.get(
        '$baseUrl/workout-types',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final allWorkoutTypes = jsonList
            .map((json) => WorkoutType.fromJson(json))
            .toList();

        // Фильтруем по muscle_group_id
        return allWorkoutTypes
            .where((type) => type.muscleGroupId == muscleGroupId)
            .toList();
      } else {
        throw Exception('Failed to get workout types: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get workout types error: $e');
    }
  }

  // Получение сессий тренировок пользователя
  static Future<List<WorkoutSession>> getWorkoutSessions({
    int? limit,
    int? offset,
  }) async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      String url = '$baseUrl/workout-sessions';
      if (limit != null || offset != null) {
        final params = <String>[];
        if (limit != null) params.add('limit=$limit');
        if (offset != null) params.add('offset=$offset');
        url += '?${params.join('&')}';
      }

      final response = await HttpClient.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => WorkoutSession.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to get workout sessions: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Get workout sessions error: $e');
    }
  }

  // Создание новой сессии тренировки
  static Future<WorkoutSession?> createWorkoutSession({
    required int workoutTypeId,
    String? datetime,
  }) async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final requestData = {
        'workout_type_id': workoutTypeId,
        if (datetime != null) 'datetime': datetime,
      };

      final response = await HttpClient.post(
        '$baseUrl/workout-sessions',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return WorkoutSession.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to create workout session: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Create workout session error: $e');
    }
  }

  // Добавление детали к сессии тренировки
  static Future<WorkoutDetail?> addWorkoutDetail({
    required int sessionId,
    required String detailName,
    required String detailValue,
  }) async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final requestData = {'name': detailName, 'value': detailValue};

      final response = await HttpClient.post(
        '$baseUrl/workout-sessions/$sessionId/details',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return WorkoutDetail.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to add workout detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Add workout detail error: $e');
    }
  }

  // Удаление сессии тренировки
  static Future<bool> deleteWorkoutSession(int sessionId) async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final response = await HttpClient.delete(
        '$baseUrl/workout-sessions/$sessionId',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Delete workout session error: $e');
    }
  }
}
