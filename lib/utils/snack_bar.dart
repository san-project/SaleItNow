import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

dioError(BuildContext context, DioError error) {
  final snackdemo = SnackBar(
    content: Text(error.response?.data['message'] ?? error.message),
    backgroundColor: Colors.red.withOpacity(0.5),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
}
