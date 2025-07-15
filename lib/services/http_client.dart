import 'package:http/http.dart' as http;

class HttpClient {
  static const Duration _timeout = Duration(seconds: 30);

  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(_timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http
          .post(Uri.parse(url), headers: headers, body: body)
          .timeout(_timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<http.Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http
          .put(Uri.parse(url), headers: headers, body: body)
          .timeout(_timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<http.Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers, body: body)
          .timeout(_timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
