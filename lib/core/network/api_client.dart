import 'dart:convert';

import 'package:http/http.dart' as http;

import '../error/app_exception.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<dynamic>> getList(String url) async {
    try {
      final response = await _client
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw AppException('Falha ao carregar dados da API.');
      }

      final decodedBody = jsonDecode(response.body);

      if (decodedBody is! List<dynamic>) {
        throw AppException('Formato de resposta invalido.');
      }

      return decodedBody;
    } catch (_) {
      throw AppException('Nao foi possivel buscar os produtos.');
    }
  }
}
