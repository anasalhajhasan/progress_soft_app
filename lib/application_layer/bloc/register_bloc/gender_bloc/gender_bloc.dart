import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class GenderEvent {}

class GenderChanged extends GenderEvent {
  final String gender;

  GenderChanged(this.gender);
}

// States
abstract class GenderState {}

class GenderInitial extends GenderState {}

class GenderUpdated extends GenderState {
  final String? gender;

  GenderUpdated({this.gender});
}

// Bloc
class GenderBloc extends Bloc<GenderEvent, GenderState> {
  String? _selectedGender;
  String? get selectedGender => _selectedGender;

  GenderBloc() : super(GenderInitial()) {
    on<GenderChanged>((event, emit) {
      emit(GenderUpdated(gender: event.gender));
      _selectedGender = event.gender;
    });
  }
}
