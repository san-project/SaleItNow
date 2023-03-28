import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import 'package:saleitnow/data/repos/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await AuthRepo().signIn(email: email, password: password);
      _isLoading = true;
      notifyListeners();
      if (response.data['isApproved']) {
        log("Approved");
      }
    } on DioError catch (e) {
      log(e.response.toString());
      _isLoading = true;
      notifyListeners();
    }
  }

  signUp(SellerModelForRegistering seller) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await AuthRepo().signUp(seller);
      if (response.data['status'] == true) {
        log("success");
      }
      if (response.data['isApproved']) {
        log("Approved");
      }
    } on DioError catch (e) {
      log(e.response.toString());
    }
  }
}
