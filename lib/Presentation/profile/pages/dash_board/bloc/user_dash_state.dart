import 'package:trendychef/core/services/models/cart.dart';
import 'package:trendychef/core/services/models/user_model.dart';

abstract class UserDashState {}

class UserDashInitial extends UserDashState {}

class UserDashLoading extends UserDashState {}

class UserDashLoaded extends UserDashState {
  final UserModel user;
  final List<CartItemModel> items;
  final double totalAmount;
  final double totalKg;
  final double shippingCost;
  final double totalPurchased;

  UserDashLoaded({required this.user, required this.items})
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
      ),
      totalPurchased = 0; // Set a default or compute as needed

  static double _calculateShippingCost(double kg) {
    if (kg == 0) return 0;
    return ((kg / 30).ceil()) * 30;
  }
}

class UserDashError extends UserDashState {
  final String message;
  UserDashError(this.message);
}
