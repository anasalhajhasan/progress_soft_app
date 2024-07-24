import 'package:dartz/dartz.dart';
import 'package:progress_soft_app/data_layer/exceptions/failure_exceptions.dart';
import 'package:progress_soft_app/data_layer/models/posts_model/posts_model.dart';
import 'package:progress_soft_app/domain_layer/i_repositories/i_home_repositories/i_home_repositories.dart';

class HomeUseCase {
  final IHomeRepository repository;

  HomeUseCase(this.repository);
  Future<Either<Failure, List<PostsModel>>> executeGetListOfPosts() {
    return repository.executeGetListOfPosts();
  }
}