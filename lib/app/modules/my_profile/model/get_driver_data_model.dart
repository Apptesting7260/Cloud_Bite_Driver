class GetDriverDataModel {
  String? message;
  bool? status;
  DriverData? data;

  GetDriverDataModel({this.message, this.status, this.data});

  GetDriverDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new DriverData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DriverData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? password;
  String? loginToken;
  String? otp;
  bool? otpVerified;
  String? otpExpiresAt;
  String? emailOtp;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;
  String? stages;
  String? location;
  String? fcmToken;
  String? dateOfBirth;
  int? deliverymethod;
  String? profilePhoto;
  String? frontIdentity;
  String? backIdentity;
  String? frontLicense;
  String? backLicense;
  String? accountStatus;
  String? personalDocsStatus;
  String? vehicleStatus;
  String? latitude;
  String? longitude;

  DriverData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.countryCode,
        this.password,
        this.loginToken,
        this.otp,
        this.otpVerified,
        this.otpExpiresAt,
        this.emailOtp,
        this.emailVerified,
        this.createdAt,
        this.updatedAt,
        this.stages,
        this.location,
        this.fcmToken,
        this.dateOfBirth,
        this.deliverymethod,
        this.profilePhoto,
        this.frontIdentity,
        this.backIdentity,
        this.frontLicense,
        this.backLicense,
        this.accountStatus,
        this.personalDocsStatus,
        this.vehicleStatus,
        this.latitude,
        this.longitude});

  DriverData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    password = json['password'];
    loginToken = json['login_token'];
    otp = json['otp'].toString();
    otpVerified = json['otp_verified'];
    otpExpiresAt = json['otp_expires_at'];
    emailOtp = json['email_otp'].toString();
    emailVerified = json['email_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stages = json['stages'];
    location = json['location'];
    fcmToken = json['fcm_token'];
    dateOfBirth = json['date_of_birth'];
    deliverymethod = json['deliverymethod'];
    profilePhoto = json['profile_photo'];
    frontIdentity = json['front_identity'].toString();
    backIdentity = json['back_identity'].toString();
    frontLicense = json['front_license'].toString();
    backLicense = json['back_license'].toString();
    accountStatus = json['account_status'];
    personalDocsStatus = json['personal_docs_status'];
    vehicleStatus = json['vehicle_status'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['password'] = this.password;
    data['login_token'] = this.loginToken;
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['otp_expires_at'] = this.otpExpiresAt;
    data['email_otp'] = this.emailOtp;
    data['email_verified'] = this.emailVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stages'] = this.stages;
    data['location'] = this.location;
    data['fcm_token'] = this.fcmToken;
    data['date_of_birth'] = this.dateOfBirth;
    data['deliverymethod'] = this.deliverymethod;
    data['profile_photo'] = this.profilePhoto;
    data['front_identity'] = this.frontIdentity;
    data['back_identity'] = this.backIdentity;
    data['front_license'] = this.frontLicense;
    data['back_license'] = this.backLicense;
    data['account_status'] = this.accountStatus;
    data['personal_docs_status'] = this.personalDocsStatus;
    data['vehicle_status'] = this.vehicleStatus;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
