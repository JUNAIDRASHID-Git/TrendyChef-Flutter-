// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_bloc.dart';

class AddressEvent {}

class FetchAddressEvent extends AddressEvent {}

class EditAddressEvent extends AddressEvent {
  final UserModel user;
  EditAddressEvent({required this.user});
}
