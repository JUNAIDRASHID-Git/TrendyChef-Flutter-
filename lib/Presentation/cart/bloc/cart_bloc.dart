import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/cart/delete.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/cart/post.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    // Load Cart
    on<LoadCartItems>((event, emit) async {
      emit(CartLoading());
      try {
        final items = await fetchCartItems();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError('Failed to load cart'));
      }
    });

    // Update Quantity
    on<UpdateCartQuantityEvent>((event, emit) async {
      try {
        await postCart(productId: event.productId, quantity: event.quantity);
        final items = await fetchCartItems(); // Refresh cart after update
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError('Failed to update quantity'));
      }
    });

    // Delete Item
    on<DeleteCartItem>((event, emit) async {
      try {
        await deleteCartItem(event.itemId);
        final items = await fetchCartItems(); // Refresh cart after delete
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError('Failed to delete item: ${e.toString()}'));
      }
    });
  }
}
