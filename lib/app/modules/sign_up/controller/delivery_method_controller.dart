import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DeliveryMethodController extends GetxController{

  @override
  void onInit() {
    getDeliveryMethodsAPI();
    super.onInit();
  }

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;
  final Repository _repository = Repository();

  var selectedOptionIndex = "0".obs;

  void selectOption(String index) {
    selectedOptionIndex.value = index;
  }


  // Fetch Delivery Methods
  Rx<ApiResponse<DeliveryMethodModel>> deliveryMethodListData = Rx<ApiResponse<DeliveryMethodModel>>(ApiResponse.loading());
  setDeliveryMethods(ApiResponse<DeliveryMethodModel> value){
    deliveryMethodListData.value = value;
  }

  getDeliveryMethodsAPI() async{
    setDeliveryMethods(ApiResponse.loading());
    try{
      final apiData = await _repository.listDeliveryMethodAPI();
      if(apiData.status == true){
        WidgetDesigns.consoleLog("Delivery Methods get", "get delivery methods");
        setDeliveryMethods(ApiResponse.completed(apiData));
      } else{
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get dlivery methods", "error while get delivery methods");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while get data", color: AppTheme.redText, tColor: AppTheme.white);
        setDeliveryMethods(ApiResponse.error(apiData.message?.toString() ?? "Error while get data"));
      }

    } catch(e){
      setDeliveryMethods(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get starting page data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
  }

  // Set Delivery Methods
  Future<void> selectDeliveryMethodAPI() async {
    LoadingOverlay().showLoading();
    try {
      final selectedId = selectedOptionIndex.value;
      final data = {
        "deliveryId": selectedId,
      };

      final response = await _repository.setDeliveryMethodAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        storageServices.saveDeliveryID(selectedId);
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);

        Get.toNamed(Routes.documentVerificationScreen);
      }
      else if(response.status == false &&  response.type.toString() == "setDelivery"){
        LoadingOverlay().hideLoading();
        print(response.message);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Select Delivery Methods');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

}