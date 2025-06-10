class SetDeliveryMethodModel {
  String? message;
  String? type;
  bool? status;

  SetDeliveryMethodModel({this.message, this.type, this.status});

  SetDeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    type = json['type'].toString();
    status = json['status'] == 1 || json['status'] == true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}