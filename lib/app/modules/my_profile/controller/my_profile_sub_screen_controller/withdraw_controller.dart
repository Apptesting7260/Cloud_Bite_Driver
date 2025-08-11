import 'package:cloud_bites_driver/app/core/app_exports.dart';

class WithdrawController extends GetxController{

  RxString walletController = "".obs;

  RxString balanceString = "".obs;

  RxString walletError = "".obs;

  final List<List<String>> amountGroups = [
    ['50', '100', '150'],
    ['500', '1000', '1500'],
  ];

  @override
  void onInit() {
    super.onInit();
    getWalletBalanceApi();
  }

  final Repository _repository = Repository();
  RxString walletBalance = "".obs;

  getWalletBalanceApi() async {

    try{
      final apiData = await _repository.walletBalanceAPI();
      if(apiData.status == true){
        walletBalance.value = apiData.data?.wallet ?? "";
        WidgetDesigns.consoleLog("Wallet Balance Data get", "${apiData.data?.wallet}");
      } else{
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get wallet balance", "error while get wallet balance");
      }
    }catch(e){
      WidgetDesigns.consoleLog(e.toString(), "error while get wallet balance");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }

  }


}