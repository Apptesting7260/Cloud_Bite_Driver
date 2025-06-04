import 'package:cloud_bites_driver/app/core/app_exports.dart';

class BankDetailController extends GetxController{
  TextEditingController bankNameController = TextEditingController();
  TextEditingController acHolderNameController = TextEditingController();
  TextEditingController acNumberController = TextEditingController();
  TextEditingController reTypeController = TextEditingController();
  TextEditingController ifscNameController = TextEditingController();

  final RxString selectedAccountType = ''.obs;
  final List<String> accountTypes = [
    'Savings',
    'Current',
    'Salary'
  ];
}