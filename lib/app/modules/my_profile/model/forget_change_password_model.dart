class ForgetChangePasswordModel {
  String? type;
  bool? status;
  String? message;

  ForgetChangePasswordModel({this.type, this.status, this.message});

  ForgetChangePasswordModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    status = json['status'];
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
