import 'package:misc/model/user_overview.dart';
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

  Future<void> getUserDetail(UserOverview user) async {
    try {
      final data = await Model.instance.getUserDetail(user);
      _view?.done(data);
    } on Exception catch (e) {
      _view?.error(e);
    }
  }
}
