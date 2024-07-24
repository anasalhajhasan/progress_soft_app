import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/data_layer/api/api_client.dart';
import 'package:progress_soft_app/data_layer/models/posts_model/posts_model.dart';
import 'package:progress_soft_app/data_layer/repositories/home_repositories.dart';
import 'package:progress_soft_app/domain_layer/usecases/home_usecase/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase = HomeUseCase(
    HomeRepositoryImpl(remoteDataSource: RestClient(Dio())),
  );

  List<PostsModel>? _listOfPosts;
  List<PostsModel>? get listOfPosts => _listOfPosts;

  List<PostsModel>? _listDisplay;
  List<PostsModel>? get listDisplay => _listDisplay;

  List<PostsModel>? _searchResults;
  List<PostsModel>? get searchResults => _searchResults;

  HomeBloc() : super(HomeInitial()) {
    on<ExecuteListOfPosts>(
      (event, emit) async {
        try {
          emit(LoadingAPI());
          await _homeUseCase.executeGetListOfPosts().then((value) {
            value.fold((failure) => null, (result) {
              _listOfPosts = result;
              _listDisplay = _listOfPosts;
            });
            emit(SuccessAPI());
          });
        } on Exception catch (e) {
          emit(ErrorAPI());
          debugPrint(e.toString());
        }
      },
    );
    on<SearchListOfPosts>(_onSearchPosts);
  }

  Future<void> _onSearchPosts(
    SearchListOfPosts event,
    Emitter<HomeState> emit,
  ) async {
    if (event.searchValue.toString().trim().isNotEmpty) {
      _searchResults = _listOfPosts!
          .where(
            (PostsModel item) =>
                item.title!.toLowerCase().replaceAll(' ', '').contains(
                      event.searchValue.toString().toLowerCase().replaceAll(' ', ''),
                    ) ||
                item.id!.toString().toLowerCase().replaceAll(' ', '').contains(
                      event.searchValue.toString().toLowerCase().replaceAll(' ', ''),
                    ) ||
                item.body!.toLowerCase().replaceAll(' ', '').contains(
                      event.searchValue.toString().toLowerCase().replaceAll(' ', ''),
                    ),
          )
          .toList();
      _listDisplay = _searchResults;
      emit(SuccessAPI());
    } else {
      _listDisplay = _listOfPosts;
      emit(SuccessAPI());
    }
  }
}
