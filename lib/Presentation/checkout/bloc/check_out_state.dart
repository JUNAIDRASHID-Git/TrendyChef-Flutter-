part of 'check_out_bloc.dart';

@immutable
sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutLoading extends CheckOutState {}

final class CheckOutLoaded extends CheckOutState {
  final List<CartItemModel> items;
  final UserModel user;
  final double totalAmount;
  final double totalKg;
  final double shippingCost;

  CheckOutLoaded(this.items, this.user)
    : totalAmount = items.fold(
        0,
        (sum, item) => sum + (item.productSalePrice * item.quantity),
      ),
      totalKg = items.fold(
        0,
        (sum, item) => sum + (item.weight * item.quantity),
      ),
      shippingCost =
          (() {
            double totalKg = items.fold(
              0,
              (sum, item) => sum + (item.weight * item.quantity),
            );

            if (totalKg <= 0) {
              return 0.0;
            } else if (totalKg <= 29) {
              return 30.0;
            } else if (totalKg <= 59) {
              return 60.0;
            } else if (totalKg <= 89) {
              return 90.0;
            } else {
              int extraBlocks = ((totalKg - 89) / 30).ceil();
              return 90.0 + (extraBlocks * 30.0);
            }
          })();
}

final class CheckOutError extends CheckOutState {
  final String message;

  CheckOutError(this.message);
}
