import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'misc.dart';

class DioUtil {
  static DioUtil get instance => _instance ??= DioUtil();
  static DioUtil? _instance;

  @visibleForTesting
  static void setDioUtil(DioUtil dioUtil) {
    _instance = dioUtil;
  }

  Future<dynamic> get(Api api,
      {String? path,
      Map<String, String>? param,
      Map<String, String>? header}) async {
    String url = "$baseUrl/${api.name}${path != null ? "/$path" : ""}";
    if (isMapNotEmpty(param)) {
      String params = "";
      param!.forEach((key, value) {
        params += "$key=$value&";
      });
      url += "?${params.substring(0, params.length - 1)}";
    }
    Options? opts;
    if (header != null) {
      opts = Options(headers: header);
    }
    debugPrint(url);
    Response response = await getDio().get(url, options: opts);
    print(response.data);
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Api:${api.name} get statusCode:$statusCode");
    }
  }
}

const String baseUrl = "https://api.github.com";

Dio get instance => _instance ??= Dio();
Dio? _instance;

Dio getDio() => instance;

@visibleForTesting
void setDio(Dio dio) {
  _instance = dio;
}

enum Api { user, users }
