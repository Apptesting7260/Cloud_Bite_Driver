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
    data = json['data'] != null ? new DriverProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['location'] = this.location;
    data['profile_photo'] = this.profilePhoto;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['dob'] = this.dob;
    return data;
  }
}

