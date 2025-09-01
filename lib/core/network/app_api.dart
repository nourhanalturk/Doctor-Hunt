import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../config/constants/env_constants.dart';
import '../../config/constants/request_constants.dart';
import '../../config/constants/request_endpoint_constants.dart';
import '../../features/login/data/response/login_response.dart';
import '../service/env_service.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppService {
  factory AppService(Dio dio) {
    return _AppService(
      dio,
      baseUrl: EnvService.getString(
        key: EnvConstants.apiUrl,
      ),
    );
  }

  @POST(RequestConstantsEndpoints.login)
  Future<LoginResponse> login(
    @Field(RequestConstants.email) String email,
    @Field(RequestConstants.password) String password,
  );


  // @GET(RequestConstantsEndpoints.home)
  // Future<HomeResponse> home();
}
