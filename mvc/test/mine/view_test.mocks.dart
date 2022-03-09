// Mocks generated by Mockito 5.1.0 from annotations
// in mvc/test/mine/view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:misc/ui/signal_api_view.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mvc/mine/model.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [Model].
///
/// See the documentation for Mockito's code generation for more information.
class MockModel extends _i1.Mock implements _i2.Model {
  MockModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void getMineDetail(_i3.SignalApiView? state) =>
      super.noSuchMethod(Invocation.method(#getMineDetail, [state]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<dynamic> fetchMineDetail() =>
      (super.noSuchMethod(Invocation.method(#fetchMineDetail, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  void destroy() => super.noSuchMethod(Invocation.method(#destroy, []),
      returnValueForMissingStub: null);
}
