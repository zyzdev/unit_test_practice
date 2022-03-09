import 'package:bloc/bloc.dart';

class BooleanCubit extends Cubit<bool> {
  BooleanCubit([bool init = true]) : super(init);

  void setFalse() {
    emit(false);
  }

  void setTrue() {
    emit(true);
  }
}
