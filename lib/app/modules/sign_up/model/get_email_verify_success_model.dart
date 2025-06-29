class GetVerifyOTPSucessModel {
  String? type;
  String? message;
  Data? data;
  bool? status;

  GetVerifyOTPSucessModel({this.type, this.message, this.data, this.status});

  GetVerifyOTPSucessModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? id;
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
  String? deliverymethod;
  String? profilePhoto;
  String? frontIdentity;
  String? backIdentity;
  String? frontLicense;
  String? backLicense;
  bool? accountStatus;
  bool? personalDocsStatus;
  bool? vehicleStatus;

  Data(
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
        this.vehicleStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    countryCode = json['country_code'].toString();
    password = json['password'].toString();
    loginToken = json['login_token'].toString();
    otp = json['otp'].toString();
    otpVerified = json['otp_verified'];
    otpExpiresAt = json['otp_expires_at'].toString();
    emailOtp = json['email_otp'].toString();
    emailVerified = json['email_verified'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    stages = json['stages'].toString().toString();
    location = json['location'].toString();
    fcmToken = json['fcm_token'].toString();
    dateOfBirth = json['date_of_birth'].toString();
    deliverymethod = json['deliverymethod'].toString();
    profilePhoto = json['profile_photo'].toString();
    frontIdentity = json['front_identity'].toString();
    backIdentity = json['back_identity'].toString();
    frontLicense = json['front_license'].toString();
    backLicense = json['back_license'].toString();
    /*accountStatus = json['account_status'];
    personalDocsStatus = json['personal_docs_status'];
    vehicleStatus = json['vehicle_status'];*/
    accountStatus = json['account_status'] is bool
        ? json['account_status']
        : (json['account_status'] == 'true' || json['account_status'] == 'verified');
    personalDocsStatus = json['personal_docs_status'] is bool
        ? json['personal_docs_status']
        : (json['personal_docs_status'] == 'true' || json['personal_docs_status'] == 'verified');
    vehicleStatus = json['vehicle_status'] is bool
        ? json['vehicle_status']
        : (json['vehicle_status'] == 'true' || json['vehicle_status'] == 'verified');
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
    return data;
  }
}
