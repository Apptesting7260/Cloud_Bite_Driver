class PersonalDocumentUpload {
  String? message;
  DocumentUploadData? data;
  bool? status;
  String? type;

  PersonalDocumentUpload({this.message, this.data, this.status, this.type});

  PersonalDocumentUpload.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? DocumentUploadData.fromJson(json['data']) : null;
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['type'] = type;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_photo'] = profilePhoto;
    data['front_identity'] = frontIdentity;
    data['back_identity'] = backIdentity;
    data['front_license'] = frontLicense;
    data['back_license'] = backLicense;
    return data;
  }
}
