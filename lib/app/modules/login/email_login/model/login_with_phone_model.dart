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
    data = json['data'] != null ? LoginWithPhoneData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['status'] = status;
    data['message'] = message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['stages'] = stages;
    return data;
  }
}
