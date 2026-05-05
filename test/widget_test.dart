import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_arquitetura_01/domain/entities/product.dart';
import 'package:mobile_arquitetura_01/domain/repositories/product_repository.dart';
import 'package:mobile_arquitetura_01/domain/usecases/get_products.dart';
import 'package:mobile_arquitetura_01/presentation/controllers/product_controller.dart';
import 'package:mobile_arquitetura_01/presentation/pages/product_list_page.dart';

void main() {
  testWidgets('deve exibir os produtos carregados na tela', (
    WidgetTester tester,
  ) async {
    final controller = ProductController(
      getProducts: GetProducts(FakeProductRepository()),
    );

    await tester.pumpWidget(
      MaterialApp(home: ProductListPage(controller: controller)),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Lista de Produtos'), findsOneWidget);
    expect(find.text('Produto Teste'), findsOneWidget);
    expect(find.text('R\$ 99.90'), findsOneWidget);
  });
}

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return const [
      Product(
        id: 1,
        title: 'Produto Teste',
        price: 99.9,
        image: 'https://example.com/image.png',
      ),
    ];
  }
}
