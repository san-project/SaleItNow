import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saleitnow/data/models/category_model.dart';
import 'package:saleitnow/data/models/product_model.dart';
import 'package:saleitnow/data/models/get_product_model.dart' as prd;
import '../utils/pick_images.dart';
import '../utils/snack_bar.dart';
import '../data/repos/product_repo.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  CategoryModel? _selectedCategory;
  CategoryModel? get selectedCategory => _selectedCategory;
  File? _thumbnail;
  File? get thumbnail => _thumbnail;
  final List<File> _pickedImages = [];
  List<File> get pickedImages => _pickedImages;
  List<prd.ProductModel> _listOfProducts = [];
  List<prd.ProductModel> get listOfProducts => _listOfProducts;

  void changeCategory(CategoryModel? categoryModel) {
    _selectedCategory = categoryModel;
    notifyListeners();
  }

  clearImages() {
    _pickedImages.clear();
    _thumbnail = null;
    log("images cleared");
    // notifyListeners();
  }

  Future<void> pickMultipleImages() async {
    final images = await pickImages();
    _pickedImages.addAll(images);
    notifyListeners();
  }

  Future<void> getAllCategoryFromRepo(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await ProductRepo().getAllCategories();
      final data = response.data as Iterable;
      _categoryList = data.map((e) => CategoryModel.fromJson(e)).toList();
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> pickThumbnail() async {
    _thumbnail = await pickSingleImage();
    notifyListeners();
  }

  Future<void> uploadProducts(
      {required String name,
      required String description,
      required double price,
      required String brand,
      required int stock,
      required BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      final product = ProductModel(
          name: name,
          description: description,
          category: _selectedCategory!.id,
          brand: brand,
          images: _pickedImages,
          thumbnail: _thumbnail!,
          price: price,
          countInStock: stock);
      log(product.toString());
      await ProductRepo().uploadProduct(product);
      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> getAllProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ProductRepo().getAllProducts();
      final listOfProducts = response.data['products'] as List;
      _listOfProducts = prd.getProductsFromJson(listOfProducts);
      _isLoading = false;
      notifyListeners();
      log("listofproducts $_listOfProducts");
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }

  Future<void> uploadCategory(BuildContext context, String name) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ProductRepo().uploadCategoty(name);
      _isLoading = true;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      dioError(context, e);
    }
  }
}
