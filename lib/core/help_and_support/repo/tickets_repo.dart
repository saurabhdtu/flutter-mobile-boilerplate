import 'package:common_module/base/base_data_source.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/core/help_and_support/repo/ticket_detail_%20model.dart';
import 'package:zinc/core/help_and_support/repo/tickets_model.dart';

class TicketsRepo extends BaseDataSource {
  static TicketsRepo? _instance;

  TicketsRepo._();

  static TicketsRepo get getInstance => _instance ??= TicketsRepo._();

  // Method to get all user tickets
  Future<TicketResponse> getUserTickets(String email) async {
    final request = ZincAPIRequest<TicketResponse>(
      requestType: RequestType.get,
      disableAuth: true,
      host: 'https://zincmoneypvtltd.freshdesk.com/api/v2',
      url: '/tickets',
      queryParams: {'email': email},
      headers: {
        'Authorization': 'Basic Y1N6TE9JTzgxWEVEVWJDUXRkRXI6WA==',
      },
      mapper: (json) => TicketResponse.fromJson(json),
    );

    final response = await makeRequest<TicketResponse>(request);

    if (response.body != null) {
      return response.body!;
    } else {
      throw Exception('Failed to load tickets: ${response.error?.message}');
    }
  }

  // Method to get the details of a single ticket
  Future<TicketDetailsResponse> getTicketDetails(int ticketId) async {
    final request = ZincAPIRequest<TicketDetailsResponse>(
      requestType: RequestType.get,
      disableAuth: true,
      host: 'https://zincmoneypvtltd.freshdesk.com/api/v2',
      url: '/tickets/$ticketId',
      headers: {
        'Authorization': 'Basic Y1N6TE9JTzgxWEVEVWJDUXRkRXI6WA==',
      },
      mapper: (json) => TicketDetailsResponse.fromJson(json),
    );

    final response = await makeRequest<TicketDetailsResponse>(request);

    if (response.body != null) {
      return response.body!;
    } else {
      throw Exception(
          'Failed to load ticket details: ${response.error?.message}');
    }
  }
}
