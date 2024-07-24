part of 'home_bloc.dart';

@immutable
class HomeEvent {}

class ExecuteListOfPosts extends HomeEvent {}

class SearchListOfPosts extends HomeEvent {
  final String searchValue;
  SearchListOfPosts({required this.searchValue});
}
