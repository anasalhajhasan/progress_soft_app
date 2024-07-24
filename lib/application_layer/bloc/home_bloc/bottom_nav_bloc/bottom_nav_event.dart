part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavEvent {}

class NavigationChangeIndexEvent extends BottomNavEvent {
  final int indexOfScreen;

  NavigationChangeIndexEvent({required this.indexOfScreen});
}
