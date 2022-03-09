// Mocks generated by Mockito 5.1.0 from annotations
// in mvvm/test/user_list/view_mode_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:misc/model/user_overview.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mvvm/user_list/model.dart' as _i2;

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
  _i3.Future<Iterable<_i4.UserOverview>> getUserList([int? since]) =>
      (super.noSuchMethod(Invocation.method(#getUserList, [since]),
          returnValue: Future<Iterable<_i4.UserOverview>>.value(
              <_i4.UserOverview>[])) as _i3.Future<Iterable<_i4.UserOverview>>);
  @override
  _i3.Future<dynamic> fetchUserList([int? since]) =>
      (super.noSuchMethod(Invocation.method(#fetchUserList, [since]),
          returnValue: Future<dynamic>.value()) as _i3.Future<dynamic>);
  @override
  Iterable<_i4.UserOverview> convert(List<dynamic>? data) =>
      (super.noSuchMethod(Invocation.method(#convert, [data]),
          returnValue: <_i4.UserOverview>[]) as Iterable<_i4.UserOverview>);
  @override
  void destroy() => super.noSuchMethod(Invocation.method(#destroy, []),
      returnValueForMissingStub: null);
}
