import 'package:bloc/bloc.dart';
import 'package:trendychef/core/services/api/payment/payment.dart';
import 'package:trendychef/core/services/models/payment.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<InitPayment>((event, emit) async {
      emit(PaymentLoading());

      try {
        final url = await initPayment(payment: event.payment);
        emit(PaymentLoaded(url: url!));
      } catch (e) {
        emit(PaymentError(error: e.toString()));
      }
    });
  }
}
