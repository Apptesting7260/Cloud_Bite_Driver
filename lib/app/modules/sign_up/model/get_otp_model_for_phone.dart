class GetOTPModel {
  String? type;
  String? otp;
  String? message;
  String? token;
  bool? status;

  GetOTPModel({this.type, this.otp, this.message, this.token, this.status});

  GetOTPModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    otp = json['otp'].toString();
    message = json['message'].toString();
    token = json['token'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['message'] = this.message;
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }
}
