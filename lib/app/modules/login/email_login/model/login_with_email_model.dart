class LoginWithEmailModel {
  String? type;
  bool? status;
  String? message;
  EmailLoginData? data;

  LoginWithEmailModel({this.type, this.status, this.message, this.data});

  LoginWithEmailModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? EmailLoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type.toString();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EmailLoginData {
  String? loginToken;
  String? email;
  String? firstName;
  String? lastName;
  String? stages;
  String? password;

  EmailLoginData(
      {this.loginToken,
        this.email,
        this.firstName,
        this.lastName,
        this.stages,
        this.password});

  EmailLoginData.fromJson(Map<String, dynamic> json) {
    loginToken = json['login_token'].toString();
    email = json['email']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    stages = json['stages']?.toString();
    password = json['password']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_token'] = loginToken;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['stages'] = stages;
    data['password'] = password;
    return data;
  }
}
