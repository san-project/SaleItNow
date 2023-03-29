import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import 'package:saleitnow/data/repos/auth_repo.dart';
import 'package:saleitnow/utils/shared_prefs.dart';
import 'package:saleitnow/utils/snack_bar.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final _prefs = SharedPrefs.instance();
  signIn(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await AuthRepo().signIn(email: email, password: password);
      _isLoading = false;
      notifyListeners();
      final data = response.data;
      log(data['token']);
      _prefs.setToken(data['token']);

      if (response.data['isApproved']) {
        log("Approved");
      }
    } on DioError catch (e) {
      log(e.response.toString());
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<bool> logOut() async => _prefs.clear();

  signUp(SellerModelForRegistering seller, BuildContext context) async {
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
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
