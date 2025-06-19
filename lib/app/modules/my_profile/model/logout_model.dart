class LogoutModel {
  String? message;
  String? type;
  bool? status;

  LogoutModel({this.message, this.type, this.status});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    type = json['type'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
