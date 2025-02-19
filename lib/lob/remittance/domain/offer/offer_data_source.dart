import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/lob/remittance/constants/api_endpoints.dart';
import 'package:zinc/lob/remittance/domain/offer/offer_model.dart';
import 'package:zinc/lob/remittance/domain/remittance_data_source.dart';

class OfferDataSource extends RemittanceDataSource {
  OfferDataSource._();

  static OfferDataSource? _instance;

  static get getInstance => _instance ??= OfferDataSource._();

  Future<OfferResponse> getUserOffer() async {
    ZincAPIResponse<OfferResponse> response = await makeRequest(ZincAPIRequest(
        requestType: RequestType.post,
        url: ApiEndpoints.getOffers,
        mapper: OfferResponse.fromJson));
    return Future.value(response.body ?? (OfferResponse.error(response.error)));
  }
}
