import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';

import 'model.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit() : super(UserDetailInitial());

  void getUserDetail(UserOverview user) => Model.instance
      .getUserDetail(user)
      .then((data) => emit(UserDetailDone(data)))
      .catchError((error) => emit(UserDetailError(error)));
}
