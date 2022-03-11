import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:misc/model/user_overview.dart';

import 'model.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(UserListInitial());

  void getUserList([int? since]) => Model.instance
      .getUserList(since)
      .then((value) => emit(UserListDone(value)))
      .catchError((error) => emit(UserListError(error)));
}
