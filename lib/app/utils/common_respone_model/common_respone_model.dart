class CommonResponseModel {
  bool? status;
  String? message;
  String? stage;
  String? type;

  CommonResponseModel({this.status, this.message, this.stage});

  CommonResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    stage = json['stage']?.toString();
    type = json['type']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['stage'] = stage;
    data['type'] = type;
    return data;
  }
}