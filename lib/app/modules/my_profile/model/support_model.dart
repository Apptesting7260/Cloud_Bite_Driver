class SupportModel {
  bool? status;
  String? message;
  SupportData? data;
  String? type;

  SupportModel({this.status, this.message, this.data, this.type});

  SupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SupportData.fromJson(json['data']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class SupportData {
  String? id;
  String? userId;
  String? type;
  String? name;
  String? email;
  String? phone;
  String? message;
  String? status;
  String? createdAt;
  String? updatedAt;

  SupportData(
      {this.id,
        this.userId,
        this.type,
        this.name,
        this.email,
        this.phone,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt});

  SupportData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    type = json['type'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    message = json['message'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['type'] = type;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['message'] = message;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
