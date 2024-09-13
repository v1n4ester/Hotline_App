import 'package:hotline_app/api/products_repository/models/product.dart';
import 'package:hotline_app/utils/enums.dart';

class Constants {

  static const allProducts = [
    ...fruitsList,
    ...vegetablesList,
    ...drinksList,
  ];

  static const fruitsList = [
    Product(
      name: "Apple",
      category: ProductCategory.isFruit,
      price: 25,
      inStock: true,
      rating: 4.5,
    ),
    Product(
      name: "Banana",
      category: ProductCategory.isFruit,
      price: 35,
      inStock: true,
      rating: 4.2,
    ),
    Product(
      name: "Pear",
      category: ProductCategory.isFruit,
      price: 80,
      inStock: false,
      rating: 4,
    ),
  ];

  static const vegetablesList = [
    Product(
      name: "Tomato",
      category: ProductCategory.isVegetable,
      price: 45,
      inStock: true,
      rating: 3.6,
    ),
    Product(
      name: "Cucumber",
      category: ProductCategory.isVegetable,
      price: 50,
      inStock: false,
      rating: 2.5,
    ),
    Product(
      name: "Carrot",
      category: ProductCategory.isVegetable,
      price: 15,
      inStock: false,
      rating: 5,
    ),
  ];

  static const drinksList = [
    Product(
      name: "Jack Daniels",
      category: ProductCategory.isDrink,
      price: 800,
      inStock: true,
      rating: 4.4,
    ),
    Product(
      name: "Jim Beam",
      category: ProductCategory.isDrink,
      price: 650,
      inStock: true,
      rating: 4.3,
    ),
    Product(
      name: "Coca cola",
      category: ProductCategory.isDrink,
      price: 40,
      inStock: true,
      rating: 4.9,
    ),
  ];
}
