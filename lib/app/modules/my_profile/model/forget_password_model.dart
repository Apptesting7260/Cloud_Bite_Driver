class ForgetPasswordModel {
  String? type;
  bool? status;
  String? message;
  String? otp;
  String? email;

  ForgetPasswordModel(
      {this.type, this.status, this.message, this.otp, this.email});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    status = json['status'];
    message = json['message'].toString();
    otp = json['otp'].toString();
    email = json['email'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['status'] = status;
    data['message'] = message;
    data['otp'] = otp;
    data['email'] = email;
    return data;
  }
}
