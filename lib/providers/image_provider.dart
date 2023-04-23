import 'package:flutter/material.dart';
import 'package:saleitnow/data/repos/image_repo.dart';

class ProductImageProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> deleteImage(String publicId, String productId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ImageRepo().deleteImage(publicId, productId);
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
