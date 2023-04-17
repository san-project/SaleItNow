import 'dart:developer';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:saleitnow/data/models/order_model.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import '../data/repos/seller_repo.dart';

class SellerProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<OrderModel> _listOfOrders = [];
  List<OrderModel> get listOfOrders => _listOfOrders;

  Seller? _seller;
  Seller? get seller => _seller;
  getSellerDetails() async {
    _isLoading = true;
    notifyListeners();
    final response = await SellerRepo().getSellerDetails();
    _seller = Seller.fromJson(response.data['seller']);
    _isLoading = false;
    notifyListeners();
  }

  getAllOrders() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await SellerRepo().getAllOrders();
      _listOfOrders = (response.data['orders'] as List).map((e) {
        // log("======\n$e\n===========");
        final order = OrderModel.fromJson(e);
        log("======\n$order\n===========");
        return order;
      }).toList();
      log(_listOfOrders.toString());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
