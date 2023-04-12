import 'package:flutter/material.dart';

@immutable
class SellerModelForRegistering {
  final String email;
  final String password;
  final String name;
  final String businessName;
  final String address;
  final String gstNo;
  final String mobile;

  const SellerModelForRegistering({
    required this.email,
    required this.password,
    required this.name,
    required this.businessName,
    required this.address,
    required this.gstNo,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "businessName": businessName,
        "mobile": mobile,
        "email": email,
        "address": address,
        "gstNo": gstNo,
      };
}

class Seller {
  Seller({
    required this.id,
    required this.name,
    required this.businessName,
    required this.mobile,
    required this.email,
    required this.gstNo,
    required this.password,
    required this.address,
    required this.isApproved,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String businessName;
  final String mobile;
  final String email;
  final String gstNo;
  final String password;
  final String address;
  final bool isApproved;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["_id"],
        name: json["name"],
        businessName: json["businessName"],
        mobile: json["mobile"],
        email: json["email"],
        gstNo: json["gstNo"],
        password: json["password"],
        address: json["address"],
        isApproved: json["isApproved"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
