import 'package:flutter/cupertino.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/util/dio_util.dart';

class Model {
  static Model get instance => _instance ??= Model();
  static Model? _instance;

  @visibleForTesting
  static void setModel(Model model) {
    _instance = model;
  }

  Future<UserDetail> getMineDetail() async =>
      UserDetail.fromJson(await fetchMineDetail());

  Future<dynamic> fetchMineDetail() {
    String tmp =
        "LDF8y3sWUhSA3aI1tMyAFLr38jWqw2HTrWHX_phg,Or7wOKfFQZTSmBL5L2oKpN2qxEQur2230izu"
            .split(",")[0];
    String token = tmp.split('').reversed.join();
    return DioUtil.instance
        .get(Api.user, header: {"Authorization": "token $token"});
  }

  void destroy() {
    _instance = null;
  }
}
