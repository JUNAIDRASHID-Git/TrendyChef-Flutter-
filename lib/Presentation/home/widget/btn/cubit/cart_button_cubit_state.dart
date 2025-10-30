part of 'cart_button_cubit.dart';

sealed class CartButtonCubitState {}

/// Initial idle state
final class CartButtonIdle extends CartButtonCubitState {}

/// Loading while adding to cart
final class CartButtonLoading extends CartButtonCubitState {}

/// Successfully added to cart
final class CartButtonSuccess extends CartButtonCubitState {
  final double productPrice;

  CartButtonSuccess(this.productPrice);
}

/// Error occurred
final class CartButtonError extends CartButtonCubitState {
  final String message;

  CartButtonError(this.message);
}
