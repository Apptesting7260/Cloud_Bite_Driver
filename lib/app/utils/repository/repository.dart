import 'package:cloud_bites_driver/app/core/app_exports.dart';


class Repository {

  final _apiService = NetworkApiServices();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageService => _storageService;

  // Phone Number Generate
  Future<GetOTPModel> getPhoneOTPAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    final authHeader = token.isNotEmpty
        ? "Bearer $token"
        : "";
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, authHeader);
    return GetOTPModel.fromJson(response);
  }

  // Phone Number Verify
  Future<GetVerifyOTPSucessModel> verifyOTpForPhone(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "Bearer $token");
    print("Bearer ${storageService.getToken()}");
    return GetVerifyOTPSucessModel.fromJson(response);
  }

  // Email Generate
  Future<GetEmailOTPModel> getEmailOTPAPI(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    final authHeader = token.isNotEmpty
        ? "Bearer $token"
        : "";
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, authHeader);
    return GetEmailOTPModel.fromJson(response);
  }

  // Email Verify
  Future<GetVerifyOTPSucessModel> verifyOTpForEmail(Map<String, dynamic> data) async {
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "Bearer $token");
    return GetVerifyOTPSucessModel.fromJson(response);
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

  // List Delivery Method API
  Future<DeliveryMethodModel> listDeliveryMethodAPI() async {
    final token = storageService.getToken();
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token");
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
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token");
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
    final token = storageService.getToken();
    dynamic response = await _apiService.postApi(data, AppUrls.loginAPI, "");
    return LoginWithEmailModel.fromJson(response);
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
}