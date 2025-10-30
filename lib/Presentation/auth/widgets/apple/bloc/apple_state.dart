abstract class AppleState {}

class AppleInitialState extends AppleState {}

class AppleLoadingState extends AppleState {}

class AppleSuccessState extends AppleState {}

class AppleErrorState extends AppleState {
  final String message;
  AppleErrorState(this.message);
}
