import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/lob/airwallex/constants/api_endpoints.dart';
import 'package:zinc/lob/airwallex/domain/airwallex_data_source.dart';
import 'package:zinc/lob/airwallex/domain/payout/payment_request_models.dart';
import 'package:zinc/lob/airwallex/domain/payout/payment_response_models.dart';

class PaymentDataSource extends AirWallexDataSource {
  PaymentDataSource._();

  static PaymentDataSource? _instance;

  static get getInstance => _instance ??= PaymentDataSource._();

  Future<CreatePaymentResponse> createPaymentRequest(
      CreatePaymentRequest paymentRequest) async {
    ZincAPIResponse<CreatePaymentResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            url: AWApiEndpoints.createPaymentRequest,
            body: paymentRequest.toJson(),
            mapper: CreatePaymentResponse.fromJson));
    return Future.value(
        response.body ?? (CreatePaymentResponse.error(response.error)));
  }
}
