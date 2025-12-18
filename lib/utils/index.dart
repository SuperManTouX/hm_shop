import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final Dio _dio = Dio();
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BSAE_URL
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptors();
  }

  _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onError: (error, handler) {
          handler.reject(error);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
          } else {
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? paramas}) {
    return HandleRespones(_dio.get(url, queryParameters: paramas));
  }

  // 处理请求体，将真实数据结构出来
  Future<dynamic> HandleRespones(Future<Response<dynamic>> task) async {
    Response<dynamic> result = await task;
    final data = result.data as Map<String, dynamic>;
    if (data["code"] == GlobalConstants.SUCCESS_CODE) {
      return data["result"];
    }
    throw Exception(data["msg"] ?? "请求错误");
  }
}
