class VerifyForgetModel {
  String? message;
  bool? status;
  String? type;

  VerifyForgetModel({this.message, this.status, this.type});

  VerifyForgetModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    status = json['status'];
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['type'] = type;
    return data;
  }
}
