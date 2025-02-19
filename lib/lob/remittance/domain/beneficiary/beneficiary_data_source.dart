import 'package:utility_module/extensions/string_extensions.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:sprintf/sprintf.dart';
import 'package:zinc/constants/api_endpoints.dart';
import 'package:zinc/lob/remittance/constants/api_endpoints.dart';
import 'package:zinc/lob/remittance/domain/beneficiary/beneficiary_models.dart';
import 'package:zinc/lob/remittance/domain/remittance_data_source.dart';

class BeneficiaryDataSource extends RemittanceDataSource {
  BeneficiaryDataSource._();

  static BeneficiaryDataSource? _instance;

  static get getInstance => _instance ??= BeneficiaryDataSource._();

  Future<BeneficiaryListResponse> getListOfBeneficiaries(
      int pageNo, int pageSize) async {
    ZincAPIResponse<BeneficiaryListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getBeneficiaries,
            queryParams: {
              "page": pageNo,
              "page_size": pageSize,
              "grouped": false
            },
            mapper: BeneficiaryListResponse.fromJson));
    return Future.value(
        response.body ?? (BeneficiaryListResponse.error(response.error)));
  }

  Future<GroupedBeneficiaryListResponse> getGroupedListOfBeneficiaries(
      int pageNo, int pageSize, String? currency) async {
    ZincAPIResponse<GroupedBeneficiaryListResponse> response =
        await makeRequest(ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getBeneficiaries,
            queryParams: {
              "page": pageNo,
              "page_size": pageSize,
              "grouped": true,
              "currency": currency
            },
            mapper: GroupedBeneficiaryListResponse.fromJson));
    return Future.value(response.body ??
        (GroupedBeneficiaryListResponse.error(response.error)));
  }

  ///get currency based reason list
  Future<ReceiverReasonListResponse> getCurrencyBasedReasonList(
      String? currency) async {
    ZincAPIResponse<ReceiverReasonListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(
                ApiEndpoints.getReceiverReasonsBasedOnCurrency, [currency]),
            mapper: ReceiverReasonListResponse.fromJson));
    return Future.value(
        (response.body ?? ReceiverReasonListResponse.error(response.error)));
  }

  ///getReason Based Student list
  Future<StudentListResponse> getReasonBasedStudentList(
      String? reason, String? currency) async {
    ZincAPIResponse<StudentListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(ApiEndpoints.getReceiverStudentsBasedOnReason,
                [reason, currency]),
            mapper: StudentListResponse.fromJson));
    return Future.value(
        (response.body ?? StudentListResponse.error(response.error)));
  }

  ///get upload document list based on reason
  Future<BeneficiaryDocumentResponse> getBeneficiaryTypeDocuments(
      String beneficiaryType) async {
    ZincAPIResponse<BeneficiaryDocumentResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(
                ApiEndpoints.getBeneficiaryDocumentByType, [beneficiaryType]),
            mapper: BeneficiaryDocumentResponse.fromJson));
    return Future.value(
        response.body ?? (BeneficiaryDocumentResponse.error(response.error)));
  }

  ///create student
  Future<CreateStudentResponse> initiateCreateStudent() async {
    ZincAPIResponse<CreateStudentResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            url: ApiEndpoints.initiateCreateStudent,
            mapper: CreateStudentResponse.fromJson));

    return Future.value(
        response.body ?? (CreateStudentResponse.error(response.error)));
  }

  ///add student
  Future<AddStudentResponse> addStudent(
    String? studentId,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? address,
    String? zipcode,
    String? city,
    String? state,
    String? countryName,
    String? fullNamePassport,
    String? passportNo,
    String? transactionId,
    String? addressLine1,
    String? addressLine2,
    String? pinCode,
    String? dob,
    String? passportCity,
    String? passportState,
    String? issueDate,
    String? expiryDate,
  ) async {
    var params = {
      "student_id": studentId,
      "personal_details": {
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber
      },
      "address": {
        "address_line_1": address,
        "postal_code": zipcode,
        "city": city,
        "state": state,
        "country": countryName
      },
      "passport_data": {
        "full_name": fullNamePassport,
        "passport_no": passportNo,
        "transaction_id": transactionId,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "pincode": pinCode,
        "dob": dob,
        "city": city,
        "state": state,
        "issue_date": issueDate,
        "expiry_date": expiryDate,
      }
    };
    ZincAPIResponse<AddStudentResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.addStudent,
            mapper: AddStudentResponse.fromJson));

    return Future.value(
        response.body ?? (AddStudentResponse.error(response.error)));
  }

  Future<BeneficiaryResponse> getBeneficiaryDetails(
      String beneficiaryId) async {
    ZincAPIResponse<BeneficiaryResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(ApiEndpoints.getBeneficiaryById, [beneficiaryId]),
            mapper: BeneficiaryResponse.fromJson));
    return Future.value(
        response.body ?? (BeneficiaryResponse.error(response.error)));
  }

  Future<AddBeneficiaryResponse> addBeneficiary(
      String? studentId,
      String reason,
      String accountName,
      String swiftCode,
      String accountType,
      String accountNumber,
      String routingNumber,
      String iBAN,
      String bSBCode,
      String bankName,
      String bankAddress,
      String sortCode,
      {String? email,
      String? phoneNumber,
      String? address,
      String? zipcode,
      String? city,
      String? state,
      String? country}) async {
    var params = {
      "student_id": studentId,
      "beneficiary_type": reason,
      "personal_details": {
        "full_name": accountName,
        if (!(email!.isEmptyOrNull())) "email": email,
        if (!(phoneNumber.isEmptyOrNull())) "phone_number": phoneNumber
      },
      if (!(address.isEmptyOrNull()))
        "address": {
          if (!(address.isEmptyOrNull())) "address_line_1": address,
          if (!(zipcode.isEmptyOrNull())) "postal_code": zipcode,
          if (!(city.isEmptyOrNull())) "city": city,
          if (!(state.isEmptyOrNull())) "state": state,
          if (!(country.isEmptyOrNull())) "country": country
        },
      "bank_details": {
        "swift_code": swiftCode,
        "account_type": accountType,
        "account_name": accountName,
        "account_number": accountNumber,
        if (!(routingNumber.isEmptyOrNull())) "routing_number": routingNumber,
        if (!(sortCode.isEmptyOrNull())) "sort_code": sortCode,
        if (!(iBAN.isEmptyOrNull())) "iban_no": iBAN,
        if (!(bSBCode.isEmptyOrNull())) "bsb_code": bSBCode,
        "bank_name": bankName,
        "bank_address": bankAddress
      }
    };
    ZincAPIResponse<AddBeneficiaryResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.addBeneficiary,
            mapper: AddBeneficiaryResponse.fromJson));

    return Future.value(
        response.body ?? (AddBeneficiaryResponse.error(response.error)));
  }
}
