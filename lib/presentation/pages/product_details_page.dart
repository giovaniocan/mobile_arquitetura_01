import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) {
                  return Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 48),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Preco: R\$ ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Categoria: ${product.category}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descricao',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
