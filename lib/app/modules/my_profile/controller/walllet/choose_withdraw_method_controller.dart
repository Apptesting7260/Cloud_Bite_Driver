

import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/payment_method_model.dart';

class ChooseWithdrawMethodController extends GetxController{

  RxString withdrawAmount = "0".obs;
  RxString selectedMethod = "".obs;
  TextEditingController idController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    final args = Get.arguments;
    withdrawAmount.value = args['withdrawAmount'];
    getWithdrawMethods();
    super.onInit();
  }

  Rx<ApiResponse<PaymentMethodModel>> withdrawMethodsData = Rx<ApiResponse<PaymentMethodModel>>(ApiResponse.loading());

  setMethodsData(ApiResponse<PaymentMethodModel> value){
    withdrawMethodsData.value = value;
  }

  Repository repository = Repository();

  getWithdrawMethods() async {

    try{
      setMethodsData(ApiResponse.loading());
      final response = await repository.withdrawMethodAPI(
        {
          "amount": withdrawAmount.value
        }
      );
      if(response.status == true){
        setMethodsData(ApiResponse.completed(response));
        WidgetDesigns.consoleLog("withdraw methods fetched success", "withdraw");
      }else{
        setMethodsData(ApiResponse.error(response.message));
        WidgetDesigns.consoleLog("withdraw methods fetched error>> ${response.message}", "withdraw else error");
      }
    } catch(e){
      WidgetDesigns.consoleLog("withdraw methods fetched error>> $e", "withdraw catch error");
      setMethodsData(ApiResponse.error(e.toString()));
    }

  }


  // RxBool isLoading = false.obs;

  sendWithdrawRequest() async {

    try{
      LoadingOverlay().showLoading();
      final response = await repository.driverWithdrawRequestAPI(
          selectedMethod.value != "2"
          ? {
            "amount": withdrawAmount.value,
            "withdrawMethodId": selectedMethod.value,
            "paymentNumber": idController.text,
          }
          : {
            "amount": withdrawAmount.value,
            "withdrawMethodId": selectedMethod.value,
          }
      );
      if(response.status == true){
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: "Withdraw Request Sent Successfully",color: AppTheme.green);
        WidgetDesigns.consoleLog("withdraw methods fetched success", "withdraw");
        Get.back();
      }else{
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog("withdraw methods fetched error>> ${response.message}", "withdraw else error");
      }
    } catch(e){
      LoadingOverlay().hideLoading();
      WidgetDesigns.consoleLog("withdraw methods fetched error>> $e", "withdraw catch error");
    }

  }



}