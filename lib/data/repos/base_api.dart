import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseApi {
  BaseApi._();
  factory BaseApi() => BaseApi._()..init();
  static final _dio =
      Dio(BaseOptions(baseUrl: 'http://192.168.1.103:5000/api/v1'));
  Dio get dio => _dio;
  init() {
    _dio.interceptors.add(PrettyDioLogger());
  }
}
