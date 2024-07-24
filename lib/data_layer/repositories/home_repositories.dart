import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:progress_soft_app/data_layer/api/api_client.dart';
import 'package:progress_soft_app/data_layer/exceptions/failure_exceptions.dart';
import 'package:progress_soft_app/data_layer/exceptions/server_exceptions.dart';
import 'package:progress_soft_app/data_layer/models/posts_model/posts_model.dart';
import 'package:progress_soft_app/domain_layer/i_repositories/i_home_repositories/i_home_repositories.dart';

class HomeRepositoryImpl implements IHomeRepository {
  HomeRepositoryImpl({required this.remoteDataSource});

  final RestClient remoteDataSource;
  @override
  Future<Either<Failure, List<PostsModel>>> executeGetListOfPosts() async {
    try {
      final result = await remoteDataSource.getListOfPosts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.message ?? "",
        ),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure(
          'Failed to connect to the network',
        ),
      );
    }
  }
}