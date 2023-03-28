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
