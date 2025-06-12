class SetDeliveryMethodModel {
  String? message;
  String? type;
  bool? status;
  String? stage;

  SetDeliveryMethodModel({this.message, this.type, this.status, this.stage});

  SetDeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    status = json['status'];
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    data['stage'] = this.stage;
    return data;
  }
}
