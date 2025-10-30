class CartItemModel {
  final int id;
  final int cartId;
  final int productId;
  final String productEName;
  final String productArName;
  final String productImage;
  final double productSalePrice;
  final double productRegularPrice;
  final double weight;
  final int stock;
  final int quantity;
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.productEName,
    required this.productArName,
    required this.productImage,
    required this.productSalePrice,
    required this.productRegularPrice,
    required this.weight,
    required this.stock,
    required this.quantity,
    required this.addedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['ID'],
      cartId: json['CartID'],
      productId: json['ProductID'],
      productEName: json['ProductEName'],
      productArName: json['ProductArName'],
      productImage: json['ProductImage'],
      productSalePrice: (json['ProductSalePrice'] as num).toDouble(),
      productRegularPrice: (json['ProductRegularPrice'] as num).toDouble(),
      weight: (json['Weight'] as num).toDouble(),
      stock: (json['ProductStock']),
      quantity: json['Quantity'],
      addedAt: DateTime.parse(json['AddedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CartID': cartId,
      'ProductID': productId,
      'ProductEName': productEName,
      'ProductArName': productArName,
      'ProductImage': productImage,
      'ProductSalePrice': productSalePrice,
      'ProductRegularPrice': productRegularPrice,
      'Weight': weight,
      'Quantity': quantity,
      'AddedAt': addedAt.toIso8601String(),
    };
  }
}
