import 'package:flutter/material.dart';

import '../cubit/boolean/boolean_cubit.dart';

mixin SignalApiView on State {
  bool init = false;
  final BooleanCubit loadingBloc = BooleanCubit();
  void done(covariant dynamic data) {
    hideLoading();
    setState(() {});
  }

  void error(Exception e) {
    hideLoading();
  }

  void showLoading() {
    loadingBloc.setTrue();
  }

  void hideLoading() {
    loadingBloc.setFalse();
  }
}
