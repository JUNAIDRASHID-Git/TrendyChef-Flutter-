import 'package:bloc/bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_event.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_state.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/user/get.dart';

class UserDashBloc extends Bloc<UserDashEvent, UserDashState> {
  UserDashBloc() : super(UserDashInitial()) {
    on<UserDashFetchEvent>((event, emit) async {
      emit(UserDashLoading());
      try {
        final user = await fetchUser();
        final items = await fetchCartItems();
        emit(UserDashLoaded(user: user, items: items));
      } catch (e) {
        emit(UserDashError(e.toString()));
      }
    });
  }
}
