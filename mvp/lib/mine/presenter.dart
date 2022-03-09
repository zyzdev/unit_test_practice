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

  Future<void> getMineDetail() async {
    try {
      final data = await Model.instance.getMineDetail();
      _view?.done(data);
    } on Exception catch (e) {
      _view?.error(e);
    }
  }
}
