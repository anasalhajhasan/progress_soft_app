import 'package:dartz/dartz.dart';
import 'package:progress_soft_app/data_layer/exceptions/failure_exceptions.dart';
import 'package:progress_soft_app/data_layer/models/posts_model/posts_model.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<PostsModel>>> executeGetListOfPosts();
}
