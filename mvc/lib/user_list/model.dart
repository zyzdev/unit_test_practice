import 'package:flutter/cupertino.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/ui/signal_api_view.dart';
import 'package:misc/util/dio_util.dart';

class Model {
  static Model get instance => _instance ??= Model();
  static Model? _instance;

  @visibleForTesting
  static void setModel(Model model) {
    _instance = model;
  }

  void getUserList(SignalApiView state, [int? since]) async {
    fetchUserList(since).then((value) {
      Iterable<UserOverview> res = convert(value);
      state.done(res);
    }).catchError((e) {
      state.error(e);
    });
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
