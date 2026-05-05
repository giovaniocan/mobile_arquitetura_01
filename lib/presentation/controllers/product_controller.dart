import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import 'product_state.dart';

class ProductController extends ChangeNotifier {
  ProductController({required GetProducts getProducts})
      : _getProducts = getProducts;

  final GetProducts _getProducts;

  ProductState _state = const ProductState();

  ProductState get state => _state;
  List<Product> get products => _state.products;

  Future<void> loadProducts() async {
    _state = _state.copyWith(
      status: ProductStatus.loading,
      clearErrorMessage: true,
    );
    notifyListeners();

    try {
      final loadedProducts = await _getProducts();
      _state = ProductState(
        status: ProductStatus.success,
        products: loadedProducts,
      );
    } catch (error) {
      _state = ProductState(
        status: ProductStatus.error,
        errorMessage: error.toString(),
      );
    }

    notifyListeners();
  }
}
