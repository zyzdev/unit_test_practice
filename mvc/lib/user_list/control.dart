import 'package:misc/ui/signal_api_view.dart';
import 'package:mvc/user_list/model.dart';

class Control {
  static void getUserList(SignalApiView state, [int? since]) =>
      Model.instance.getUserList(state, since);

  static void destroy() {
    Model.instance.destroy();
  }
}
