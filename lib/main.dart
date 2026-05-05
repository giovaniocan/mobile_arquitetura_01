import 'package:flutter/material.dart';

import 'core/network/api_client.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/controllers/product_controller.dart';
import 'presentation/pages/product_list_page.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = ProductRemoteDataSourceImpl(apiClient: apiClient);
  final repository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);
  final getProducts = GetProducts(repository);
  final controller = ProductController(getProducts: getProducts);

  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: ProductListPage(controller: controller),
    );
  }
}
