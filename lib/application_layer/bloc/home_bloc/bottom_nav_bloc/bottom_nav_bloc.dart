import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc
    extends Bloc<BottomNavEvent, BottomNavBlocState> {
  int selectedScreen = 0;
  BottomNavBloc() : super(NavigationsBlocInitial()) {
    on<BottomNavEvent>((event, emit) {
      if (event is NavigationChangeIndexEvent) {
        emit(Loading());
        selectedScreen = event.indexOfScreen;
        emit(Success());
      }
    });
  }
}