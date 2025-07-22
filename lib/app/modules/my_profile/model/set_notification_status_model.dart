class SetNotificationSetAPI {
  bool? status;
  SetData? data;
  String? message;
  String? type;

  SetNotificationSetAPI({this.status, this.data, this.message, this.type});

  SetNotificationSetAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SetData.fromJson(json['data']) : null;
    message = json['message'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['type'] = type;
    return data;
  }
}

class SetData {
  bool? pushNotification;
  bool? emailNotification;
  bool? incomingDeliveries;
  bool? deliveryCompleted;
  bool? invoicesPayments;

  SetData(
      {this.pushNotification,
        this.emailNotification,
        this.incomingDeliveries,
        this.deliveryCompleted,
        this.invoicesPayments});

  SetData.fromJson(Map<String, dynamic> json) {
    pushNotification = json['push_notification'];
    emailNotification = json['email_notification'];
    incomingDeliveries = json['incoming_deliveries'];
    deliveryCompleted = json['delivery_completed'];
    invoicesPayments = json['invoices_payments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['push_notification'] = pushNotification;
    data['email_notification'] = emailNotification;
    data['incoming_deliveries'] = incomingDeliveries;
    data['delivery_completed'] = deliveryCompleted;
    data['invoices_payments'] = invoicesPayments;
    return data;
  }
}
