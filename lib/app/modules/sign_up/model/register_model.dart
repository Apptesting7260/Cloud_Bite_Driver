class RegisterModel {
  bool? status;
  String? type;
  String? message;
  RegisterData? data;
  String? loginToken;

  RegisterModel(
      {this.status, this.type, this.message, this.data, this.loginToken});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
    loginToken = json['login_token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['login_token'] = loginToken;
    return data;
  }
}

class RegisterData {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? password;
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

  RegisterData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.countryCode,
        this.password,
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
        this.userStatus});

  RegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    countryCode = json['country_code'].toString();
    password = json['password'].toString();
    otp = json['otp'].toString();
    otpVerified = json['otp_verified'];
    otpExpiresAt = json['otp_expires_at'];
    emailOtp = json['email_otp'];
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
    accountStatus = json['account_status'].toString();
    personalDocsStatus = json['personal_docs_status'].toString();
    vehicleStatus = json['vehicle_status'].toString();
    profileComplete = json['profile_complete'];
    address = json['address'];
    pushNotification = json['push_notification'];
    emailNotification = json['email_notification'];
    incomingDeliveries = json['incoming_deliveries'];
    deliveryCompleted = json['delivery_completed'];
    invoicesPayments = json['invoices_payments'];
    accountRejectRemark = json['account_reject_remark'].toString();
    personalRejectRemark = json['personal_reject_remark'].toString();
    vehicleRejectRemark = json['vehicle_reject_remark'].toString();
    userStatus = json['user_status'];
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
    return data;
  }
}
