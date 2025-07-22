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
    data = json['data'] != null ? ProfilePhotoData.fromJson(json['data']) : null;
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

class ProfilePhotoData {
  String? profilePhoto;

  ProfilePhotoData({this.profilePhoto});

  ProfilePhotoData.fromJson(Map<String, dynamic> json) {
    profilePhoto = json['profile_photo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_photo'] = profilePhoto;
    return data;
  }
}
