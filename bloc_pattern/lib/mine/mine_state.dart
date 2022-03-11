part of 'mine_cubit.dart';

@immutable
abstract class MineState {}

class MineInitial extends MineState {}

class MineDone extends MineState {
  final UserDetail data;

  MineDone(this.data);
}

class MineError extends MineState {
  final Exception e;

  MineError(this.e);
}
