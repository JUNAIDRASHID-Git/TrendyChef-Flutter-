import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/core/services/api/product/get.dart';
import 'package:trendychef/core/services/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await getProductByID(productID: event.productID);
        emit(ProductLoaded(product: product));
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}
