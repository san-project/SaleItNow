import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import 'package:saleitnow/data/repos/admin_repo.dart';

import '../utils/snack_bar.dart';

class AdminProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Seller> _sellers = [];
  List<Seller> get sellers => _sellers;
  List<Seller> _approvedSellers = [];
  List<Seller> get apprvedSellers => _approvedSellers;
  List<Seller> _notApprovedSellers = [];
  List<Seller> get notApprvedSellers => _notApprovedSellers;
  Seller? _currentSeller;
  Seller? get currentSeller => _currentSeller;
  Map<String, dynamic> _dashboardDetails = {};
  Map<String, dynamic> get dashboardDetails => _dashboardDetails;
  getAllSellers(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await AdminRepo().getAllSellers();
      final List data = response.data;
      _sellers = data.map((e) => Seller.fromJson(e)).toList();
      _approvedSellers =
          _sellers.where((element) => element.isApproved == true).toList();
      _notApprovedSellers =
          _sellers.where((element) => element.isApproved == false).toList();
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
      return null;
    }
  }

  Future getSellerDetails(String id) async {
    _isLoading = true;
    notifyListeners();
    final response = await AdminRepo().getSellerDetails(id);
    _currentSeller = Seller.fromJson(response.data);
    _isLoading = false;
    notifyListeners();
  }

  approveSeller(String id) async {
    _isLoading = true;
    notifyListeners();
    await Future.wait([AdminRepo().approveSeller(id), getSellerDetails(id)]);
    _isLoading = false;
    notifyListeners();
  }

  getDashboardDetails() async {
    _isLoading = true;
    notifyListeners();
    final response = await AdminRepo().getDashboardDetails();
    _dashboardDetails = response.data;
    _isLoading = false;
    notifyListeners();
  }
}
