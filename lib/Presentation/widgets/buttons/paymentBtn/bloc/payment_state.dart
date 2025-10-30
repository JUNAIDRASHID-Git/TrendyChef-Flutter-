part of 'payment_bloc.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final String url;

  PaymentLoaded({required this.url});
}

class PaymentError extends PaymentState {
  final String error;

  PaymentError({required this.error});
}
