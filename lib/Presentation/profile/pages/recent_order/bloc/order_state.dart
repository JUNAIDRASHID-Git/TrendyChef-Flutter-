// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  List<OrderModel> orders;
  OrderLoaded({required this.orders});
}

class OrderError extends OrderState {
  String message;
  OrderError({required this.message});
}
