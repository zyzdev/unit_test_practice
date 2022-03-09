import 'package:misc/misc.dart';
import 'package:mvc/user_detail/model.dart';

class Control {
  static void getUserDetail(SignalApiView state, UserOverview data) =>
      Model.instance.getUserDetail(state, data);

  static void destroy() {
    Model.instance.destroy();
  }
}
