import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_barber/cat_event/model.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://cat-fact.herokuapp.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/facts')
  Future<List<CatFactModel>> getCats();
}
