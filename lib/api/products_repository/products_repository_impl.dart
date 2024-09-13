import 'package:hotline_app/api/products_repository/models/product.dart';
import 'package:hotline_app/api/products_repository/products_repository.dart';
import 'package:hotline_app/utils/constants.dart';
import 'package:hotline_app/utils/enums.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl();

  @override
  List<Product> retrieveProductsByCategory(ProductCategory category) {
    switch (category) {
      case ProductCategory.isFruit:
        return Constants.fruitsList;
      case ProductCategory.isVegetable:
        return Constants.vegetablesList;
      case ProductCategory.isDrink:
        return Constants.drinksList;
      case ProductCategory.all:
        return Constants.allProducts;
    }
  }
}
