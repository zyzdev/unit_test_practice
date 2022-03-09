import 'package:misc/misc.dart';
import 'package:mvc/mine/model.dart';

class Control {
  static void getMineDetail(SignalApiView state) =>
      Model.instance.getMineDetail(state);

  static void destroy() {
    Model.instance.destroy();
  }
}
