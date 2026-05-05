import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const _productsKey = 'cached_products';

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final productsJson = products.map((product) => product.toMap()).toList();
    await _sharedPreferences.setString(_productsKey, jsonEncode(productsJson));
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final cachedData = _sharedPreferences.getString(_productsKey);

    if (cachedData == null || cachedData.isEmpty) {
      return [];
    }

    final decodedData = jsonDecode(cachedData) as List<dynamic>;

    return decodedData
        .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
