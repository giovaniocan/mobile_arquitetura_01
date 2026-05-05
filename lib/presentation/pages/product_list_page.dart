import 'package:flutter/material.dart';

import '../controllers/product_controller.dart';
import '../controllers/product_state.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key, required this.controller});

  final ProductController controller;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lista de Produtos'),
            centerTitle: true,
          ),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    if (widget.controller.state.status == ProductStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.controller.state.status == ProductStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.controller.state.errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.controller.loadProducts,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.controller.state.status == ProductStatus.success &&
        widget.controller.products.isEmpty) {
      return const Center(child: Text('Nenhum produto encontrado.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.controller.products.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = widget.controller.products[index];
        return ProductCard(product: product);
      },
    );
  }
}
