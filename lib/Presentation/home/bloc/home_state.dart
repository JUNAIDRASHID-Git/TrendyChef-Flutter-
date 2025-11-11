import 'package:trendychef/core/services/models/category.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final String userName;
  HomeLoaded({required this.categories, required this.userName});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
