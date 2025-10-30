class ProductModel {
  final int? id;
  final String eName;
  final String? arName;
  final String? eDescription;
  final String? arDescription;
  final double salePrice;
  final double regularPrice;
  final double baseCost;
  final String image;
  final double weight;
  final int stock;
  final List<String> categories;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    this.id,
    required this.eName,
    this.arName,
    this.eDescription,
    this.arDescription,
    required this.salePrice,
    required this.regularPrice,
    required this.baseCost,
    required this.image,
    required this.weight,
    required this.stock,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['ID'] ?? 0,
      eName: json['EName'] ?? '',
      arName: json['ARName'],
      eDescription: json['EDescription'],
      arDescription: json['ARDescription'],
      salePrice: (json['SalePrice'] as num?)?.toDouble() ?? 0.0,
      regularPrice: (json['RegularPrice'] as num?)?.toDouble() ?? 0.0,
      baseCost: (json['BaseCost'] as num?)?.toDouble() ?? 0.0,
      image: json['Image'] ?? '',
      weight: (json['Weight'] as num?)?.toDouble() ?? 0.0,
      stock: (json['Stock']) ?? 0.0,
      categories:
          (json['Categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['CreatedAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['UpdatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EName': eName,
      'ARName': arName,
      'EDescription': eDescription,
      'ARDescription': arDescription,
      'SalePrice': salePrice,
      'RegularPrice': regularPrice,
      'BaseCost': baseCost,
      'Image': image,
      'Weight': weight,
      'stock': stock,
      'Categories': categories,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
    };
  }
}
