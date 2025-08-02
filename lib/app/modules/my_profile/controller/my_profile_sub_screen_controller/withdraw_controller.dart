import 'package:cloud_bites_driver/app/core/app_exports.dart';

class WithdrawController extends GetxController{

  RxString walletController = "".obs;

  RxString balanceString = "".obs;

  RxString walletError = "".obs;

  final List<List<String>> amountGroups = [
    ['50', '100', '150'],
    ['500', '1000', '1500'],
  ];


}