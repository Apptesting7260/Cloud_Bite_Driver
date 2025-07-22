class UploadIdentityVerificationModel {
  String? message;
  IdentityUploadData? data;
  bool? status;
  bool? allVerified;
  String? type;

  UploadIdentityVerificationModel(
      {this.message, this.data, this.status, this.allVerified, this.type});

  UploadIdentityVerificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    data = json['data'] != null ? IdentityUploadData.fromJson(json['data']) : null;
    status = json['status'];
    allVerified = json['all_verified'];
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['all_verified'] = allVerified;
    data['type'] = type;
    return data;
  }
}

class IdentityUploadData {
  String? frontIdentity;
  String? backIdentity;

  IdentityUploadData({this.frontIdentity, this.backIdentity});

  IdentityUploadData.fromJson(Map<String, dynamic> json) {
    frontIdentity = json['front_identity'].toString();
    backIdentity = json['back_identity'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_identity'] = frontIdentity;
    data['back_identity'] = backIdentity;
    return data;
  }
}
