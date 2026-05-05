import 'package:flutter/material.dart';

import '../controllers/product_controller.dart';
import 'product_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Inicial'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.storefront, size: 72, color: Colors.teal),
              const SizedBox(height: 24),
              const Text(
                'Aplicacao de Produtos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Clique no botao abaixo para visualizar a lista de produtos.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductListPage(controller: controller),
                    ),
                  );
                },
                child: const Text('Ver produtos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
