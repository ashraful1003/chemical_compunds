import 'dart:convert';

import 'package:chemical_compounds/flavors/configure/build_config.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// code copied from https://pub.dev/packages/pretty_dio_logger
class PrettyDioLogger extends Interceptor {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.tribeCollectionData]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to logPrint json response
  static const int initialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per logPrint
  final int maxWidth;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  void Function(Object object) logPrint;

  static const int defaultMaxWidth = 90;

  final Logger logger = BuildConfig.instance.config.logger;

  final Logger _prettyLogger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(
      methodCount: 0,
      // Number of method calls to be displayed
      errorMethodCount: 8,
      // Number of method calls if stacktrace is provided
      lineLength: 120,
      // Width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      dateTimeFormat:
          DateTimeFormat.none, // Should each log print contain a timestamp
    ), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  PrettyDioLogger({
    this.request = true,
    this.requestHeader = false,
    this.requestBody = false,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.maxWidth = defaultMaxWidth,
    this.compact = true,
    this.logPrint = print,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(
      options.method,
      options.uri,
      data: options.data,
      headers: options.headers,
    );
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      _logError(err);
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    super.onResponse(response, handler);
  }

  void _logRequest(
    String method,
    Uri url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) {
    _prettyLogger.i('Dio ║ Sending $method request to $url');
    if (headers != null && headers.isNotEmpty) {
      String formattedHeaders = const JsonEncoder.withIndent(
        ' ',
      ).convert(headers);
      _prettyLogger.t('Dio ║ Request Headers: $formattedHeaders');
    }
    if (data != null && data.isNotEmpty) {
      _prettyLogger.t('Dio ║ Request Data: $data');
      logger.i(data);
    }
  }

  void _logResponse(Response response) {
    String formattedJsonStr = const JsonEncoder.withIndent(
      '  ',
    ).convert(response.data);
    _prettyLogger.i(
      'Dio ║ Received response - Status code: ${response.statusCode}, Body: $formattedJsonStr',
    );
    String formattedHeaders = const JsonEncoder.withIndent(
      ' ',
    ).convert(response.headers.toString());
    _prettyLogger.t('Dio ║ Response Headers: $formattedHeaders');
  }

  void _logError(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      _prettyLogger.e(
        'Dio ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
      );
      if (err.response != null && err.response?.data != null) {
        _prettyLogger.e(err.response!);
      }
    } else {
      _prettyLogger.e('Dio ║ ${err.type}  ${err.message}');
    }
  }
}
