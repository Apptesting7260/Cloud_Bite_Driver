import 'package:cloud_bites_driver/app/core/app_exports.dart';

class BankDetailController extends GetxController{
  TextEditingController bankNameController = TextEditingController();
  TextEditingController acHolderNameController = TextEditingController();
  TextEditingController acNumberController = TextEditingController();
  TextEditingController reTypeController = TextEditingController();
  TextEditingController ifscNameController = TextEditingController();

  final DocumentVerificationController controller = Get.put(DocumentVerificationController());

  var bankNameError = ''.obs;
  var accountHolderNameError = ''.obs;
  var acNumberError = ''.obs;
  var reTypeACError = ''.obs;
  var ifscError = ''.obs;

  updateBankNameError(String value) {
    bankNameError.value = value;
    update();
  }
  updateAcHolderNameError(String value) {
    accountHolderNameError.value = value;
    update();
  }
  updateACNumberError(String value) {
    acNumberError.value = value;
    update();
  }
  updateReTypeError(String value) {
    reTypeACError.value = value;
    update();
  }

  updateIfscError(String value) {
    ifscError.value = value;
    update();
  }


  final RxString selectedAccountType = ''.obs;
  final List<String> accountTypes = [
    'savings',
    'current',
    'salary'
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


      final response = await _repository.uploadBankDetailsAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.toNamed(Routes.documentVerificationScreen);
        controller.getDocumentListData();
      }
      else if(response.status == false && response.type == 'driver-account'){
        LoadingOverlay().hideLoading();
        updateBankNameError(response.message.toString());
        updateAcHolderNameError(response.message.toString());
        updateACNumberError(response.message.toString());
        updateReTypeError(response.message.toString());
        updateIfscError(response.message.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        WidgetDesigns.consoleLog(response.message.toString(), "Error when Uploading Bank Details");
      }
      else {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Uploading Bank Details');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
      print(e);
    }
  }


}