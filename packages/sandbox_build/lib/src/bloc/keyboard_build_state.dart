part of 'keyboard_build_cubit.dart';

abstract class KeyboardBuildState extends Equatable {
  const KeyboardBuildState();
}

class KeyboardBuildInitial extends KeyboardBuildState {
  @override
  List<Object> get props => [];
}

class KeyboardBuildUpdated extends KeyboardBuildState {
  const KeyboardBuildUpdated({required this.keyboard});
  final String keyboard;

  @override
  List<Object> get props => [keyboard];
}
