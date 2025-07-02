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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['status'] = this.status;
    data['message'] = this.message;
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
    data['profile_complete'] = this.profileComplete;
    data['address'] = this.address;
    data['push_notification'] = this.pushNotification;
    data['email_notification'] = this.emailNotification;
    data['incoming_deliveries'] = this.incomingDeliveries;
    data['delivery_completed'] = this.deliveryCompleted;
    data['invoices_payments'] = this.invoicesPayments;
    data['account_reject_remark'] = this.accountRejectRemark;
    data['personal_reject_remark'] = this.personalRejectRemark;
    data['vehicle_reject_remark'] = this.vehicleRejectRemark;
    data['user_status'] = this.userStatus;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['apple_id'] = this.appleId;
    data['x_id'] = this.xId;
    data['login_type'] = this.loginType;
    return data;
  }
}
