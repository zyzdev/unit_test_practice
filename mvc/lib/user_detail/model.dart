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

  void getUserDetail(SignalApiView state, UserOverview data) async {
    fetchUserDetail(data.login!)
        .then((value) => state.done(UserDetail.fromJson(value)))
        .catchError((e) {
      state.error(e);
    });
  }

  void destroy() {
    _instance = null;
  }
}
