import 'package:utility_module/extensions/string_extensions.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/lob/remittance/constants/api_endpoints.dart';
import 'package:zinc/lob/remittance/domain/kyc/kyc_response_models.dart';
import 'package:zinc/lob/remittance/domain/remittance_data_source.dart';

class KycDataSource extends RemittanceDataSource {
  KycDataSource._();

  static KycDataSource? _instance;

  static get getInstance => _instance ??= KycDataSource._();

  Future<KycStatusResponse> getKycFromDigiLocker(String? refId) async {
    ZincAPIResponse<KycStatusResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            url: ApiEndpoints.checkDigiLockerStatus,
            body: {"transaction_id": refId},
            mapper: KycStatusResponse.fromJson));
    return Future.value(
        response.body ?? (KycStatusResponse.error(response.error)));
  }

  Future<KycInitResponse> starDigiLockerKyc(Map<String, bool> body) async {
    ZincAPIResponse<KycInitResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: body,
            url: ApiEndpoints.startDigiLockerVerification,
            mapper: KycInitResponse.fromJson));
    return Future.value(
        response.body ?? (KycInitResponse.error(response.error)));
  }

  Future<KycPanVerificationResponse> verifyPan(
      String? panCard, String? dob, String remitterId) async {
    Map<String, String?> body = {"remitter_id": remitterId};
    if (!panCard.isEmptyOrNull()) body['pan'] = panCard;
    if (!dob.isEmptyOrNull()) body['dob'] = dob;
    ZincAPIResponse<KycPanVerificationResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: body,
            url: ApiEndpoints.kycVerifyPan,
            mapper: KycPanVerificationResponse.fromJson));
    return Future.value(
        response.body ?? (KycPanVerificationResponse.error(response.error)));
  }

  Future<IfscVerificationResponse> verifyIfsc(String ifsc) async {
    ZincAPIResponse<IfscVerificationResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: {"ifsc": ifsc},
            url: ApiEndpoints.verifyIfsc,
            mapper: IfscVerificationResponse.fromJson));
    return Future.value(
        response.body ?? (IfscVerificationResponse.error(response.error)));
  }

  Future<BankVerificationResponse> verifyBankDetails(String ifsc,
      String remitterId, String accountNum, String accountType) async {
    ZincAPIResponse<BankVerificationResponse> response =
        await makeRequest(ZincAPIRequest(
            requestType: RequestType.post,
            body: {
              "ifsc": ifsc,
              "remitter_id": remitterId,
              "account_number": accountNum,
              "account_type": accountType
            },
            url: ApiEndpoints.verifyBankDetails,
            mapper: BankVerificationResponse.fromJson));
    return Future.value(
        response.body ?? (BankVerificationResponse.error(response.error)));
  }

  ///Document upload
  Future<KycInitResponse> starDocumentUpload(
      Map<String?, String?> params) async {
    ZincAPIResponse<KycInitResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.startDocumentUpload,
            mapper: KycInitResponse.fromJson));
    return Future.value(
        response.body ?? (KycInitResponse.error(response.error)));
  }

  Future<KycStatusResponse> getDocumentUploadStatus(
      Map<String?, String?> params) async {
    ZincAPIResponse<KycStatusResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.checkDocumentStatus,
            mapper: KycStatusResponse.fromJson));
    return Future.value(
        response.body ?? (KycStatusResponse.error(response.error)));
  }

  Future<KycInitResponse> starPassportUpload(
      Map<dynamic, dynamic> params) async {
    ZincAPIResponse<KycInitResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.startPassportUpload,
            mapper: KycInitResponse.fromJson));
    return Future.value(
        response.body ?? (KycInitResponse.error(response.error)));
  }

  Future<KycPassportDataResponse> getPassportStatus(
      Map<dynamic, dynamic> params) async {
    ZincAPIResponse<KycPassportDataResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.getPassportStatus,
            mapper: KycPassportDataResponse.fromJson));
    return Future.value(
        response.body ?? (KycPassportDataResponse.error(response.error)));
  }
}
