import 'dart:developer';

List<ProductModel> getProductsFromJson(List json) =>
    json.map((e) => ProductModel.fromJson(e)).toList();

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.thumbnail,
    required this.price,
    required this.countInStock,
    required this.rating,
    required this.numReviews,
    required this.seller,
    required this.feature,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final List<Image> images;
  final Image thumbnail;
  final double price;
  final int countInStock;
  final int rating;
  final int numReviews;
  final String seller;
  final String feature;
  final List<dynamic> reviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    log("---------------------\n$json\n---------------------\n");
    return ProductModel(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      category: json["category"]['_id'],
      brand: json["brand"],
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      thumbnail: Image.fromJson(json["thumbnail"]),
      price: double.parse(json["price"].toString()),
      countInStock: json["countInStock"],
      rating: json["rating"],
      numReviews: json["numReviews"],
      seller: json["seller"]['_id'],
      feature: json["feature"],
      reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }
  @override
  String toString() => "Product id: $id name: $name";
}

class Image {
  Image({
    required this.url,
    required this.publicId,
  });

  final String url;
  final String publicId;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        publicId: json["publicId"],
      );
}
