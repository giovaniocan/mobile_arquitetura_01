import 'package:flutter/material.dart';

import '../models/product.dart';
import '../presentation/controllers/favorites_controller.dart';
import '../services/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductService _service = ProductService();
  late Future<Product> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = _service.getProductById(widget.productId);
  }

  void _reloadProduct() {
    setState(() {
      _futureProduct = _service.getProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FavoritesController.instance,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detalhes do Produto'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: FutureBuilder<Product>(
            future: _futureProduct,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Erro: ${snapshot.error}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _reloadProduct,
                          child: const Text('Tentar novamente'),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Voltar'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('Produto nao encontrado'));
              }

              final product = snapshot.data!;
              final isFavorite = FavoritesController.instance.isFavorite(
                product.id,
              );

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FavoritesController.instance.toggleFavorite(
                            product.id,
                          );
                        },
                        tooltip: isFavorite
                            ? 'Remover dos favoritos'
                            : 'Adicionar aos favoritos',
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Categoria: ${product.category}'),
                  Text('Preco: R\$ ${product.price.toStringAsFixed(2)}'),
                  Text('Avaliacao: ${product.rating}'),
                  Text('Estoque: ${product.stock}'),
                  const SizedBox(height: 16),
                  Text(product.description),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Voltar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            if (isFavorite) {
                              FavoritesController.instance.removeFavorite(
                                product.id,
                              );
                              return;
                            }

                            FavoritesController.instance.toggleFavorite(
                              product.id,
                            );
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          label: Text(
                            isFavorite ? 'Remover favorito' : 'Favoritar',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
