part of 'check_out_bloc.dart';

class CheckOutEvent {}

class CheckOutFetchEvent extends CheckOutEvent {}

class CheckOutUpdateEvent extends CheckOutEvent {
  final String productId;
  final int quantity;

  CheckOutUpdateEvent(this.productId, this.quantity);
}
