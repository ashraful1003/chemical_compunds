import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((Map<String, String>? customHeaders) {
      if (customHeaders == null) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: PlatformException(code: 'token_failed'),
            type: DioExceptionType.unknown,
          ),
        );
      }
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>?> getCustomHeaders() async {
    Map<String, String> customHeaders = <String, String>{
      'content-type': 'application/json',
    };

    return customHeaders;
  }
}
