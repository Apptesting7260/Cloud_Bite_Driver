import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/delivery_rating_model.dart';

class MyProfileController extends GetxController{

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getDeliveryAndRatingData();
    getWalletBalanceApi();
  }

  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  getLogoutAPI() async{
    LoadingOverlay().showLoading();

    try{
      final apiData = await _repository.logoutAPI();
      if(apiData.status == true){
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog("Account Logout Data get", "logout account data get");
        storageServices.clearAll();
        storageServices.removeToken();
        removeController();
        Get.offAllNamed(Routes.welcome);
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

  void removeController()async{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.find<SocketController>().socket.disconnect();

}

  Rx<ApiResponse<DeliveryRatingModel>> deliveryAndRatingData = Rx<ApiResponse<DeliveryRatingModel>>(ApiResponse.loading());
  setDeliveryAndRatingData(ApiResponse<DeliveryRatingModel> value){
    deliveryAndRatingData.value = value;
  }

  getDeliveryAndRatingData() async{
    setDeliveryAndRatingData(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.deliveryRatingAPI();
      if(apiData.status == true){
        isLoading.value = false;
        WidgetDesigns.consoleLog("Delivery Data get", "get deliveries and ratings data");
        setDeliveryAndRatingData(ApiResponse.completed(apiData));
      } else{
        isLoading.value = false;
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get delivery and rating data", "error while get delivery and rating data");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while get delivery and rating data", color: AppTheme.redText, tColor: AppTheme.white);
        setDeliveryAndRatingData(ApiResponse.error(apiData.message?.toString() ?? "Error while get delivery and rating data"));
      }

    } catch(e){
      isLoading.value = false;
      setDeliveryAndRatingData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get driver data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
    finally{
      isLoading.value = false;
    }
  }

  RxString walletBalance = "".obs;

  getWalletBalanceApi() async {

    try{
      final apiData = await _repository.walletBalanceAPI();
      if(apiData.status == true){
        walletBalance.value = apiData.data?.wallet ?? "";
        WidgetDesigns.consoleLog("Wallet Balance Data get", apiData.data?.wallet ?? "");
      } else{
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get wallet balance", "error while get wallet balance");
      }
    }catch(e){
      WidgetDesigns.consoleLog(e.toString(), "error while get wallet balance");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }

  }

}