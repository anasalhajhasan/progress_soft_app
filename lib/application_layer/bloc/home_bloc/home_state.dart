part of 'home_bloc.dart';

@immutable
class HomeState {}

class HomeInitial extends HomeState {}

class LoadingAPI extends HomeState {}

class ErrorAPI extends HomeState {}

class SuccessAPI extends HomeState {}