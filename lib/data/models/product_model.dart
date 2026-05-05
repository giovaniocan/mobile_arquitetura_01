import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.description,
    required super.category,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int? ?? 0,
      title: map['title'] as String? ?? 'Produto sem titulo',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      image: map['image'] as String? ?? '',
      description: map['description'] as String? ?? 'Sem descricao.',
      category: map['category'] as String? ?? 'Sem categoria',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
    };
  }
}
