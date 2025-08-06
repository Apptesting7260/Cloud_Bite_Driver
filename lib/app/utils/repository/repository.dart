import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/login/phone_login/model/login_phone_verify_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/delivery_rating_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/earning_chart_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/rating_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/specific_date_delivery_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/total_delivery_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/transaction_history_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/wallet_balance_model.dart';
import 'package:cloud_bites_driver/app/utils/common_respone_model/common_respone_model.dart';

import '../../modules/my_profile/model/payment_method_model.dart';

class Repository {

  final _apiService = NetworkApiServices();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageService => _storageService;

  // Phone Number Generate
  Future<GetOtpModel > getPhoneOTPAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, '');
    return GetOtpModel .fromJson(response);
  }

  // Phone Number Verify
  Future<GetPhoneOtpVerify> verifyOTpForPhone(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "");
    return GetPhoneOtpVerify.fromJson(response);
  }

  Future<WalletBalanceModel> walletBalanceAPI() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.getApi(AppUrls.getWalletDetailUrl, "Bearer $token");
    return WalletBalanceModel.fromJson(response);
  }

  // Email Generate
  Future<GetOtpEmailModel> getEmailOTPAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, '');
    return GetOtpEmailModel.fromJson(response);
  }

  Future<PaymentMethodModel> withdrawMethodAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.withdrawMethodsUrl, token);
    return PaymentMethodModel.fromJson(response);
  }

  Future<VerifyEmailOtpModel> verifyOTpForEmail(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "");
    return VerifyEmailOtpModel.fromJson(response);
  }

  // Register API
  Future<RegisterModel> registerDriverAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.registerAPI, "Bearer $token");
    return RegisterModel.fromJson(response);
  }

  // Resend OTP
  Future<ResendModel> resendOTPAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.resendOTPAPI, "Bearer $token");
    return ResendModel.fromJson(response);
  }

  Future<CommonResponseModel> driverWithdrawRequestAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.driverWithdrawRequestUrl, "Bearer $token");
    return CommonResponseModel.fromJson(response);
  }

  Future<TransactionHistoryModel> driverWithdrawTransactionAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.driverWithdrawTransactionUrl, "Bearer $token");
    return TransactionHistoryModel.fromJson(response);
  }

  Future<EarningChartModel> earningAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.driverEarningsUrl, "Bearer $token");
    return EarningChartModel.fromJson(response);
  }

  // List Delivery Method API
  Future<DeliveryMethodModel> listDeliveryMethodAPI() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.getApi(AppUrls.listDeliveryMethodAPI, "Bearer $token");
    return DeliveryMethodModel.fromJson(response);
  }

  // Select Delivery Method API
  Future<SetDeliveryMethodModel> setDeliveryMethodAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.selectDeliveryMethodAPI, "Bearer $token");
    return SetDeliveryMethodModel.fromJson(response);
  }


  //Get List Of Documents API
  Future<DocumentListModel> documentsListAPI() async {
    final token = storageService.getToken();
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token");
    dynamic response = await _apiService.getApi(AppUrls.documentListAPI, "Bearer $token");
    return DocumentListModel.fromJson(response);
  }

  // Get List of Personal Document API
  Future<ListPersonalDocumentModel> listPersonalDocumentAPI() async {
    final token = storageService.getToken();
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token-------------");
    dynamic response = await _apiService.getApi(AppUrls.listPersonalDocument, "Bearer $token");
    return ListPersonalDocumentModel.fromJson(response);
  }

  // Vehicle Details Upload API
  Future<VehicleDetailsUploadModel> uploadVehicleDetailsAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApiMultiPart(AppUrls.vehicleDetailsUploadAPI, "Bearer $token", fields, files);
    return VehicleDetailsUploadModel.fromJson(response);
  }

  // Bank Details Upload API
  Future<DriverAccountDetailsModel> uploadBankDetailsAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.bankDetailsUploadAPI, "Bearer $token");
    return DriverAccountDetailsModel.fromJson(response);
  }

  Future<TotalDeliveryModel> totalDeliveriesAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.driverTotalDeliveryAPI, "Bearer $token");
    return TotalDeliveryModel.fromJson(response);
  }

  // Profile Photo Upload API
 Future<SpecificDateDeliveryModel> specificDateDeliveriesAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.deliveriesOnSpecificDateAPI, "Bearer $token");
    return SpecificDateDeliveryModel.fromJson(response);
  }

  // Profile Photo Upload API
  Future<ProfilePhotoUploadModel> uploadProfilePhotoAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApiMultiPart(AppUrls.profilePhotoUploadAPI, "Bearer $token", fields, files);
    return ProfilePhotoUploadModel.fromJson(response);
  }

  // Identity Photo Upload API
  Future<UploadIdentityVerificationModel> uploadIdentityPhotoAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApiMultiPart(AppUrls.identityPhotoUploadAPI, "Bearer $token", fields, files);
    return UploadIdentityVerificationModel.fromJson(response);
  }

  // License Photo Upload API
  Future<LicenseUploadModel> uploadLicensePhotoAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApiMultiPart(AppUrls.licensePhotoUploadAPI, "Bearer $token", fields, files);
    return LicenseUploadModel.fromJson(response);
  }

  // Get Driver Data API
  Future<GetDriverDataModel> getDriverDataAPI() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.getApi(AppUrls.getDriverDataAPI, "Bearer $token");
    return GetDriverDataModel.fromJson(response);
  }

  // Update Driver Profile API
  Future<UpdateProfileModel> updateDriverDetails(Map<String, String> fields, Map<String, dynamic> files) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApiMultiPart(AppUrls.editProfile, "Bearer $token", fields, files);
    return UpdateProfileModel.fromJson(response);
  }

  // Login With Email API
  Future<LoginWithEmailModel> emailLoginAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.loginAPI, '');
    return LoginWithEmailModel.fromJson(response);
  }

  // Account Status API
  Future<AccountStatusModel> getAccountStatusAPI() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.getApi(AppUrls.finalPhaseAPI, "Bearer $token");
    return AccountStatusModel.fromJson(response);
  }

  // Forget Password API
  Future<ForgetPasswordModel> forgetPasswordAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.forgetPasswordAPI, token);
    return ForgetPasswordModel.fromJson(response);
  }

  // Verify OTP For Forget Password
  Future<VerifyForgetModel> verifyOTPForPassword(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.verifyOTPForgetPassword, token);
    return VerifyForgetModel.fromJson(response);
  }

  // Set Password For Forget Password
  Future<ForgetSetPasswordModel> setPasswordForgetAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.verifyOTPForgetPassword, token);
    return ForgetSetPasswordModel.fromJson(response);
  }

  // Change Password For Forget Password
  Future<ForgetChangePasswordModel> changePasswordForgetAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.changeForgetPassword, token);
    return ForgetChangePasswordModel.fromJson(response);
  }

   // Phone Login API
  Future<LoginPhoneGenerateModel> phoneLoginGenerateAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.loginAPI, '');
    return LoginPhoneGenerateModel.fromJson(response);
  }

  // Verify Phone Login API
  Future<LoginPhoneVerifyModel> phoneLoginVerifyAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.loginAPI, "Bearer $token");
    return LoginPhoneVerifyModel.fromJson(response);
  }

  //Final Home Stage
  Future<HomeStageModel> getHomeStage() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.getApi(AppUrls.homeStage, "Bearer $token");
    return HomeStageModel.fromJson(response);
  }

  //Logout API
  Future<LogoutModel> logoutAPI() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.getApi(AppUrls.logoutAPI, "Bearer $token");
    return LogoutModel.fromJson(response);
  }

  //Support API
  Future<SupportModel> contactSupportAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data,AppUrls.contactSupportAPI, "Bearer $token");
    return SupportModel.fromJson(response);
  }

  // Social Login API
  Future<SocialLoginModel> socialLoginAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data,AppUrls.socialLoginAPI, "Bearer $token");
    return SocialLoginModel.fromJson(response);
  }

  // Get Notification Set Data
  Future<GetNotificationSetAPI> getNotificationSetData() async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi({}, AppUrls.notificationSetAPI, "Bearer $token");
    return GetNotificationSetAPI.fromJson(response);
  }

  // Update notification settings
  Future<SetNotificationSetAPI> updateNotificationSetData(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.notificationSetAPI, "Bearer $token");
    return SetNotificationSetAPI.fromJson(response);
  }

  Future<LocationResponse> addNewAddressApi(data) async {
    print(data);
    var response = await _apiService.postApi(data, AppUrls.addNewAddressUrl, storageService.getToken());
    return LocationResponse.fromJson(response);
  }

  Future<AllLocationResponse> fetchAddressApi() async {
    var response = await _apiService.getApi(AppUrls.allAddressUrl, "" );
    return AllLocationResponse.fromJson(response);
  }

  Future<DeliveryRatingModel> deliveryRatingAPI() async {
    final token = storageService.getToken();
    var response = await _apiService.getApi(AppUrls.deliveryRatingsAPI, "Bearer $token");
    return DeliveryRatingModel.fromJson(response);
  }

  /*Future<RatingModel> ratingAPI() async {
    final token = storageService.getToken();
    var response = await _apiService.getApi(AppUrls.ratingAPI, "Bearer $token");
    return RatingModel.fromJson(response);
  }*/
  Future<RatingModel> ratingAPI({int page = 1}) async {
    final token = storageService.getToken();
    var response = await _apiService.getApi(
        '${AppUrls.ratingAPI}?page=$page',
        "Bearer $token"
    );
    return RatingModel.fromJson(response);
  }

  Future<FaqModel> getFaqAPI() async {
    dynamic response = await _apiService.getApi(AppUrls.faqUrlAPI, storageService.getToken());
    return FaqModel.fromJson(response);
  }

  Future<NotificationResponseModel> notificationAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi2(data, AppUrls.allNotificationUrl, storageService.getToken());
    return NotificationResponseModel.fromJson(response);
  }

  Future<PrivacyPolicyModel> privacyPolicyApi() async {
    try {
      return PrivacyPolicyModel.fromUrl("${AppUrls.baseUrl}/get-page-message?type=privacyPolicy");
    } catch (e) {
      throw Exception('Failed to load privacy policy: $e');
    }
  }
  Future<PrivacyPolicyModel> termsConditionApi() async {
    try {
      return PrivacyPolicyModel.fromUrl("${AppUrls.baseUrl}/get-page-message?type=termsCondition");
    } catch (e) {
      throw Exception('Failed to load terms & conditions: $e');
    }
  }
}