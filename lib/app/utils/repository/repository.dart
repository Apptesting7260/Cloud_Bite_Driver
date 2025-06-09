import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/sign_up/model/register_model.dart';


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
    print("Bearer ${storageService.getToken()}");
    return GetVerifyOTPSucessModel.fromJson(response);
  }

  // Register API
  Future<RegisterModel> registerDriverAPI(Map<String, dynamic> data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.registerAPI, "Bearer ${storageService.getToken()}");
    return RegisterModel.fromJson(response);
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