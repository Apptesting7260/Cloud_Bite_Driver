class ProfilePhotoUploadModel {
  String? message;
  ProfilePhotoData? data;
  bool? status;
  bool? allVerified;
  String? type;

  ProfilePhotoUploadModel(
      {this.message, this.data, this.status, this.allVerified, this.type});

  ProfilePhotoUploadModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    data = json['data'] != null ? new ProfilePhotoData.fromJson(json['data']) : null;
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

class ProfilePhotoData {
  String? profilePhoto;

  ProfilePhotoData({this.profilePhoto});

  ProfilePhotoData.fromJson(Map<String, dynamic> json) {
    profilePhoto = json['profile_photo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}
