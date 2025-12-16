import '../core/app_exports.dart';
import '../utils/flavor_service.dart';

class AppUrls {
  static FlavorService get _flavorService =>
      Get.find<FlavorService>();

  static String get baseUrl => _flavorService.baseUrl;
  // static  String baseUrl = "https://qmt4f11v-8000.inc1.devtunnels.ms";
  // static  String baseUrl = 'http://15.207.201.245:8000'; // live url
  // static  String baseUrl = 'https://n86h3555-8000.inc1.devtunnels.ms'; // uttam sir
  // static  String baseUrl = 'https://21qkztxl-8000.inc1.devtunnels.ms';
  // static  String baseUrl = 'https://s1rjt67j-8000.inc1.devtunnels.ms';
  static  String imageUrl =
      "https://cloudbites.s3.af-south-1.amazonaws.com/";

  // Socket URL
  static  String socketURl = baseUrl;

  static  String verifyUser = "$baseUrl/driver/verifyUser";
  static  String allAddressUrl = "$baseUrl/driver/user-address";
  static  String addNewAddressUrl = "$baseUrl/driver/add-user-address";
  static  String registerAPI = '$baseUrl/driver/register';
  static  String resendOTPAPI = '$baseUrl/driver/resend';
  static  String listDeliveryMethodAPI =
      '$baseUrl/driver/ListDeliveryMethod';
  static  String selectDeliveryMethodAPI =
      '$baseUrl/driver/setDeliveryModel';
  static  String documentListAPI = '$baseUrl/driver/Listdocs';
  static  String listPersonalDocument =
      '$baseUrl/driver/list_personal_documents';
  static  String vehicleDetailsUploadAPI = '$baseUrl/driver/vehicle';
  static  String profilePhotoUploadAPI =
      '$baseUrl/driver/personalUploads/profile_photo';
  static  String identityPhotoUploadAPI =
      '$baseUrl/driver/personalUploads/identity';
  static  String licensePhotoUploadAPI =
      '$baseUrl/driver/personalUploads/license';
  static  String bankDetailsUploadAPI = '$baseUrl/driver/driver-account';
  static  String driverPaymentDetailsAPI = '$baseUrl/driver-add-payment-detail';
  static  String driverTotalDeliveryAPI = '$baseUrl/driver-total-delivery';
  static  String deliveriesOnSpecificDateAPI =
      '$baseUrl/deliveries-on-specific-date';
  static  String getDriverDataAPI = '$baseUrl/driver/fetchingDriver';
  static  String getPaymentMethodAPI = '$baseUrl/driver-get-payment-method';
  static  String loginAPI = '$baseUrl/driver/login';
  static  String editProfile = '$baseUrl/driver/editProfile';
  static  String finalPhaseAPI = '$baseUrl/driver/finalPhase';
  static  String forgetPasswordAPI = '$baseUrl/driver/forgetPassword';
  static  String forgetPasswordPhoneUrl = '$baseUrl/driver-forget-password-phone';
  static  String verifyOTPForgetPassword =
      '$baseUrl/driver/verifyPassword';
  static  String changeForgetPassword = '$baseUrl/driver/changePassword';
  static  String homeStage = '$baseUrl/driver/forgetStage';
  static  String logoutAPI = '$baseUrl/driver/logout';
  static  String contactSupportAPI = '$baseUrl/driver/support';
  static  String socialLoginAPI = '$baseUrl/driver/socialLogin';
  static  String notificationSetAPI = '$baseUrl/driver/SetNotify';
  static  String deliveryRatingsAPI =
      '$baseUrl/driver/delivery-and-rating';
  static  String ratingAPI = '$baseUrl/driver/rating';
  static  String faqUrlAPI = '$baseUrl/driver/faq';
  static  String allNotificationUrl = '$baseUrl/driver/getAllNotification';
  static  String getWalletDetailUrl = '$baseUrl/get-wallet-detail';
  static  String withdrawMethodsUrl = '$baseUrl/withdraw-methods';
  static  String driverWithdrawRequestUrl =
      '$baseUrl/driver-withdraw-request';
  static  String driverWithdrawTransactionUrl =
      '$baseUrl/driver-withdraw-transaction';
  static  String driverEarningsUrl = '$baseUrl/driver-earning';
  static  String totalDeliveriesUrl = '$baseUrl/driver-total-delivery';

  static  String signupVerifyContinueWithoutOtp =
      '$baseUrl/driver-signup-without-verification';
  static  String phoneLoginAPI = '$baseUrl/login-by-phone';
  static  String getPaymentDetailAPI = '$baseUrl/get-payment-detail';
}
