import 'package:moduluenergy/src/network/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'modulgy_api_service.g.dart';

// const String BASE_URL = "https://admin.modulgy.com/api/";
const String BASE_URL =
    "https://v6rs9umpo7.execute-api.eu-west-1.amazonaws.com/api/";

@RestApi(baseUrl: BASE_URL)
abstract class ModulgyApiService {
  factory ModulgyApiService(Dio dio, {String baseUrl}) = _ModulgyApiService;

  @GET("/energy-production/{period}")
  Future<EnergyProductionResponseBody?> getMyEnergyProduction(
      @Path() String period,
      @Query("from") String from,
      @Query("to") String to);


  @GET("/admin/users")
  Future<UsersResponseBody> getUsers();

  @GET("/admin/user/{uuid}")
  Future<UserResponseBody> getUser(@Path() String uuid);

  @GET("/admin/energy-production-summary/{period}")
  Future<EnergyProductionSummaryResponseBody> getEnergyProductionSummary(
      @Path() String period,
      @Query("from") String from,
      @Query("to") String to);

  @GET("/admin/energy-production/{uuid}/{period}")
  Future<EnergyProductionResponseBody> getUserEnergyProduction(
      @Path() String uuid,
      @Path() String period,
      @Query("from") String from,
      @Query("to") String to);

  @POST("/user/activate")
  Future<void> activateUser(@Body() ActivateRequestBody body);

  @POST("/user/activationCode/resend")
  Future<void> resendActivationCode(@Body() ResendCodeBody body);

  @POST("/user/password/reset")
  Future<void> resetPassword(@Body() PasswordResetRequestBody body);

  @POST("/user/password/change")
  Future<void> changePassword(@Body() PasswordChangeRequestBody body);

  @POST("/user/signup")
  Future<void> signUp(@Body() NewUserData body);

  @POST("/user/login")
  Future<AuthToken?> login(@Body() AuthRequest body);

  @GET("/user/me")
  Future<UserResponseBody?> me();

  @DELETE("/user/me")
  Future<void> deleteUser();
}
