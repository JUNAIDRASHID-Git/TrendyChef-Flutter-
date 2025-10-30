import 'package:bloc/bloc.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/api/user/order.dart';
import 'package:trendychef/core/services/models/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<FetchOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final user = await fetchUser();

        final orders = await fetchRecentOrder(user.id);
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });
  }
}
