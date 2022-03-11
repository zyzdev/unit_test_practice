part of 'user_detail_cubit.dart';

@immutable
abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailDone extends UserDetailState {
  final UserDetail data;

  UserDetailDone(this.data);
}

class UserDetailError extends UserDetailState {
  final Exception e;

  UserDetailError(this.e);
}
