import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'bottom_index_event.dart';
part 'bottom_index_state.dart';

class BottomIndexBloc extends Bloc<BottomIndexEvent, BottomIndexState> {
  BottomIndexBloc() : super(BottomIndexInitial()) {
    on<BottomChangedIndexEvent>((event, emit) {
      emit(BottomIndexChangedState(index: event.index));
    });

  }
}
