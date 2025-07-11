class LicenseUploadModel {
  String? message;
  LicenseData? data;
  bool? status;
  bool? allVerified;
  String? type;

  LicenseUploadModel(
      {this.message, this.data, this.status, this.allVerified, this.type});

  LicenseUploadModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    data = json['data'] != null ? new LicenseData.fromJson(json['data']) : null;
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

class LicenseData {
  String? frontIdentity;
  String? backIdentity;

  LicenseData({this.frontIdentity, this.backIdentity});

  LicenseData.fromJson(Map<String, dynamic> json) {
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
