import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import 'package:saleitnow/data/repos/auth_repo.dart';
import 'package:saleitnow/utils/dialogs.dart';
import 'package:saleitnow/utils/shared_prefs.dart';
import 'package:saleitnow/utils/snack_bar.dart';

import '../utils/enums.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final _prefs = SharedPrefs.instance();

  //sign in
  Future<UserType?> signIn(
      String email, String password, BuildContext context) async {
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

      if (response.data['isAdmin']) {
        _prefs.setAdmin(true);
        return UserType.admin;
      }
      _prefs.setAdmin(false);
      _prefs.setSellerId(data['id']);
      if (response.data['isApproved']) {
        return UserType.approvedSeller;
      } else {
        return UserType.notApprovedSeller;
      }
    } on DioError catch (e) {
      log(e.response.toString());

      _isLoading = false;
      notifyListeners();
      if (e.response?.statusCode == 403) {
        showNotVerifiedDialog(context);
        return null;
      }
      dioError(context, e);
      return null;
    }
  }

  Future<bool> logOut() async => _prefs.clear();

  signUp(SellerModelForRegistering seller, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await AuthRepo().signUp(seller);
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Yay!'),
            content: Text(
                'You have successfully Registered, Please wait Until we verify you'),
          ),
        );
      }
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
