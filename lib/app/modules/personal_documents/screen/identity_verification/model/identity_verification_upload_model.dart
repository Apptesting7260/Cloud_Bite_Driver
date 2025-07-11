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
    data = json['data'] != null ? new IdentityUploadData.fromJson(json['data']) : null;
    status = json['status'];
    allVerified = json['all_verified'];
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['all_verified'] = this.allVerified;
    data['type'] = this.type;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front_identity'] = this.frontIdentity;
    data['back_identity'] = this.backIdentity;
    return data;
  }
}
