import 'dart:async';

import 'package:bloc_pattern/mine/mine_cubit.dart';
import 'package:bloc_pattern/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'view_test.mocks.dart';

@GenerateMocks([MineCubit])
void main() {
  testWidgets(
    "view of mine",
    (tester) async {
      MockMineCubit mockCubit = MockMineCubit();
      ViewState.mockCubit = mockCubit;
      StreamController<MineState> streamController = StreamController();
      Stream<MineState> stream = streamController.stream;
      when(mockCubit.state).thenAnswer((realInvocation) => MineInitial());
      when(mockCubit.stream).thenAnswer((realInvocation) => stream);
      when(mockCubit.getMineDetail()).thenAnswer((realInvocation) async {});
      View view = const View();
      await tester.pumpWidget(MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: Material(
            child: view,
          ))));
      streamController.sink.add(MineDone(UserDetail(
          login: "test", name: "name", followers: 50, following: 100)));
      await tester.pumpAndSettle();
      expect(find.text("test"), findsOneWidget,
          reason: "should find Text with text 'test'.");
      expect(find.text("name"), findsOneWidget,
          reason: "should find Text with text 'name'.");
      expect(find.text("50"), findsOneWidget,
          reason: "should find Text with text '50'.");
      expect(find.text("100"), findsOneWidget,
          reason: "should find Text with text '100'.");
      streamController.sink.add(MineError(Exception()));
      await tester.pumpAndSettle();
      expect(find.byType(ErrorView), findsOneWidget,
          reason: "should find ErrorView.");
    },
  );
}
