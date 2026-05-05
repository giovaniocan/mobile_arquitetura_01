import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

class ProductController extends ChangeNotifier {
  ProductController({required GetProducts getProducts})
      : _getProducts = getProducts;

  final GetProducts _getProducts;

  bool isLoading = false;
  String? errorMessage;
  List<Product> products = [];

  Future<void> loadProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await _getProducts();
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
