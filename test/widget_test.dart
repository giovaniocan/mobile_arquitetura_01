import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_arquitetura_01/domain/entities/product.dart';
import 'package:mobile_arquitetura_01/domain/repositories/product_repository.dart';
import 'package:mobile_arquitetura_01/domain/usecases/get_products.dart';
import 'package:mobile_arquitetura_01/presentation/controllers/product_controller.dart';
import 'package:mobile_arquitetura_01/presentation/pages/home_page.dart';

void main() {
  testWidgets('deve navegar da tela inicial ate os detalhes do produto', (
    WidgetTester tester,
  ) async {
    final controller = ProductController(
      getProducts: GetProducts(FakeProductRepository()),
    );

    await tester.pumpWidget(
      MaterialApp(home: HomePage(controller: controller)),
    );

    expect(find.text('Pagina Inicial'), findsOneWidget);

    await tester.tap(find.text('Ver produtos'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Lista de Produtos'), findsOneWidget);
    expect(find.text('Produto Teste'), findsOneWidget);

    await tester.tap(find.text('Produto Teste'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Detalhes do Produto'), findsOneWidget);
    expect(find.text('Categoria: eletronicos'), findsOneWidget);
    expect(find.text('Descricao de teste'), findsOneWidget);
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
        description: 'Descricao de teste',
        category: 'eletronicos',
      ),
    ];
  }
}
