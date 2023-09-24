import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_task_app/shared/utils/app_component.dart';
import 'package:my_task_app/shared/utils/logger.dart';

import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params, Map<String, String>? header}) async {
    var finalHeader = {
      'Content-Type': 'application/json',
    };
    if (header != null) {
      finalHeader.addAll(header);
    }
    AppComponentBase.instance.showProgressDialog();
    Logger.prints(path);
    Logger.prints(params);
    final response = await _client.get(
      getPath(path, params),
      headers: header,
    );
    AppComponentBase.instance.hideProgressDialog();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '?$key=$value';
      });
    }
    /*if (paramsString.startsWith('&')) {
      paramsString.replaceFirst('&', '?');
      Logger.prints('---$paramsString');
    }*/
    Logger.prints('---$paramsString');
    Logger.prints('====${Uri.parse('${ApiConstants.baseUrl}$path$paramsString')}');
    return Uri.parse('${ApiConstants.baseUrl}$path$paramsString');
  }
}
