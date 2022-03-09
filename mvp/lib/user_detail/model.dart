import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:misc/misc.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/util/dio_util.dart';

class Model {
  static Model get instance => _instance ??= Model();
  static Model? _instance;

  @visibleForTesting
  static void setModel(Model model) {
    _instance = model;
  }

  Future<dynamic> fetchUserDetail(String login) =>
      DioUtil.instance.get(Api.users, path: login);

  Future<UserDetail> getUserDetail(UserOverview user) async {
    Completer<UserDetail> data = Completer();
    fetchUserDetail(user.login!)
        .then((value) => data.complete(UserDetail.fromJson(value)))
        .catchError((e) => data.completeError(e));
    return data.future;
  }

  void destroy() {
    _instance = null;
  }
}
