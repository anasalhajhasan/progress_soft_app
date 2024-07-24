import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AgeEvent {}

class AgeChanged extends AgeEvent {
  final DateTime age;

  AgeChanged(this.age);
}

// States
abstract class AgeState {}

class AgeInitial extends AgeState {}

class AgeUpdated extends AgeState {
  final DateTime? age;

  AgeUpdated({this.age});
}

// Bloc
class AgeBloc extends Bloc<AgeEvent, AgeState> {
  DateTime? _selectedAge;
  DateTime? get selectedAge => _selectedAge;
  AgeBloc() : super(AgeInitial()) {
    on<AgeChanged>((event, emit) {
      emit(AgeUpdated(age: event.age));
      _selectedAge = event.age;
    });
  }

  void reset() {
    _selectedAge = null;
  }
}
