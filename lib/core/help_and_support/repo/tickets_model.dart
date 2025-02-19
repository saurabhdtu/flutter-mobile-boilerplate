import 'package:flutter/material.dart';
import 'package:network_module/data/responses/responses.dart';

class TicketResponse extends BaseResponse {
  TicketResponse.error(error) : super.error(error);

  List<Ticket>? _tickets;

  TicketResponse.fromJson(dynamic json) {
    if (json is List) {
      _tickets = json.map((item) => Ticket.fromJson(item)).toList();
    } else {
      _tickets = [];
    }
  }

  List<Ticket> get tickets => _tickets ?? [];
}

class Ticket {
  String? _id;
  String? _subject;
  String? _description;
  String? _status;
  String? _priority;
  String? _createdAt;

  Ticket.fromJson(dynamic json) {
    _id = json['id']?.toString();
    _subject = json['subject'];
    _description = json['description'];
    _status = json['status'].toString();
    _priority = json['priority'].toString();
    _createdAt = json['created_at'];
  }

  String get id => _id ?? '';
  String get subject => _subject ?? '';
  String get description => _description ?? '';
  String get status => _status ?? '';
  String get priority => _priority ?? '';
  String get createdAt => _createdAt ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subject'] = _subject;
    map['description'] = _description;
    map['status'] = _status;
    map['priority'] = _priority;
    map['created_at'] = _createdAt;
    return map;
  }
}

enum TicketStatus {
  open,
  pending,
  resolved,
  closed,
}

extension TicketStatusExtension on TicketStatus {
  static TicketStatus fromValue(int value) {
    switch (value) {
      case 2:
        return TicketStatus.open;
      case 3:
        return TicketStatus.pending;
      case 4:
        return TicketStatus.resolved;
      case 5:
        return TicketStatus.closed;
      default:
        throw Exception("Invalid ticket status value");
    }
  }

  String get description {
    switch (this) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.pending:
        return 'Pending';
      case TicketStatus.resolved:
        return 'Resolved';
      case TicketStatus.closed:
        return 'Closed';
      default:
        return 'Unknown';
    }
  }

  Color get color {
    switch (this) {
      case TicketStatus.open:
        return Colors.red; // Open status - Red
      case TicketStatus.pending:
        return Colors.orange; // Pending status - Orange
      case TicketStatus.resolved:
        return Colors.green; // Resolved status - Green
      case TicketStatus.closed:
        return Colors.grey; // Closed status - Grey
      default:
        return Colors.black; // Default color for unknown status
    }
  }
}
