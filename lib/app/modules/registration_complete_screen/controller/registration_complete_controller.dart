import 'package:cloud_bites_driver/app/core/app_exports.dart';

class RegistrationCompleteController extends GetxController{
  var isLoading = true.obs;

  @override
  void onInit() {
    getAccountStatusData();
    getHomeStage();
    super.onInit();
  }

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();

  Rx<ApiResponse<AccountStatusModel>> accountStatusData = Rx<ApiResponse<AccountStatusModel>>(ApiResponse.loading());
  setAccountStatusData(ApiResponse<AccountStatusModel> value){
    accountStatusData.value = value;
  }

  getAccountStatusData() async{
    setAccountStatusData(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.getAccountStatusAPI();
      if(apiData.status == true){
        isLoading.value = false;
        WidgetDesigns.consoleLog("Account Status Data get", "get account status data");
        setAccountStatusData(ApiResponse.completed(apiData));
        storageServices.saveStages(apiData.stage.toString());
      } else{
        isLoading.value = false;
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get Account Status data", "error while get account status data");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while document list data", color: AppTheme.redText, tColor: AppTheme.white);
        setAccountStatusData(ApiResponse.error(apiData.message?.toString() ?? "Error while get data"));
      }

    } catch(e){
      isLoading.value = false;
      setAccountStatusData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get document list data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
  }


  //Final Home Stage
  Rx<ApiResponse<HomeStageModel>> finalStageData = Rx<ApiResponse<HomeStageModel>>(ApiResponse.loading());
  setHomeStage(ApiResponse<HomeStageModel> value){
    finalStageData.value = value;
  }

  getHomeStage() async{
    setHomeStage(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.getHomeStage();
      if(apiData.status == true){
        isLoading.value = false;
        WidgetDesigns.consoleLog("Account Status Data get", "get account status data");
        setHomeStage(ApiResponse.completed(apiData));
        storageServices.saveStages(apiData.stages.toString());
        Get.toNamed(Routes.homeScreen);
      } else{
        isLoading.value = false;
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get Account Status data", "error while get account status data");
        setHomeStage(ApiResponse.error(apiData.message?.toString() ?? "Error while get data"));
      }

    } catch(e){
      isLoading.value = false;
      setAccountStatusData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get document list data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
  }

  void showRejectionDialog(String remarks) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          "Rejection Reason",
          style: AppFontStyle.text_18_500(AppTheme.black),
        ),
        content: Text(
          remarks,
          style: TextStyle(color: AppTheme.black.withOpacity(0.3), fontWeight: FontWeight.w400, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "OK",
              style: AppFontStyle.text_14_500(AppTheme.primaryColor),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

}