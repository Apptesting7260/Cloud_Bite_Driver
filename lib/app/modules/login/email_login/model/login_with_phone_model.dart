class LoginWithPhoneModel {
  String? type;
  bool? status;
  String? message;
  LoginWithPhoneData? data;

  LoginWithPhoneModel({this.type, this.status, this.message, this.data});

  LoginWithPhoneModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LoginWithPhoneData.fromJson(json['data']) : null;
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

class LoginWithPhoneData {
  String? otp;
  String? email;
  String? firstName;
  String? lastName;
  String? stages;

  LoginWithPhoneData({this.otp, this.email, this.firstName, this.lastName, this.stages});

  LoginWithPhoneData.fromJson(Map<String, dynamic> json) {
    otp = json['otp'].toString();
    email = json['email'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    stages = json['stages'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['stages'] = this.stages;
    return data;
  }
}
