import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'keyboard_build_state.dart';

class KeyboardBuildCubit extends Cubit<KeyboardBuildState> {
  KeyboardBuildCubit() : super(KeyboardBuildInitial());

  void update({required String keyboard}) {
    emit(KeyboardBuildUpdated(keyboard: keyboard));
  }
}
