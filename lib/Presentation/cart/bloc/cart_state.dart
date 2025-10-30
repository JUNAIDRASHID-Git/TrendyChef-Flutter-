import 'package:trendychef/core/services/models/cart.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double totalAmount;
  final double totalKg;
  final double shippingCost;

  CartLoaded(this.items)
    : totalAmount = items.fold(
        0,
        (sum, item) => sum + (item.productSalePrice * item.quantity),
      ),
      totalKg = items.fold(
        0,
        (sum, item) => sum + (item.weight * item.quantity),
      ),
      shippingCost = _calculateShippingCost(
        items.fold(0, (sum, item) => sum + (item.weight * item.quantity)),
      );

  static double _calculateShippingCost(double kg) {
    if (kg == 0) return 0;
    return ((kg / 30).ceil()) * 30;
  }
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
