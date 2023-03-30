import 'dart:io';

import 'package:dio/dio.dart';

class ProductModel {
  ProductModel({
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.thumbnail,
    required this.price,
    required this.countInStock,
  });

  final String name;
  final String description;
  final String category;
  final String brand;
  final List<File> images;
  final File thumbnail;
  final double price;
  final int countInStock;

  // factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
  //     name: json["name"],
  //     description: json["description"],
  //     category: json["category"],
  //     brand: json["brand"],
  //     images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  //     price: json["price"],
  //     countInStock: json["countInStock"],
  //     rating: json["rating"],
  //     numReviews: json["numReviews"],
  //     seller: json["seller"],
  //     feature: json["feature"],
  //     id: json["_id"],
  //     reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
  //     createdAt: DateTime.parse(json["createdAt"]),
  //     updatedAt: DateTime.parse(json["updatedAt"]),
  //     v: json["__v"],
  // );
  Future<FormData> toJson() async {
    List<MultipartFile> files = [];
    for (var element in images) {
      String fileName = element.path.split('/').last;
      files.add(await MultipartFile.fromFile(element.path, filename: fileName));
    }
    String fileName = thumbnail.path.split('/').last;
    final thumbnailFile =
        await MultipartFile.fromFile(thumbnail.path, filename: fileName);
    return FormData.fromMap({
      "name": name,
      "description": description,
      "categoryId": category,
      "brand": brand,
      "images": files,
      "price": price,
      "countInStock": countInStock,
      "thumbnail": thumbnailFile
    });

    //  {
    // "name": name,
    // "description": description,
    // "category": category,
    // "brand": brand,
    // "images": files,
    // "price": price,
    // "countInStock": countInStock,
    // "thumbnail": thumbnailFile
    // };
  }

  @override
  String toString() => toJson().toString();
}
