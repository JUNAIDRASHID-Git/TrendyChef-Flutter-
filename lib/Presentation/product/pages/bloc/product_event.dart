part of 'product_bloc.dart';

class ProductEvent {}

class GetProductEvent extends ProductEvent {
  String productID;
  GetProductEvent({required this.productID});
}
