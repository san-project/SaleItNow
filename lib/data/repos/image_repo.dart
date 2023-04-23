import 'package:dio/dio.dart';

import '../../utils/shared_prefs.dart';
import 'base_api.dart';

class ImageRepo {
  final api = BaseApi().dio;
  final token = SharedPrefs.instance().token;
  Future<Response> deleteImage(String publicId, String productId) async {
    try {
      return await api.delete(
        '/product/image',
        data: {"imageId": publicId, "pid": productId},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
