import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_models.dart';
import 'http_client.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8080'; // Измените на ваш URL
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Ключи для хранения токенов
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Регистрация пользователя
  static Future<SignUpResponse?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await HttpClient.post(
        '$baseUrl/users',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return SignUpResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  // Вход пользователя
  static Future<SignInResponse?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await HttpClient.post(
        '$baseUrl/auth/login',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final signInResponse = SignInResponse.fromJson(jsonResponse);

        // Сохраняем токены
        await _storage.write(
          key: _accessTokenKey,
          value: signInResponse.accessToken,
        );
        await _storage.write(
          key: _refreshTokenKey,
          value: signInResponse.refreshToken,
        );

        return signInResponse;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  // Обновление токена
  static Future<RefreshTokenResponse?> refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await HttpClient.post(
        '$baseUrl/auth/refresh',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final refreshResponse = RefreshTokenResponse.fromJson(jsonResponse);

        // Обновляем токены
        await _storage.write(
          key: _accessTokenKey,
          value: refreshResponse.accessToken,
        );
        await _storage.write(
          key: _refreshTokenKey,
          value: refreshResponse.refreshToken,
        );

        return refreshResponse;
      } else {
        throw Exception('Token refresh failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Token refresh error: $e');
    }
  }

  // Получение данных пользователя
  static Future<User?> getUserData() async {
    try {
      final accessToken = await _storage.read(key: _accessTokenKey);
      if (accessToken == null) {
        throw Exception('No access token available');
      }

      final response = await HttpClient.get(
        '$baseUrl/users/me',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        // Попытка обновить токен
        final refreshResponse = await refreshToken();
        if (refreshResponse != null) {
          // Повторный запрос с новым токеном
          return await getUserData();
        }
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to get user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get user data error: $e');
    }
  }

  // Получение текущего access токена
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Проверка авторизации
  static Future<bool> isAuthenticated() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    return accessToken != null;
  }

  // Выход из системы
  static Future<void> signOut() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // Очистка всех токенов
  static Future<void> clearTokens() async {
    await _storage.deleteAll();
  }
}
