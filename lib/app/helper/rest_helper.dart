import 'dart:convert';

import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:cc_template_dev/service/connectivity_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RestConstants {
  RestConstants._privateConstructor();

  static final RestConstants instance = RestConstants._privateConstructor();

  //     ======================= API baseurl =======================     //
  final String baseUrl = '';

  //     ======================= API EndPoints =======================     //
}

class RestServices {
  RestServices._privateConstructor();

  static final RestServices instance = RestServices._privateConstructor();

  Map<String, String> headers = {'Content-Type': 'application/json'};

  void showRequestAndResponseLogs(http.Response? response, Map<String, Object> requestData) {
    '•••••••••• Network logs ••••••••••\nRequest code --> ${response?.statusCode} : ${response?.request?.url}\nRequest headers --> $requestData\nResponse headers --> ${response?.headers}\nResponse body --> ${response?.body}\n••••••••••••••••••••••••••••••••••'
        .infoLogs();
  }

  Future<String?>? getRestCall({required String? endpoint, String? addOns, bool addToken = true}) async {
    String? responseData;
    final bool connected = await ConnectivityService.instance.checkConnection();
    if (!connected) {
      return responseData;
    }
    try {
      final String requestUrl = addOns != null
          ? '${RestConstants.instance.baseUrl}/$endpoint$addOns'
          : '${RestConstants.instance.baseUrl}/$endpoint';

      final Uri? requestedUri = Uri.tryParse(requestUrl);

      final Response response = await http.get(requestedUri!, headers: headers);
      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 201:
        case 400:
          responseData = response.body;
        case 403:
        case 401:
          throw UnauthorizedException();
        case 422:
        case 404:
        case 500:
        case 502:
        case 503:
          '${response.statusCode}'.warningLogs();
        default:
          '${response.statusCode} : ${response.body}'.warningLogs();
      }
    } on PlatformException catch (e) {
      'PlatformException in getRestCall --> ${e.message}'.errorLogs();
    }
    return responseData;
  }

  Future<String?>? postRestCall({required String? endpoint, Map<String, dynamic>? body, String? addOns}) async {
    String? responseData;
    final bool connected = await ConnectivityService.instance.checkConnection();
    if (!connected) {
      return responseData;
    }
    try {
      final String requestUrl = addOns != null
          ? '${RestConstants.instance.baseUrl}/$endpoint$addOns'
          : '${RestConstants.instance.baseUrl}/$endpoint';
      final Uri? requestedUri = Uri.tryParse(requestUrl);

      headers['Content-Type'] = 'application/json';

      final Response response = await http.post(requestedUri!, headers: headers, body: jsonEncode(body));
      'response --> ${response.body}'.infoLogs();

      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 500:
        case 201:
        case 404:
          responseData = response.body;
        case 403:
          throw UnauthorizedException();
        case 401:
        case 422:
        case 400:
        case 502:
        case 503:
          '${response.statusCode}'.warningLogs();
        default:
          'Response --> ${response.statusCode} : ${response.body}'.warningLogs();
      }
    } on PlatformException catch (e) {
      'PlatformException in postRestCall --> ${e.message}'.errorLogs();
    }
    return responseData;
  }
}
