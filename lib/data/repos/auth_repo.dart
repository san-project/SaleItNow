import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:saleitnow/data/repos/base_api.dart';

import '../models/seller_model.dart';

class AuthRepo {
  final api = BaseApi().dio;
  Future<Response> signIn(
      {required String email, required String password}) async {
    try {
      return await api.post(
        '/auth/seller/login',
        data: {"email": email, "password": password},
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> signUp(SellerModelForRegistering seller) async {
    try {
      log("sending message====================================================================================");
      // log(jsonEncode({"email": email, "password": password}));
      return await api.post(
        '/auth/seller/register',
        data: seller.toJson(),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
