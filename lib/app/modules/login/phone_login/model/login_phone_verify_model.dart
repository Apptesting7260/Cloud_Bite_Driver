class LoginPhoneVerifyModel {
  String? type;
  bool? status;
  String? message;
  LoginVerifyDataPhone? data;

  LoginPhoneVerifyModel({this.type, this.status, this.message, this.data});

  LoginPhoneVerifyModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    status = json['status'];
    message = json['message'].toString();
    data = json['data'] != null ? new LoginVerifyDataPhone.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginVerifyDataPhone {
  String? loginToken;
  String? otp;
  String? phone;
  String? firstName;
  String? lastName;
  String? stages;

  LoginVerifyDataPhone(
      {this.loginToken,
        this.otp,
        this.phone,
        this.firstName,
        this.lastName,
        this.stages});

  LoginVerifyDataPhone.fromJson(Map<String, dynamic> json) {
    loginToken = json['login_token'].toString();
    otp = json['otp'].toString();
    phone = json['phone'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    stages = json['stages'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_token'] = this.loginToken;
    data['otp'] = this.otp;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['stages'] = this.stages;
    return data;
  }
}
