import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/responses/responses.dart';

abstract class ApiClient {
  Future<ZincAPIResponse<T>> makeRequest<T extends BaseResponse>(
      ZincAPIRequest<T> request);
}
