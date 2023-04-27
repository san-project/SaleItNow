// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  final int allOrders;
  final int deliveredOrders;
  final int notProcessedOrders;
  final int cancelledOrders;
  final int allProducts;
  final ProductsMap productsMap;

  Dashboard({
    required this.allOrders,
    required this.deliveredOrders,
    required this.notProcessedOrders,
    required this.cancelledOrders,
    required this.allProducts,
    required this.productsMap,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        allOrders: json["allOrders"],
        deliveredOrders: json["deliveredOrders"],
        notProcessedOrders: json["notProcessedOrders"],
        cancelledOrders: json["cancelledOrders"],
        allProducts: json["allProducts"],
        productsMap: ProductsMap.fromJson(json["productsMap"]),
      );

  Map<String, dynamic> toJson() => {
        "allOrders": allOrders,
        "deliveredOrders": deliveredOrders,
        "notProcessedOrders": notProcessedOrders,
        "cancelledOrders": cancelledOrders,
        "allProducts": allProducts,
        "productsMap": productsMap.toJson(),
      };
}

class ProductsMap {
  final int clothing;
  final int electronics;
  final int home;
  final int appliances;
  final int healthAndBeauty;

  ProductsMap({
    required this.clothing,
    required this.electronics,
    required this.home,
    required this.appliances,
    required this.healthAndBeauty,
  });

  factory ProductsMap.fromJson(Map<String, dynamic> json) => ProductsMap(
        clothing: json["Clothing"],
        electronics: json["Electronics"],
        home: json["Home"],
        appliances: json["Appliances"],
        healthAndBeauty: json["Health and Beauty"],
      );

  Map<String, dynamic> toJson() => {
        "Clothing": clothing,
        "Electronics": electronics,
        "Home": home,
        "Appliances": appliances,
        "Health and Beauty": healthAndBeauty,
      };
}
