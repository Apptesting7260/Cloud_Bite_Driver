import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/routes/stage_navigator.dart';

class DeliveryMethodController extends GetxController{

  static const int deliveryCar = 1;
  static const int deliveryScooter = 2;
  static const int deliveryBicycle = 3;


  @override
  void onInit() {
    final token = storageServices.getToken();
    print("............$token...............In Get Delvery Method");
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
        storageServices.saveDeliveryID("${apiData.data?.first.id}");
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
    final token = storageServices.getToken();
    print("============$token=================In Set Delivery Method");
    LoadingOverlay().showLoading();
    try {
      final selectedId = selectedOptionIndex.value;
      final data = {
        "deliveryId": selectedId,
      };
      print("============$selectedId============");
      final response = await _repository.setDeliveryMethodAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        storageServices.saveDeliveryID(selectedId);
        if(selectedId == "1"){
          storageServices.saveDeliveryType("car");
        }else if(selectedId == "2"){
          storageServices.saveDeliveryType("bike");
        }else if(selectedId == "3"){
          storageServices.saveDeliveryType("foot");
        }
        WidgetDesigns.consoleLog(response.message.toString(), "");
        storageServices.saveStages(response.stage.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        StageNavigator.navigateToStage("${response.stage}");
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