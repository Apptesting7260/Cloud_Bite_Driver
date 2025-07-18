class LoginPhoneGenerateModel {
  String? type;
  bool? status;
  String? message;
  String? otp;

  LoginPhoneGenerateModel({this.type, this.status, this.message, this.otp});

  LoginPhoneGenerateModel.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    status = json['status'];
    message = json['message']?.toString();
    otp = json['otp']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}

