import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://cataas.com")
abstract class ImageService {
  factory ImageService(Dio dio) = _ImageService;

  @GET("/cat")
  // @Headers(<String, dynamic>{
  //   "Accept": "image/jpeg",
  // })
  Future<HttpResponse<List<int>>> getCatImage();
}
