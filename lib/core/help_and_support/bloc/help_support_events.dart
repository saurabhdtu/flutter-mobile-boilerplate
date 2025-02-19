abstract class TicketEvent {}

class FetchTickets extends TicketEvent {
  final String email;

  FetchTickets(this.email);
}

class FetchTicketDetails extends TicketEvent {
  final int ticketId;

  FetchTicketDetails(this.ticketId);
}
