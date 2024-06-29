import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_prefs_cookie_store/shared_prefs_cookie_store.dart';
import 'url.constant.dart';

class DioService {
  late Dio _dio;
  final CookieJar _cookieJar = CookieJar();
  final SharedPrefCookieStore _cookieStore = SharedPrefCookieStore();

  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    initializeDio();
  }

  void initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: URL.BASE_URL,
        contentType: Headers.formUrlEncodedContentType,
        validateStatus: (_) => true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    _dio.interceptors.add(CookieManager(_cookieStore));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          return handler.next(options); // continue
        },
        onError: (DioException e, handler) {
          // Do something on error
          return handler.next(e); // continue
        },
        // ...
      ),
    );
  }

  void clearCokies() {
    _cookieStore.deleteAll();
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return _dio.get(url, queryParameters: params);
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    return _dio.post(url, data: data);
  }

  // Add other methods like put, delete, etc. as needed
}
