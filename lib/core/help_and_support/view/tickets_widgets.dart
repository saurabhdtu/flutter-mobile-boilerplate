import 'package:common_module/fresh_chat.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:utility_module/extensions/date_time_extensions.dart';
import 'package:zinc/core/help_and_support/repo/tickets_model.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';

class TicketWidget extends StatelessWidget {
  final Ticket ticket;

  const TicketWidget({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () => _onTicketTap(context, ticket),
        title: Text(
          ticket.subject,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: ZincTextStyle.normalBold(),
        ),
        subtitle: _buildSubtitle(),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '#${ticket.id} ', // Ticket ID
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                TextSpan(
                  text: '   ⬤ ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: TicketStatusExtension.fromValue(
                      int.parse(ticket.status),
                    ).color,
                  ),
                ),
                TextSpan(
                  text: TicketStatusExtension.fromValue(
                    int.parse(ticket.status),
                  ).description,
                  style: ZincTextStyle.microBoldCaps(
                    color: TicketStatusExtension.fromValue(
                      int.parse(ticket.status),
                    ).color,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateTime.parse(ticket.createdAt).formatToDate().toString(),
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _onTicketTap(BuildContext context, Ticket ticket) {
    FreshchatService.sendMessage(
      AppStrings.chatWithUs,
      'Please update me on Ticket:${ticket.id}',
    );

    FreshchatService.showConversation(
      filteredViewTitle: ticket.id,
      tags: ['chat with us'],
    );
  }
}

class TicketListWidget extends StatelessWidget {
  final List<Ticket> tickets;
  final int? ticketsLength;

  const TicketListWidget(
    this.tickets, {
    Key? key,
    this.ticketsLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ticketsLength ?? tickets.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return TicketWidget(ticket: ticket);
      },
    );
  }
}

class TicketDetailsScreen extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketDetailsScreen({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(
      context,
      '',
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TicketListWidget(tickets),
      ),
      showHelp: false,
      title: '${AppStrings.currentTicket}s',
    );
  }
}
