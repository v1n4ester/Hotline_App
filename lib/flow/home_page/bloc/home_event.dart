part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent {
  const HomeInitialEvent();
}

class RetrieveProductsEvent extends HomeEvent {
  final ProductCategory productCategory;

  const RetrieveProductsEvent(this.productCategory);
}

class ChangeCurrentCategory extends HomeEvent {
  final ProductCategory productCategory;

  const ChangeCurrentCategory(this.productCategory);
}

class ChangeSortingEvent extends HomeEvent {
  final ProductsSortedBy productsSortedBy;

  const ChangeSortingEvent(this.productsSortedBy);
}

class ChangeIsInStock extends HomeEvent {
  final bool? isInStock;

  const ChangeIsInStock(this.isInStock);
}
