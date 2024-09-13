part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Product> products;
  final ProductsSortedBy productsSorting;
  final ProductCategory currentCategory;
  final bool? isInStock;

  const HomeState({
    this.products = const [],
    this.currentCategory = ProductCategory.all,
    this.productsSorting = ProductsSortedBy.none,
    this.isInStock,
  });

  List<Product> get sortedProducts {
    List<Product> sortedProducts = List.from(products);
    if (isInStock != null) {
      sortedProducts.removeWhere(
        (element) => element.inStock != isInStock,
      );
    }
    switch (productsSorting) {
      case ProductsSortedBy.none:
        return sortedProducts;
      case ProductsSortedBy.priceAsc:
        return sortedProducts
          ..sort(
            (a, b) => a.price.compareTo(b.price),
          );
      case ProductsSortedBy.priceDesc:
        return sortedProducts
          ..sort(
            (a, b) => b.price.compareTo(a.price),
          );
      case ProductsSortedBy.ratingAsc:
        return sortedProducts
          ..sort(
            (a, b) => a.rating.compareTo(b.rating),
          );
      case ProductsSortedBy.ratingDesc:
        return sortedProducts
          ..sort(
            (a, b) => b.rating.compareTo(a.rating),
          );
    }
  }

  HomeState copyWith({
    List<Product>? products,
    ProductCategory? currentCategory,
    ProductsSortedBy? productsSorting,
    bool? Function()? onIsInStock,
  }) {
    return HomeState(
      products: products ?? this.products,
      currentCategory: currentCategory ?? this.currentCategory,
      productsSorting: productsSorting ?? this.productsSorting,
      isInStock: onIsInStock != null ? onIsInStock() : isInStock,
    );
  }

  @override
  List<Object?> get props => [
        products,
        currentCategory,
        productsSorting,
        isInStock,
      ];
}
