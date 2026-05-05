class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
  });

  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
}
