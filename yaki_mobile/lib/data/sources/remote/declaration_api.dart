import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/declaration_model.dart';

part 'declaration_api.g.dart';

@RestApi()
abstract class DeclarationApi {
  factory DeclarationApi(Dio dio, {required String baseUrl}) = _DeclarationApi;

  @GET('/declarations')
  Future<HttpResponse> getDeclaration(
    @Query("teammateId") String id,
  );

  @POST('/declarations')
  Future<HttpResponse> create(
    @Body() List<DeclarationModel> declaration,
    @Query("mode") String mode,
  );
}
