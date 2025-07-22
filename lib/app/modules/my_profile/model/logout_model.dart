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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}
