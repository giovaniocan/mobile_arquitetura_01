import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required ProductRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() {
    return _remoteDataSource.getProducts();
  }
}
