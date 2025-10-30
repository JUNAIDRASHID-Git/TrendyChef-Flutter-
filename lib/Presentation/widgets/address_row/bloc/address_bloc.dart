import 'package:bloc/bloc.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/api/user/put.dart';
import 'package:trendychef/core/services/models/user_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<AddressEvent>((event, emit) async {
      emit(AddressLoading());
      try {
        final user = await fetchUser();
        emit(
          AddressLoaded(user: user, address: user.address, phone: user.phone),
        );
      } catch (e) {
        emit(AddressError(error: e.toString()));
      }
    });
    on<EditAddressEvent>((event, emit) async {
      emit(AddressLoading());
      // Add your address edit logic here
      try {
        await updateUser(event.user);

        final updatedUser = await fetchUser();

        emit(
          AddressLoaded(
            address: updatedUser.address,
            phone: updatedUser.phone,
            user: updatedUser,
          ),
        );
      } catch (e) {
        emit(AddressError(error: e.toString()));
      }
    });
  }
}
