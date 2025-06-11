class PersonalDocumentUpload {
  String? message;
  DocumentUploadData? data;
  bool? status;
  String? type;

  PersonalDocumentUpload({this.message, this.data, this.status, this.type});

  PersonalDocumentUpload.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new DocumentUploadData.fromJson(json['data']) : null;
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['type'] = this.type;
    return data;
  }
}

class DocumentUploadData {
  String? profilePhoto;
  String? frontIdentity;
  String? backIdentity;
  String? frontLicense;
  String? backLicense;

  DocumentUploadData(
      {this.profilePhoto,
        this.frontIdentity,
        this.backIdentity,
        this.frontLicense,
        this.backLicense});

  DocumentUploadData.fromJson(Map<String, dynamic> json) {
    profilePhoto = json['profile_photo'].toString();
    frontIdentity = json['front_identity'].toString();
    backIdentity = json['back_identity'].toString();
    frontLicense = json['front_license'].toString();
    backLicense = json['back_license'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_photo'] = this.profilePhoto;
    data['front_identity'] = this.frontIdentity;
    data['back_identity'] = this.backIdentity;
    data['front_license'] = this.frontLicense;
    data['back_license'] = this.backLicense;
    return data;
  }
}
