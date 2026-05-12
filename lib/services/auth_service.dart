import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_user.dart';

class AuthService {
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl = 'https://dummyjson.com/auth';

  Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return AuthUser.fromJson(data);
    }

    throw Exception('Usuario ou senha invalidos');
  }

  Future<Map<String, dynamic>> getCurrentUser(String accessToken) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Token invalido ou expirado');
  }
}
