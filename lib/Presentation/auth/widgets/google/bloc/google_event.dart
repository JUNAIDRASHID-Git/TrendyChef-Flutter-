// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'google_bloc.dart';

class GoogleEvent {}

class GoogleSignInEvent extends GoogleEvent {
  BuildContext context;
  GoogleSignInEvent({required this.context});
}
