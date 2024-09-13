import 'package:get_it/get_it.dart';
import 'package:hotline_app/api/products_repository/products_repository.dart';
import 'package:hotline_app/api/products_repository/products_repository_impl.dart';

GetIt getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<ProductsRepository>(const ProductsRepositoryImpl());
}
