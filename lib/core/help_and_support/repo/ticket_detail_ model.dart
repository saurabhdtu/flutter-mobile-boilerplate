import 'package:network_module/data/responses/responses.dart';

class TicketDetailsResponse extends BaseResponse {
  TicketDetailsResponse.error(error) : super.error(error);

  TicketDetails? _ticket;

  TicketDetailsResponse.fromJson(dynamic json) {
    _ticket = TicketDetails.fromJson(json);
  }

  TicketDetails? get ticket => _ticket;
}

class TicketDetails {
  List<String>? _ccEmails;
  List<String>? _fwdEmails;
  List<String>? _replyCcEmails;
  List<String>? _ticketCcEmails;
  bool? _frEscalated;
  bool? _spam;
  int? _emailConfigId;
  int? _priority;
  int? _requesterId;
  int? _responderId;
  int? _source;
  int? _status;
  String? _subject;
  String? _description;
  String? _descriptionText;
  int? _productId;
  int? _id;
  DateTime? _dueBy;
  DateTime? _frDueBy;
  bool? _isEscalated;
  CustomFields? _customFields;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  TicketDetails.fromJson(dynamic json) {
    _ccEmails = List<String>.from(json['cc_emails'] ?? []);
    _fwdEmails = List<String>.from(json['fwd_emails'] ?? []);
    _replyCcEmails = List<String>.from(json['reply_cc_emails'] ?? []);
    _ticketCcEmails = List<String>.from(json['ticket_cc_emails'] ?? []);
    _frEscalated = json['fr_escalated'];
    _spam = json['spam'];
    _emailConfigId = json['email_config_id'];
    _priority = json['priority'];
    _requesterId = json['requester_id'];
    _responderId = json['responder_id'];
    _source = json['source'];
    _status = json['status'];
    _subject = json['subject'];
    _description = json['description'];
    _descriptionText = json['description_text'];
    _productId = json['product_id'];
    _id = json['id'];
    _dueBy = json['due_by'] != null ? DateTime.parse(json['due_by']) : null;
    _frDueBy =
        json['fr_due_by'] != null ? DateTime.parse(json['fr_due_by']) : null;
    _isEscalated = json['is_escalated'];
    _customFields = json['custom_fields'] != null
        ? CustomFields.fromJson(json['custom_fields'])
        : null;
    _createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    _updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  String get id => _id?.toString() ?? '';
  String get subject => _subject ?? '';
  String get description => _description ?? '';
  String get descriptionText => _descriptionText ?? '';
  int get priority => _priority ?? 0;
  int get requesterId => _requesterId ?? 0;
  int get responderId => _responderId ?? 0;
  DateTime? get dueBy => _dueBy;
  DateTime? get frDueBy => _frDueBy;
  bool get frEscalated => _frEscalated ?? false;
  bool get spam => _spam ?? false;
  List<String> get ccEmails => _ccEmails ?? [];
  List<String> get fwdEmails => _fwdEmails ?? [];
  List<String> get replyCcEmails => _replyCcEmails ?? [];
  List<String> get ticketCcEmails => _ticketCcEmails ?? [];
  CustomFields? get customFields => _customFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cc_emails'] = _ccEmails;
    map['fwd_emails'] = _fwdEmails;
    map['reply_cc_emails'] = _replyCcEmails;
    map['ticket_cc_emails'] = _ticketCcEmails;
    map['fr_escalated'] = _frEscalated;
    map['spam'] = _spam;
    map['email_config_id'] = _emailConfigId;
    map['priority'] = _priority;
    map['requester_id'] = _requesterId;
    map['responder_id'] = _responderId;
    map['source'] = _source;
    map['status'] = _status;
    map['subject'] = _subject;
    map['description'] = _description;
    map['description_text'] = _descriptionText;
    map['product_id'] = _productId;
    map['id'] = _id;
    map['due_by'] = _dueBy?.toIso8601String();
    map['fr_due_by'] = _frDueBy?.toIso8601String();
    map['is_escalated'] = _isEscalated;
    if (_customFields != null) {
      map['custom_fields'] = _customFields!.toJson();
    }
    map['created_at'] = _createdAt?.toIso8601String();
    map['updated_at'] = _updatedAt?.toIso8601String();
    return map;
  }
}

class CustomFields {
  dynamic cfTxnId;
  dynamic cfNmiFields;

  CustomFields({
    this.cfTxnId,
    this.cfNmiFields,
  });

  factory CustomFields.fromJson(Map<String, dynamic> json) {
    return CustomFields(
      cfTxnId: json['cf_txn_id'],
      cfNmiFields: json['cf_nmi_fields'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cf_txn_id'] = cfTxnId;
    data['cf_nmi_fields'] = cfNmiFields;
    return data;
  }
}
