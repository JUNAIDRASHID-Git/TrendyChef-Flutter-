abstract class CartEvent {}

class LoadCartItems extends CartEvent {}

class UpdateCartQuantityEvent extends CartEvent {
  final String productId;
  final int quantity;

  UpdateCartQuantityEvent({required this.productId, required this.quantity});
}

class DeleteCartItem extends CartEvent {
  final int itemId;

  DeleteCartItem(this.itemId);
}
