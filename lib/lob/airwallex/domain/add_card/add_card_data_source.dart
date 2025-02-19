import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:resource_download_manager_module/resource_model.dart';
import 'package:zinc/lob/airwallex/constants/api_endpoints.dart';
import 'package:zinc/lob/airwallex/domain/airwallex_data_source.dart';

class AddCardDataSource extends AirWallexDataSource {
  AddCardDataSource._();

  static AddCardDataSource? _instance;

  static get getInstance => _instance ??= AddCardDataSource._();


  Future<ResourceListResponse> getRFIData() async {
    ZincAPIResponse<ResourceListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: AWApiEndpoints.getRFIData,
            mapper: ResourceListResponse.fromJson));
    return Future.value(
        response.body ?? (ResourceListResponse.error(response.error)));
  }
}
