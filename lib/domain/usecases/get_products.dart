import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  GetProducts(this.repository);

  final ProductRepository repository;

  Future<List<Product>> call() {
    return repository.getProducts();
  }
}
