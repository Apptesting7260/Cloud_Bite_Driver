import 'package:cloud_bites_driver/app/core/app_exports.dart';

class BankDetailController extends GetxController{
  TextEditingController bankNameController = TextEditingController();
  TextEditingController acHolderNameController = TextEditingController();
  TextEditingController acNumberController = TextEditingController();
  TextEditingController reTypeController = TextEditingController();
  TextEditingController ifscNameController = TextEditingController();

  final DocumentVerificationController controller = Get.put(DocumentVerificationController());


  var bankNameError = ''.obs;
  updateBankNameError(String value) {
    bankNameError.value = value;
    update();
  }

  var accountHolderNameError = ''.obs;
  updateAcHolderNameError(String value) {
    accountHolderNameError.value = value;
    update();
  }

  var acNumberError = ''.obs;
  updateACNumberError(String value) {
    acNumberError.value = value;
    update();
  }

  var reTypeACError = ''.obs;
  updateReTypeError(String value) {
    reTypeACError.value = value;
    update();
  }

  var ifscError = ''.obs;
  updateIfscError(String value) {
    ifscError.value = value;
    update();
  }


  final RxString selectedAccountType = ''.obs;
  final List<String> accountTypes = [
    'Savings',
    'Current',
    'Salary'
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();

  Future<void> bankDetailsUploadAPI() async {

    updateBankNameError('');
    updateAcHolderNameError('');
    updateACNumberError('');
    updateReTypeError('');
    updateIfscError('');

    LoadingOverlay().showLoading();
    try{

      final data = {
        "bank_name": bankNameController.text,
        "account_holder_name": acHolderNameController.text,
        "account_number": acNumberController.text,
        "retype_account_number": reTypeController.text,
        "account_type": selectedAccountType.value,
        "ifsc_code": ifscNameController.text,
      };
      print("request $data");


      final response = await _repository.uploadBankDetailsAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.back();
      }
      else if(response.status == false && response.type == 'bank_name'){
        LoadingOverlay().hideLoading();
        updateBankNameError(response.message.toString());
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      }
      else if(response.status == false && response.type == 'account_holder_name'){
        LoadingOverlay().hideLoading();
        updateAcHolderNameError(response.message.toString());
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      }
      else if(response.status == false && response.type == 'account_number'){
        LoadingOverlay().hideLoading();
        updateACNumberError(response.message.toString());
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      }
      else if(response.status == false && response.type == 'retype_account_number'){
        LoadingOverlay().hideLoading();
        updateReTypeError(response.message.toString());
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      } else if(response.status == false && response.type == 'Account'){
        LoadingOverlay().hideLoading();
        updateReTypeError(response.message.toString());
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      }
      else if(response.status == false && response.type == 'ifsc_code'){
        LoadingOverlay().hideLoading();
        updateIfscError(response.message.toString());
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      }
      else {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Uploading Bank Details');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e,s){
      LoadingOverlay().hideLoading();
      print(e);
      print(s);
    }
  }


}