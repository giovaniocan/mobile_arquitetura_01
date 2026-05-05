import '../models/product_model.dart';
import '../../core/network/api_client.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _apiClient.getList(
      'https://fakestoreapi.com/products',
    );

    return response
        .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
