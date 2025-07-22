class UpdateProfileModel {
  String? message;
  String? type;
  bool? status;
  DriverProfileData? data;

  UpdateProfileModel({this.message, this.type, this.status, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    type = json['type'].toString();
    status = json['status'];
    data = json['data'] != null ? DriverProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DriverProfileData {
  String? id;
  String? firstName;
  String? lastName;
  String? location;
  String? profilePhoto;
  String? email;
  String? phone;
  String? password;
  String? dob;

  DriverProfileData(
      {this.id,
        this.firstName,
        this.lastName,
        this.location,
        this.profilePhoto,
        this.email,
        this.phone,
        this.password,
        this.dob});

  DriverProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    location = json['location'].toString();
    profilePhoto = json['profile_photo'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    password = json['password'].toString();
    dob = json['dob'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['location'] = location;
    data['profile_photo'] = profilePhoto;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['dob'] = dob;
    return data;
  }
}

