class UserModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? picture;
  final String? provider;
  final Address address;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.picture,
    this.provider,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["Name"], // From JSON: "Name"
      phone: json["Phone"], // From JSON: "Phone"
      email: json["Email"], // From JSON: "Email"
      picture: json["Picture"], // From JSON: "Picture"
      provider: json["Provider"], // From JSON: "Provider"
      address: Address.fromJson(json["Address"]), // Corrected
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Name": name,
      "Phone": phone,
      "Email": email,
      "Picture": picture,
      "Provider": provider,
      "Address": address.toJson(),
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json["Street"] ?? "",
      city: json["City"] ?? "",
      state: json["State"] ?? "",
      postalCode: json["PostalCode"] ?? "",
      country: json["Country"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Street": street,
      "City": city,
      "State": state,
      "PostalCode": postalCode,
      "Country": country,
    };
  }
}
