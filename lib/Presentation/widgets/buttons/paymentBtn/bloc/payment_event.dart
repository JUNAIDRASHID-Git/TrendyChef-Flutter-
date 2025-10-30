part of 'payment_bloc.dart';

class PaymentEvent {}

class InitPayment extends PaymentEvent {
  final PaymentModel payment;

  InitPayment({required this.payment});
}
