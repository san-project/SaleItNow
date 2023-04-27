import 'dart:developer';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:saleitnow/data/models/dashboard_model.dart';
import 'package:saleitnow/data/models/order_model.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import '../data/repos/seller_repo.dart';

class SellerProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Order? _currentOrder;
  Order? get currentOrder => _currentOrder;
  Dashboard? _dashboard;
  Dashboard? get dashboard => _dashboard;
  List<Order> _listOfOrders = [];
  List<Order> get listOfOrders => _listOfOrders;

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

  Future<void> getAllOrders() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await SellerRepo().getAllOrders();
      _listOfOrders = (response.data['orders'] as List)
          .map((e) => Order.fromJson(e))
          .toList();
      log(_listOfOrders.length.toString());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  updateOrderById(String id, String orderStatus) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await SellerRepo().updateOrderById(id, orderStatus);
      _currentOrder = Order.fromJson(response.data['updatedOrder']);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  getOrderById(
    String id,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await SellerRepo().getOrderById(id);
      _isLoading = false;
      _currentOrder = Order.fromJson(response.data['order']);
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  getDashboardDetails() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await SellerRepo().getDashboardDetails();
      _dashboard = Dashboard.fromJson(response.data);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
