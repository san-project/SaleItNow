import 'dart:developer' show log;
import 'package:dio/dio.dart';

import '../../utils/shared_prefs.dart';
import 'base_api.dart';

class AdminRepo {
  final api = BaseApi().dio;
  final token = SharedPrefs.instance().token;

  Future<Response> getDashboardDetails() async {
    try {
      return await api.get("/admin/dashboard",
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> getAllSellers() async {
    try {
      return await api.get("/seller",
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> approveSeller(String id) async {
    try {
      return await api.put("/seller/approve/$id",
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> getSellerDetails(String id) async {
    try {
      return await api.get(
        "/seller/$id",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
