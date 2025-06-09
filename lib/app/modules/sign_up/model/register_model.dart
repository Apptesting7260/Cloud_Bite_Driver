class RegisterModel {
  String? type;
  String? message;
  bool? status;

  RegisterModel({this.type, this.message, this.status});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    message = json['message'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}