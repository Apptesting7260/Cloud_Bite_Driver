class SetNotificationSetAPI {
  bool? status;
  SetData? data;
  String? message;
  String? type;

  SetNotificationSetAPI({this.status, this.data, this.message, this.type});

  SetNotificationSetAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SetData.fromJson(json['data']) : null;
    message = json['message'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['type'] = this.type;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['push_notification'] = this.pushNotification;
    data['email_notification'] = this.emailNotification;
    data['incoming_deliveries'] = this.incomingDeliveries;
    data['delivery_completed'] = this.deliveryCompleted;
    data['invoices_payments'] = this.invoicesPayments;
    return data;
  }
}
