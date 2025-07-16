import 'dart:convert';
import 'auth_service.dart';
import 'http_client.dart';

class SuggestionService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<String> getSuggestion() async {
    try {
      final accessToken = await AuthService.getAccessToken();
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final response = await HttpClient.get(
        '$baseUrl/suggest-workout',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['suggestion'] ?? 'No suggestion available';
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get suggestion: $e');
    }
  }
}