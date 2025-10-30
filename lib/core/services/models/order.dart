import 'package:trendychef/core/services/models/user_model.dart';

class OrderModel {
  final int id;
  final String userId;
  final UserModel user;
  final List<OrderItem> items;
  final double shippingCost;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.items,
    required this.shippingCost,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      items:
          (json['items'] as List<dynamic>? ?? [])
              .map((e) => OrderItem.fromJson(e))
              .toList(),
      shippingCost: (json['shipping_cost'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'pending',
      paymentStatus: json['payment_status'] ?? 'pending',
      paymentMethod: json['payment_method'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'user': user.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'shipping_cost': shippingCost,
    'total_amount': totalAmount,
    'status': status,
    'payment_status': paymentStatus,
    'payment_method': paymentMethod,
    'created_at': createdAt.toIso8601String(),
  };
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productEName;
  final String productArName;
  final String productImage;
  final double productSalePrice;
  final double productRegularPrice;
  final double weight;
  final int quantity;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productEName,
    required this.productArName,
    required this.productImage,
    required this.productSalePrice,
    required this.productRegularPrice,
    required this.weight,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    // ✅ Fix: Your API returns capitalized keys like "ID", "OrderID"
    // So we normalize both cases to be safe
    return OrderItem(
      id: json['id'] ?? json['ID'] ?? 0,
      orderId: json['order_id'] ?? json['OrderID'] ?? 0,
      productId: json['product_id'] ?? json['ProductID'] ?? 0,
      productEName: json['product_e_name'] ?? json['ProductEName'] ?? '',
      productArName: json['product_ar_name'] ?? json['ProductArName'] ?? '',
      productImage: json['product_image'] ?? json['ProductImage'] ?? '',
      productSalePrice:
          (json['product_sale_price'] ?? json['ProductSalePrice'] ?? 0)
              .toDouble(),
      productRegularPrice:
          (json['product_regular_price'] ?? json['ProductRegularPrice'] ?? 0)
              .toDouble(),
      weight: (json['weight'] ?? json['Weight'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? json['Quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'product_id': productId,
    'product_e_name': productEName,
    'product_ar_name': productArName,
    'product_image': productImage,
    'product_sale_price': productSalePrice,
    'product_regular_price': productRegularPrice,
    'weight': weight,
    'quantity': quantity,
  };
}
