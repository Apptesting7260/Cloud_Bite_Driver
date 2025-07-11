class GetEmailOTPModel {
  String? type;
  String? otp;
  String? message;
  bool? status;
  String? token;

  GetEmailOTPModel({this.type, this.otp, this.message, this.status});

  GetEmailOTPModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    otp = json['otp'].toString();
    message = json['message'].toString();
    status = json['status'];
    token = json['token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }
}
