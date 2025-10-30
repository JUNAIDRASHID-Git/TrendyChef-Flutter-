import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/cart/post.dart';

enum CartButtonState { idle, loading, success, error }

class CartButtonCubit extends Cubit<CartButtonState> {
  CartButtonCubit() : super(CartButtonState.idle);

  Future<void> addToCart(
    String productId,
    double price,
    Function? onSuccess,
  ) async {
    if (state != CartButtonState.idle) return;

    emit(CartButtonState.loading);

    try {
      await postCart(productId: productId, quantity: 1);
      await Future.delayed(const Duration(milliseconds: 800));

      emit(CartButtonState.success);
      onSuccess?.call();

      await Future.delayed(const Duration(seconds: 2));
      emit(CartButtonState.idle);
    } catch (_) {
      emit(CartButtonState.error);

      await Future.delayed(const Duration(seconds: 2));
      emit(CartButtonState.idle);
    }
  }
}
