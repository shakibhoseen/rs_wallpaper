part of 'bottom_index_bloc.dart';

@immutable
sealed class BottomIndexState {}

final class BottomIndexInitial extends BottomIndexState {
  final int index = 0;
}

class BottomIndexChangedState extends BottomIndexState{
 final int index;
  BottomIndexChangedState({required this.index});

}
