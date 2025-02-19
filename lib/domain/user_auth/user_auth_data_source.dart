import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/constants/api_endpoints.dart';
import 'package:zinc/domain/app_data_source.dart';
import 'package:zinc/domain/user_auth/user_auth_model.dart';

class UserAuthDataSource extends AppDataSource {
  UserAuthDataSource._();

  static UserAuthDataSource? _instance;

  static get getInstance => _instance ??= UserAuthDataSource._();

  Future<SendOTPResponse> sendOtp(String identifier, {bool? resend}) async {
    ZincAPIResponse<SendOTPResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            url: APIEndPoints.sendOtp,
            mapper: SendOTPResponse.fromJson,
            body: {"identifier": identifier}));
    return Future.value(
        response.body ?? (SendOTPResponse.error(response.error)));
  }

  Future<VerifyOTPResponse> verifyOtp(
      String identifier, String otp, String referenceId) async {
    ZincAPIResponse<VerifyOTPResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            url: APIEndPoints.verifyOtp,
            mapper: VerifyOTPResponse.fromJson,
            body: {
          'identifier': identifier,
          'otp': otp,
          'reference_id': referenceId
        }));
    return Future.value(
        response.body ?? (VerifyOTPResponse.error(response.error)));
  }

  Future verifyEmailOtp(
      String identifier, String otp, String referenceId) async {
    ZincAPIResponse<VerifyOTPResponse> response = await makeRequest(
      ZincAPIRequest(
        requestType: RequestType.post,
        url: APIEndPoints.verifyEmailOtp,
        mapper: VerifyOTPResponse.fromJson,
        body: {
          'identifier': identifier,
          'otp': otp,
          'reference_id': referenceId
        },
      ),
    );
    return Future.value(
        response.body ?? (VerifyOTPResponse.error(response.error)));
  }


}
