import 'dart:async';

import 'package:misc/misc.dart';
import 'package:mvvm/user_list/model.dart';

class ViewModel {
  final _controller = StreamController<Iterable<UserOverview>>();
  final _data = List<UserOverview>.empty(growable: true);
  StreamSink<Iterable<UserOverview>> get _dataSink => _controller.sink;
  Stream<Iterable<UserOverview>> get stream =>
      _controller.stream.asBroadcastStream();

  Future<void> getUserList([int? since]) async {
    try {
      final data = await Model.instance.getUserList(since);
      _data.addAll(data);
      _dataSink.add(_data);
    } on Exception catch (e) {
      _dataSink.addError(e);
    }
  }

  void destroy() {
    _controller.close();
  }
}
