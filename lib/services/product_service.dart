import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  ProductService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> getProducts() async {
    final response = await _client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> productsJson = data['products'] as List<dynamic>;

      return productsJson
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Erro ao carregar produtos');
  }

  Future<Product> getProductById(int id) async {
    final response = await _client.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(data);
    }

    throw Exception('Erro ao carregar produto');
  }
}
