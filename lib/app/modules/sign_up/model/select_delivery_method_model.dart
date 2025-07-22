class SetDeliveryMethodModel {
  String? message;
  String? type;
  bool? status;
  String? stage;

  SetDeliveryMethodModel({this.message, this.type, this.status, this.stage});

  SetDeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    type = json['type'].toString();
    status = json['status'];
    stage = json['stage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    data['status'] = status;
    data['stage'] = stage;
    return data;
  }
}
