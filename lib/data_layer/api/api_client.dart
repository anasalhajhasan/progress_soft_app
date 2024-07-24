import 'package:dio/dio.dart';
import 'package:progress_soft_app/data_layer/models/posts_model/posts_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<PostsModel>> getListOfPosts();
}