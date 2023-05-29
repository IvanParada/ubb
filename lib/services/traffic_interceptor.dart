import 'package:dio/dio.dart';

const accesToken =
    'pk.eyJ1IjoiaXZhbnBhcmFkYTIxIiwiYSI6ImNsaTgwbTFqcDA2eXUzZW81bGp2N2lxZWEifQ.P-6C67f8gsetOT0zVIrRbQ';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'continue_straight': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accesToken
    });

    super.onRequest(options, handler);
  }
}
