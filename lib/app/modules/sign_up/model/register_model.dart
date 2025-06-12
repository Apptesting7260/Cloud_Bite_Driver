class RegisterModel {
  String? type;
  String? message;
  bool? status;
  String? stage;

  RegisterModel({this.type, this.message, this.status, this.stage});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    status = json['status'];
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['status'] = this.status;
    data['stage'] = this.stage;
    return data;
  }
}
