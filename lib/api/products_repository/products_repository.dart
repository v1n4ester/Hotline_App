import 'package:hotline_app/api/products_repository/models/product.dart';
import 'package:hotline_app/utils/enums.dart';

abstract class ProductsRepository {
  const ProductsRepository();

  List<Product> retrieveProductsByCategory(ProductCategory category);
}
