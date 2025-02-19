import 'package:common_module/base/base_bloc.dart';
import 'package:zinc/app/app_prefs.dart';
import 'package:zinc/core/help_and_support/bloc/help_support_state.dart';
import 'package:zinc/core/help_and_support/repo/tickets_repo.dart';

class TicketBloc extends BaseCubit<TicketState> {
  final TicketsRepo _ticketsRepo;

  TicketBloc(this._ticketsRepo) : super(TicketLoading());

  Future<void> fetchTicketDetails(String ticketId) async {
    emitState(TicketDetailsLoading());
    try {
      final ticketDetailsResponse =
          await _ticketsRepo.getTicketDetails(int.parse(ticketId));
      emitState(TicketDetailsLoaded(ticketDetailsResponse.ticket));
    } catch (error) {
      handleError(error);
      emitState(TicketError('Failed to fetch ticket details: $error'));
    }
  }
}
