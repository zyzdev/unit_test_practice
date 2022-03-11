part of 'user_list_cubit.dart';

@immutable
abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListDone extends UserListState {
  final Iterable<UserOverview> data;

  UserListDone(this.data);
}

class UserListError extends UserListState {
  final Exception e;

  UserListError(this.e);
}
