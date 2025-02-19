import 'package:zinc/core/help_and_support/repo/ticket_detail_%20model.dart';
import 'package:zinc/core/help_and_support/repo/tickets_model.dart';

abstract class TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<Ticket> tickets;

  TicketLoaded(this.tickets);
}

class TicketError extends TicketState {
  final String errorMessage;

  TicketError(this.errorMessage);
}

class TicketDetailsLoading extends TicketState {}

class TicketDetailsLoaded extends TicketState {
  final TicketDetails? ticketDetails;

  TicketDetailsLoaded(this.ticketDetails);
}
