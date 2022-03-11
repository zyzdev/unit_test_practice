import 'dart:async';

import 'package:misc/model/user_detail.dart';

import 'model.dart';

class ViewModel {
  final _controller = StreamController<UserDetail>();
  StreamSink<UserDetail> get _dataSink => _controller.sink;
  Stream<UserDetail> get stream => _controller.stream.asBroadcastStream();

  Future<void> getMineDetail() async {
    try {
      final data = await Model.instance.getMineDetail();
      _dataSink.add(data);
    } on Exception catch (e) {
      _dataSink.addError(e);
    }
  }

  void destroy() {
    _controller.close();
  }
}
