// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerModel {
  int id;
  String imageUrl;
  String url;
  BannerModel({required this.id, required this.imageUrl, required this.url});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['ID'],
      imageUrl: json['ImageURL'],
      url: json['URL'] ?? "",
    );
  }
}
