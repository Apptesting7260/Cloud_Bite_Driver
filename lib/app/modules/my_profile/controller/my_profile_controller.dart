import 'package:cloud_bites_driver/app/core/app_exports.dart';

class MyProfileController extends GetxController{

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  getLogoutAPI() async{
    LoadingOverlay().showLoading();

    final data = {
      "id": storageServices.getToken()
    };

    try{
      final apiData = await _repository.logoutAPI(data);
      if(apiData.status == true){
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog("Account Logout Data get", "logout account data get");
        storageServices.removeToken();
        Get.toNamed(Routes.welcome);
      } else{
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get logout account data", "error while logout account ");
      }

    } catch(e){
      LoadingOverlay().hideLoading();
      WidgetDesigns.consoleLog(e.toString(), "error while logout data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
  }
}