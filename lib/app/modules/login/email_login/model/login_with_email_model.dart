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
    data = json['data'] != null ? new EmailLoginData.fromJson(json['data']) : null;
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

class EmailLoginData {
  String? loginToken;
  String? email;
  Null? firstName;
  Null? lastName;
  String? stages;
  Null? password;

  EmailLoginData(
      {this.loginToken,
        this.email,
        this.firstName,
        this.lastName,
        this.stages,
        this.password});

  EmailLoginData.fromJson(Map<String, dynamic> json) {
    loginToken = json['login_token'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    stages = json['stages'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_token'] = this.loginToken;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['stages'] = this.stages;
    data['password'] = this.password;
    return data;
  }
}
