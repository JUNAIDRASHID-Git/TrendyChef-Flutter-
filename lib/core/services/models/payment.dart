class PaymentModel {
  final String cartid;
  final double amount;
  final String currency;
  final String description;
  final String name;
  final String email;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String region;
  final String country;
  final String postcode;

  PaymentModel({
    required this.cartid,
    required this.amount,
    required this.currency,
    required this.description,
    required this.name,
    required this.email,
    required this.phone,
    required this.addressLine1,
    this.addressLine2 = "Building 4",
    required this.city,
    required this.region,
    this.country = "SA",
    required this.postcode,
  });

  Map<String, dynamic> toJson() {
    return {
      "cartid": cartid,
      "amount": amount.toStringAsFixed(2),
      "currency": currency,
      "description": description,
      "name": name,
      "email": email,
      "phone": phone,
      "address_line1": addressLine1,
      "address_line2": addressLine2,
      "city": city,
      "region": region,
      "country": country,
      "postcode": postcode,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      cartid: json["cartid"] ?? "",
      amount: double.tryParse(json["amount"].toString()) ?? 0.0,
      currency: json["currency"] ?? "SAR",
      description: json["description"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      addressLine1: json["address_line1"] ?? "",
      addressLine2: json["address_line2"] ?? "Building 4",
      city: json["city"] ?? "",
      region: json["region"] ?? "",
      country: json["country"] ?? "SA",
      postcode: json["postcode"] ?? "",
    );
  }
}
