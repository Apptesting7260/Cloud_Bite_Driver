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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['otp'] = otp;
    data['message'] = message;
    data['status'] = status;
    data['token'] = token;
    return data;
  }
}
