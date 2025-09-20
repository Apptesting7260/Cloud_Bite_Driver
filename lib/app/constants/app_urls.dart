class AppUrls {
  static const String baseUrl = 'https://api.cloudbitesbw.com';
  // static const String baseUrl = "https://qmt4f11v-8000.inc1.devtunnels.ms";
  // static const String baseUrl = 'http://15.207.201.245:8000'; // live url
  // static const String baseUrl = 'https://n86h3555-8000.inc1.devtunnels.ms'; // uttam sir
  // static const String baseUrl = 'https://21qkztxl-8000.inc1.devtunnels.ms';
  // static const String baseUrl = 'https://s1rjt67j-8000.inc1.devtunnels.ms';
  static const String imageUrl =
      "https://cloudbites.s3.af-south-1.amazonaws.com/";

  // Socket URL
  static const String socketURl = baseUrl;

  static const String verifyUser = "$baseUrl/driver/verifyUser";
  static const String allAddressUrl = "$baseUrl/driver/user-address";
  static const String addNewAddressUrl = "$baseUrl/driver/add-user-address";
  static const String registerAPI = '$baseUrl/driver/register';
  static const String resendOTPAPI = '$baseUrl/driver/resend';
  static const String listDeliveryMethodAPI =
      '$baseUrl/driver/ListDeliveryMethod';
  static const String selectDeliveryMethodAPI =
      '$baseUrl/driver/setDeliveryModel';
  static const String documentListAPI = '$baseUrl/driver/Listdocs';
  static const String listPersonalDocument =
      '$baseUrl/driver/list_personal_documents';
  static const String vehicleDetailsUploadAPI = '$baseUrl/driver/vehicle';
  static const String profilePhotoUploadAPI =
      '$baseUrl/driver/personalUploads/profile_photo';
  static const String identityPhotoUploadAPI =
      '$baseUrl/driver/personalUploads/identity';
  static const String licensePhotoUploadAPI =
      '$baseUrl/driver/personalUploads/license';
  static const String bankDetailsUploadAPI = '$baseUrl/driver/driver-account';
  static const String driverTotalDeliveryAPI = '$baseUrl/driver-total-delivery';
  static const String deliveriesOnSpecificDateAPI =
      '$baseUrl/deliveries-on-specific-date';
  static const String getDriverDataAPI = '$baseUrl/driver/fetchingDriver';
  static const String loginAPI = '$baseUrl/driver/login';
  static const String editProfile = '$baseUrl/driver/editProfile';
  static const String finalPhaseAPI = '$baseUrl/driver/finalPhase';
  static const String forgetPasswordAPI = '$baseUrl/driver/forgetPassword';
  static const String verifyOTPForgetPassword =
      '$baseUrl/driver/verifyPassword';
  static const String changeForgetPassword = '$baseUrl/driver/changePassword';
  static const String homeStage = '$baseUrl/driver/forgetStage';
  static const String logoutAPI = '$baseUrl/driver/logout';
  static const String contactSupportAPI = '$baseUrl/driver/support';
  static const String socialLoginAPI = '$baseUrl/driver/socialLogin';
  static const String notificationSetAPI = '$baseUrl/driver/SetNotify';
  static const String deliveryRatingsAPI =
      '$baseUrl/driver/delivery-and-rating';
  static const String ratingAPI = '$baseUrl/driver/rating';
  static const String faqUrlAPI = '$baseUrl/driver/faq';
  static const String allNotificationUrl = '$baseUrl/driver/getAllNotification';
  static const String getWalletDetailUrl = '$baseUrl/get-wallet-detail';
  static const String withdrawMethodsUrl = '$baseUrl/withdraw-methods';
  static const String driverWithdrawRequestUrl =
      '$baseUrl/driver-withdraw-request';
  static const String driverWithdrawTransactionUrl =
      '$baseUrl/driver-withdraw-transaction';
  static const String driverEarningsUrl = '$baseUrl/driver-earning';
  static const String totalDeliveriesUrl = '$baseUrl/driver-total-delivery';
}
