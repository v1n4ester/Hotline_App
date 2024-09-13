import 'package:hotline_app/utils/enums.dart';

class Product {
  final String name;
  final ProductCategory category;
  final double price;
  final bool inStock;
  final double rating;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.inStock,
    required this.rating,
  });
}
