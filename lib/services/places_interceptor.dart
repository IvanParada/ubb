import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accesToken =
      'pk.eyJ1IjoiaXZhbnBhcmFkYTIxIiwiYSI6ImNsaTgwbTFqcDA2eXUzZW81bGp2N2lxZWEifQ.P-6C67f8gsetOT0zVIrRbQ';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': accesToken,
      'language': 'es',
      'limit': '5',
    });
    super.onRequest(options, handler);
  }
}
