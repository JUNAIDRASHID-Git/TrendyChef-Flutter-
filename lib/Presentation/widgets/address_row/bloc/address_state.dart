// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_bloc.dart';

class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  UserModel user;
  Address address;
  String phone;
  AddressLoaded({
    required this.user,
    required this.address,
    required this.phone,
  });
}

class AddressEdited extends AddressState {
  Address address;
  String phone;
  AddressEdited({required this.address, required this.phone});
}

class AddressError extends AddressState {
  String error;
  AddressError({required this.error});
}
