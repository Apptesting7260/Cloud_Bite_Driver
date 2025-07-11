class GetNotificationSetAPI {
  bool? status;
  String? message;
  GetData? data;
  String? type;

  GetNotificationSetAPI({this.status, this.message, this.data, this.type});

  GetNotificationSetAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'] is bool ? json['status'] : json['status'] == 'true';
    message = json['message']?.toString();
    data = json['data'] != null ? GetData.fromJson(json['data']) : null;
    type = json['type']?.toString();
  }
}

class GetData {
  bool? pushNotification;
  bool? emailNotification;
  bool? incomingDeliveries;
  bool? deliveryCompleted;
  bool? invoicesPayments;

  GetData.fromJson(Map<String, dynamic> json) {
    pushNotification = json['push_notification'] is bool
        ? json['push_notification']
        : json['push_notification'] == 'true';

    emailNotification = json['email_notification'] is bool
        ? json['email_notification']
        : json['email_notification'] == 'true';

    incomingDeliveries = json['incoming_deliveries'] is bool
        ? json['incoming_deliveries']
        : json['incoming_deliveries'] == 'true';

    deliveryCompleted = json['delivery_completed'] is bool
        ? json['delivery_completed']
        : json['delivery_completed'] == 'true';

    invoicesPayments = json['invoices_payments'] is bool
        ? json['invoices_payments']
        : json['invoices_payments'] == 'true';
  }
}