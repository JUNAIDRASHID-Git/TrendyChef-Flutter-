part of 'product_bloc.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  ProductModel product;
  ProductLoaded({required this.product});
}

final class ProductError extends ProductState {}
