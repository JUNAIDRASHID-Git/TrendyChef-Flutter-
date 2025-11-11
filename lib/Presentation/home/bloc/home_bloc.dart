import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/product/get.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final categories = await getAllCategoryWithProducts();
      final user = await fetchUser();
      emit(HomeLoaded(categories: categories, userName: user.name));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
