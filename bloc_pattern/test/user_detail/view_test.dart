import 'dart:async';

import 'package:bloc_pattern/user_detail/user_detail_cubit.dart';
import 'package:bloc_pattern/user_detail/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'view_test.mocks.dart';

@GenerateMocks([UserDetailCubit])
void main() {
  testWidgets(
    "User detail page",
    (tester) async {
      MockUserDetailCubit mockCubit = MockUserDetailCubit();
      ViewState.mockCubit = mockCubit;
      final user = UserOverview(
        login: "test",
      );
      StreamController<UserDetailState> streamController = StreamController();
      Stream<UserDetailState> stream = streamController.stream;
      when(mockCubit.state).thenAnswer((realInvocation) => UserDetailInitial());
      when(mockCubit.stream).thenAnswer((realInvocation) => stream);
      when(mockCubit.getUserDetail(user)).thenAnswer((realInvocation) async {});
      final view = View(
        data: user,
      );
      await tester.pumpWidget(MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: Material(
            child: view,
          ))));
      streamController.sink.add(UserDetailDone(UserDetail(
          login: "test",
          name: "name",
          location: "location",
          htmlUrl: "htmlUrl")));
      await tester.pumpAndSettle();
      expect(find.text("test"), findsOneWidget);
      expect(find.text("name"), findsOneWidget);
      expect(find.text("location"), findsOneWidget);
      expect(find.text("htmlUrl"), findsOneWidget);
      streamController.sink.add(UserDetailError(Exception()));
      await tester.pumpAndSettle();
      expect(find.byType(ErrorView), findsOneWidget);
      streamController.close();
    },
  );
}
