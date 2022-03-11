import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/util/dio_util.dart';

class Model {
  static Model get instance => _instance ??= Model();
  static Model? _instance;

  @visibleForTesting
  static void setModel(Model model) {
    _instance = model;
  }

  Future<Iterable<UserOverview>> getUserList([int? since]) async {
    Completer<Iterable<UserOverview>> data = Completer();
    fetchUserList(since).then((value) {
      Iterable<UserOverview> res = convert(value);
      data.complete(res);
    }).catchError((e) {
      data.completeError(e);
    });
    return data.future;
  }

  @visibleForTesting
  Future fetchUserList([int? since]) => DioUtil.instance.get(Api.users,
      param: since != null ? {"since": since.toString()} : null);

  @visibleForTesting
  Iterable<UserOverview> convert(List data) sync* {
    for (var element in data) {
      yield UserOverview.fromJson(element);
    }
  }

  void destroy() {
    _instance = null;
  }
}
