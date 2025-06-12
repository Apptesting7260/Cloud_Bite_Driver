import 'package:cloud_bites_driver/app/core/app_exports.dart';


class Repository {

  final _apiService = NetworkApiServices();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageService => _storageService;

  // Phone Number Generate
  Future<GetOTPModel> getPhoneOTPAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, '');
    return GetOTPModel.fromJson(response);
  }

  // Phone Number Verify
  Future<GetVerifyOTPSucessModel> verifyOTpForPhone(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "Bearer ${storageService.getToken()}");
    print("Bearer ${storageService.getToken()}");
    return GetVerifyOTPSucessModel.fromJson(response);
  }

  // Email Generate
  Future<GetEmailOTPModel> getEmailOTPAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "Bearer ${storageService.getToken()}");
    return GetEmailOTPModel.fromJson(response);
  }

  // Email Verify
  Future<GetVerifyOTPSucessModel> verifyOTpForEmail(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.verifyUser, "Bearer ${storageService.getToken()}");
    return GetVerifyOTPSucessModel.fromJson(response);
  }

  // Register API
  Future<RegisterModel> registerDriverAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.registerAPI, "Bearer ${storageService.getToken()}");
    return RegisterModel.fromJson(response);
  }

  // Resend OTP
  Future<ResendModel> resendOTPAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.resendOTPAPI, "Bearer ${storageService.getToken()}");
    return ResendModel.fromJson(response);
  }

  // List Delivery Method API
  Future<DeliveryMethodModel> listDeliveryMethodAPI() async {
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token");
    dynamic response = await _apiService.getApi(AppUrls.listDeliveryMethodAPI, "Bearer ${storageService.getToken()}");
    return DeliveryMethodModel.fromJson(response);
  }

  // Select Delivery Method API
  Future<SetDeliveryMethodModel> setDeliveryMethodAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.selectDeliveryMethodAPI, "Bearer ${storageService.getToken()}");
    return SetDeliveryMethodModel.fromJson(response);
  }


  //Get List Of Documents API
  Future<DocumentListModel> documentsListAPI() async {
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token");
    dynamic response = await _apiService.getApi(AppUrls.documentListAPI, "Bearer ${storageService.getToken()}");
    return DocumentListModel.fromJson(response);
  }

  // Get List of Personal Document API
  Future<ListPersonalDocumentModel> listPersonalDocumentAPI() async {
    WidgetDesigns.consoleLog(storageService.getToken(), "Bearer Token");
    dynamic response = await _apiService.getApi(AppUrls.listPersonalDocument, "Bearer ${storageService.getToken()}");
    return ListPersonalDocumentModel.fromJson(response);
  }

  // Vehicle Details Upload API
  Future<VehicleDetailsUploadModel> uploadVehicleDetailsAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    dynamic response = await _apiService.postApiMultiPart(AppUrls.vehicleDetailsUploadAPI, "Bearer ${storageService.getToken()}", fields, files);
    return VehicleDetailsUploadModel.fromJson(response);
  }

  // Bank Details Upload API
  Future<DriverAccountDetailsModel> uploadBankDetailsAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.bankDetailsUploadAPI, "Bearer ${storageService.getToken()}");
    return DriverAccountDetailsModel.fromJson(response);
  }

  // Profile Photo Upload API
  Future<ProfilePhotoUploadModel> uploadProfilePhotoAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    dynamic response = await _apiService.postApiMultiPart(AppUrls.profilePhotoUploadAPI, "Bearer ${storageService.getToken()}", fields, files);
    return ProfilePhotoUploadModel.fromJson(response);
  }

  // Identity Photo Upload API
  Future<UploadIdentityVerificationModel> uploadIdentityPhotoAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    dynamic response = await _apiService.postApiMultiPart(AppUrls.identityPhotoUploadAPI, "Bearer ${storageService.getToken()}", fields, files);
    return UploadIdentityVerificationModel.fromJson(response);
  }

  // License Photo Upload API
  Future<LicenseUploadModel> uploadLicensePhotoAPI(Map<String, String> fields, Map<String, dynamic> files) async {
    dynamic response = await _apiService.postApiMultiPart(AppUrls.licensePhotoUploadAPI, "Bearer ${storageService.getToken()}", fields, files);
    return LicenseUploadModel.fromJson(response);
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