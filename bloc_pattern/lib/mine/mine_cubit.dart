import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:misc/model/user_detail.dart';

import 'model.dart';

part 'mine_state.dart';

class MineCubit extends Cubit<MineState> {
  MineCubit() : super(MineInitial());

  void getMineDetail() => Model.instance
      .getMineDetail()
      .then((data) => emit(MineDone(data)))
      .catchError((e) => emit(MineError(e)));
}
