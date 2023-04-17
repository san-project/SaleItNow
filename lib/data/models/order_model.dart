import 'dart:developer';

import 'package:saleitnow/data/models/get_product_model.dart';

// enum OrderStatus {
//   NotProcess, Processing, Shipped, Delivered, Cancel,
// }

class OrderProduct {
  final ProductModel product;
  final int quantity;

  OrderProduct(this.product, this.quantity);

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      OrderProduct(ProductModel.fromJson(json['product']), json['quantity']);
}

class OrderModel {
  final String id;
  final List<OrderProduct> product;
  // final User buyer;
  // final String status;
  // final String deliveryAddress;
  // final DateTime orderDate;
  // final double totalPrice;

  OrderModel({
    required this.id,
    required this.product,
    // required this.buyer,
    // required this.status,
    // required this.orderDate,
    // required this.deliveryAddress,
    // required this.totalPrice,
  });

  @override
  toString() => "id: $id";

  factory OrderModel.fromJson(dynamic json) => OrderModel(
        id: json['_id'],
        product: (json['products'] as List).map((e) {
          log("==============================\n${e['product']}\n===============================");
          return OrderProduct.fromJson(e);
        }).toList(),
        // buyer: json['buyer'],
        // status: json['status'],
        // orderDate: DateTime.parse(json['createdAt']),
        // deliveryAddress: json['deliveryAddress'],
        // totalPrice: double.parse(json['totalPrice']),
      );
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}
