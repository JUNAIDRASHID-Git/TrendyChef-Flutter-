import 'package:trendychef/core/services/models/product.dart';

class CategoryModel {
  int? iD;
  String ename;
  String arname;
  List<ProductModel>? products;

  CategoryModel({this.iD, required this.ename, this.products,required this.arname});

  CategoryModel.fromJson(Map<String, dynamic> json)
      : iD = json['ID'],
        ename = json['EName'],
        arname = json['ARName'] {
    if (json['Products'] != null) {
      products = <ProductModel>[];
      json['Products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
  }
}
