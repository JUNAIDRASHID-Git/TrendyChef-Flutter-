// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'google_bloc.dart';

class GoogleState {}

class GoogleInitial extends GoogleState {}

class GoogleLoading extends GoogleState {}

class GoogleLoaded extends GoogleState {
  String provider;
  GoogleLoaded({required this.provider});
}

class GoogleError extends GoogleState {
  String error;
  GoogleError({required this.error});
}
