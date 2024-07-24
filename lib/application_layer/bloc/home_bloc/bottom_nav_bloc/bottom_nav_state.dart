part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavBlocState {}

class Loading extends BottomNavBlocState {}

class Success extends BottomNavBlocState {}

class NavigationsBlocInitial extends BottomNavBlocState {}