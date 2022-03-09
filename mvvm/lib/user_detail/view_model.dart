import 'dart:async';

import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';

import 'model.dart';

class ViewModel {
  final _controller = StreamController<UserDetail>();
  StreamSink<UserDetail> get _dataSink => _controller.sink;
  Stream<UserDetail> get stream => _controller.stream.asBroadcastStream();

  Future<void> getUserDetail(UserOverview user) async {
    try {
      final data = await Model.instance.getUserDetail(user);
      _dataSink.add(data);
    } on Exception catch (e) {
      _dataSink.addError(e);
    }
  }

  void destroy() {
    _controller.close();
  }
}
