import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required ProductLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final remoteProducts = await _remoteDataSource.getProducts();
      await _localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } catch (_) {
      final cachedProducts = await _localDataSource.getCachedProducts();

      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }

      rethrow;
    }
  }
}
