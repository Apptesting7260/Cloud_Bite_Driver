class ResendModel {
  String? message;
  String? phone;
  String? otpCode;
  String? type;
  bool? status;

  ResendModel({this.message, this.phone, this.otpCode, this.type, this.status});

  ResendModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    phone = json['phone'].toString();
    otpCode = json['otpCode'].toString();
    type = json['type'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['phone'] = this.phone;
    data['otpCode'] = this.otpCode;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
