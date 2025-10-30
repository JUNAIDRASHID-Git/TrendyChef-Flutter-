import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/cart/post.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/models/cart.dart';
import 'package:trendychef/core/services/models/user_model.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(CheckOutInitial()) {
    on<CheckOutFetchEvent>((event, emit) async {
      try {
        emit(CheckOutLoading());
        final items = await fetchCartItems();
        final user = await fetchUser();

        emit(CheckOutLoaded(items, user));
        // ignore: empty_catches
      } catch (e) {
        emit(CheckOutError(e.toString()));
      }
    });
    on<CheckOutUpdateEvent>((event, emit) async {
      try {
        await postCart(productId: event.productId, quantity: event.quantity);
        final items = await fetchCartItems(); // Refresh cart after update
        final user = await fetchUser();
        emit(CheckOutLoaded(items, user));
      } catch (e) {
        emit(CheckOutError(e.toString()));
      }
    });
  }
}
