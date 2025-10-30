part of 'search_bloc.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  List<ProductModel> products;
  SearchLoaded({required this.products});
}

class SearchError extends SearchState {}
