import 'package:misc/ui/signal_api_view.dart';

import 'model.dart';

class Presenter {
  SignalApiView? _view;

  Presenter({SignalApiView? view}) {
    if (view != null) _view = view;
  }

  void setView(SignalApiView view) {
    _view = _view;
  }

  Future<void> getUserList([int? since]) async {
    try {
      final data = await Model.instance.getUserList(since);
      _view?.done(data);
    } on Exception catch (e) {
      _view?.error(e);
    }
  }
}
