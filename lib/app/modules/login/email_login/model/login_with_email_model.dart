class LoginWithEmailModel {
  String? type;
  bool? status;
  String? message;
  Data? data;

  LoginWithEmailModel({this.type, this.status, this.message, this.data});

  LoginWithEmailModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    status = json['status'];
    message = json['message'].toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
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
  String? accountStatus;
  String? personalDocsStatus;
  String? vehicleStatus;
  bool? profileComplete;
  String? address;
  bool? pushNotification;
  bool? emailNotification;
  bool? incomingDeliveries;
  bool? deliveryCompleted;
  bool? invoicesPayments;
  String? accountRejectRemark;
  String? personalRejectRemark;
  String? vehicleRejectRemark;
  bool? userStatus;
  String? googleId;
  String? facebookId;
  String? appleId;
  String? xId;
  String? loginType;

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
        this.vehicleStatus,
        this.profileComplete,
        this.address,
        this.pushNotification,
        this.emailNotification,
        this.incomingDeliveries,
        this.deliveryCompleted,
        this.invoicesPayments,
        this.accountRejectRemark,
        this.personalRejectRemark,
        this.vehicleRejectRemark,
        this.userStatus,
        this.googleId,
        this.facebookId,
        this.appleId,
        this.xId,
        this.loginType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    countryCode = json['country_code'];
    password = json['password'].toString();
    loginToken = json['login_token'].toString();
    otp = json['otp'].toString();
    otpVerified = json['otp_verified'];
    otpExpiresAt = json['otp_expires_at'];
    emailOtp = json['email_otp'].toString();
    emailVerified = json['email_verified'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    stages = json['stages'].toString();
    location = json['location'].toString();
    fcmToken = json['fcm_token'].toString();
    dateOfBirth = json['date_of_birth'].toString();
    deliverymethod = json['deliverymethod'].toString();
    profilePhoto = json['profile_photo'].toString();
    frontIdentity = json['front_identity'].toString();
    backIdentity = json['back_identity'].toString();
    frontLicense = json['front_license'].toString();
    backLicense = json['back_license'].toString();
    accountStatus = json['account_status'];
    personalDocsStatus = json['personal_docs_status'];
    vehicleStatus = json['vehicle_status'];
    profileComplete = json['profile_complete'];
    address = json['address'].toString();
    pushNotification = json['push_notification'];
    emailNotification = json['email_notification'];
    incomingDeliveries = json['incoming_deliveries'];
    deliveryCompleted = json['delivery_completed'];
    invoicesPayments = json['invoices_payments'];
    accountRejectRemark = json['account_reject_remark'];
    personalRejectRemark = json['personal_reject_remark'];
    vehicleRejectRemark = json['vehicle_reject_remark'];
    userStatus = json['user_status'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    appleId = json['apple_id'];
    xId = json['x_id'];
    loginType = json['login_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['password'] = password;
    data['login_token'] = loginToken;
    data['otp'] = otp;
    data['otp_verified'] = otpVerified;
    data['otp_expires_at'] = otpExpiresAt;
    data['email_otp'] = emailOtp;
    data['email_verified'] = emailVerified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['stages'] = stages;
    data['location'] = location;
    data['fcm_token'] = fcmToken;
    data['date_of_birth'] = dateOfBirth;
    data['deliverymethod'] = deliverymethod;
    data['profile_photo'] = profilePhoto;
    data['front_identity'] = frontIdentity;
    data['back_identity'] = backIdentity;
    data['front_license'] = frontLicense;
    data['back_license'] = backLicense;
    data['account_status'] = accountStatus;
    data['personal_docs_status'] = personalDocsStatus;
    data['vehicle_status'] = vehicleStatus;
    data['profile_complete'] = profileComplete;
    data['address'] = address;
    data['push_notification'] = pushNotification;
    data['email_notification'] = emailNotification;
    data['incoming_deliveries'] = incomingDeliveries;
    data['delivery_completed'] = deliveryCompleted;
    data['invoices_payments'] = invoicesPayments;
    data['account_reject_remark'] = accountRejectRemark;
    data['personal_reject_remark'] = personalRejectRemark;
    data['vehicle_reject_remark'] = vehicleRejectRemark;
    data['user_status'] = userStatus;
    data['google_id'] = googleId;
    data['facebook_id'] = facebookId;
    data['apple_id'] = appleId;
    data['x_id'] = xId;
    data['login_type'] = loginType;
    return data;
  }
}
