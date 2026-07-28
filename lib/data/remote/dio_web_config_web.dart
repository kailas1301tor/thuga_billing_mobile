// lib/data/remote/dio_web_config_web.dart
import 'package:dio/dio.dart';
import 'package:dio_web_adapter/dio_web_adapter.dart';

/// Stage backend returns valid CORS preflight headers; silence Dio's
/// per-request preflight warnings on web (they are informational only).
void configureWebAdapter(Dio dio) {
  dio.httpClientAdapter = BrowserHttpClientAdapter(
    enableCORSWarning: false,
  );
}
