part of 'bottom_index_bloc.dart';

@immutable
sealed class BottomIndexEvent {

}

class BottomChangedIndexEvent extends BottomIndexEvent {
  final int index;
  BottomChangedIndexEvent({required this.index});
}
