import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key, required this.productId});

  final int productId;
  final ProductService _service = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Produto')),
      body: FutureBuilder<Product>(
        future: _service.getProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Produto nao encontrado'));
          }

          final product = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Image.network(
                product.thumbnail,
                height: 180,
                errorBuilder: (_, _, _) => Container(
                  height: 180,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Categoria: ${product.category}'),
              Text('Preco: R\$ ${product.price.toStringAsFixed(2)}'),
              Text('Avaliacao: ${product.rating}'),
              Text('Estoque: ${product.stock}'),
              const SizedBox(height: 16),
              Text(product.description),
            ],
          );
        },
      ),
    );
  }
}
