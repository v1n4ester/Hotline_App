import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotline_app/api/products_repository/models/product.dart';
import 'package:hotline_app/api/products_repository/products_repository.dart';
import 'package:hotline_app/utils/enums.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductsRepository _productsRepository;

  HomeBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(const HomeState()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<RetrieveProductsEvent>(_onRetrieveProductsEvent);
    on<ChangeCurrentCategory>(_onChangeCurrentCategory);
    on<ChangeSortingEvent>(_onChangeSortingEvent);
    on<ChangeIsInStock>(_onChangeIsInStock);
  }

  void _onHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    add(RetrieveProductsEvent(state.currentCategory));
  }

  Future<void> _onRetrieveProductsEvent(
      RetrieveProductsEvent event, Emitter<HomeState> emit) async {
    final List<Product> allProducts = _productsRepository
        .retrieveProductsByCategory(state.currentCategory);
    emit(state.copyWith(products: allProducts));
  }

  void _onChangeCurrentCategory(
      ChangeCurrentCategory event, Emitter<HomeState> emit) async {
    final productCategory = event.productCategory;
    if (productCategory == state.currentCategory) return;
    emit(state.copyWith(currentCategory: productCategory));
    add(RetrieveProductsEvent(productCategory));
  }

  void _onChangeSortingEvent(
      ChangeSortingEvent event, Emitter<HomeState> emit) {
    final productsSortedBy = event.productsSortedBy;
    if (productsSortedBy == state.productsSorting) return;
    emit(state.copyWith(productsSorting: productsSortedBy));
  }

  void _onChangeIsInStock(ChangeIsInStock event, Emitter<HomeState> emit) {
    final isInStock = event.isInStock;
    if (isInStock == state.isInStock) return;
    emit(state.copyWith(onIsInStock: () => isInStock));
  }
}
