class LoginPhoneGenerateModel {
  String? type;
  bool? status;
  String? message;
  String? otp;
  String? id;

  LoginPhoneGenerateModel({this.type, this.status,this.id, this.message, this.otp});

  LoginPhoneGenerateModel.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    status = json['status'];
    id = json['id'].toString();
    message = json['message']?.toString();
    otp = json['otp']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['status'] = status;
    data['message'] = message;
    data['otp'] = otp;
    data['id'] = id;
    return data;
  }
}

