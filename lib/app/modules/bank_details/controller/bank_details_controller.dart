import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/bank_details/model/payment_detail_model.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/controller/my_profile_sub_screen_controller/payment_method_controller.dart';

class BankDetailController extends GetxController{
  TextEditingController bankNameController = TextEditingController();
  TextEditingController acHolderNameController = TextEditingController();
  TextEditingController acNumberController = TextEditingController();
  TextEditingController reTypeController = TextEditingController();
  TextEditingController ifscNameController = TextEditingController();
  TextEditingController pay2cellNumberController = TextEditingController();
  TextEditingController orangeMoneyController = TextEditingController();

  var selectedPaymentMethod = RxInt(-1);
  var methodId = "".obs;
  var ids;
var paymentData = PaymentDetailsModel().obs;
  final DocumentVerificationController controller = Get.put(DocumentVerificationController());

@override
  void onInit() {
ids= Get.arguments['ids'] ?? [];
    super.onInit();
    getPaymentMethodApi();
  }
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
  LoadingOverlay loadingOverlay = LoadingOverlay();
var isLoading = false.obs;
  final Repository _repository = Repository();
   getPaymentMethodApi()async{
     isLoading.value = true;
     // LoadingOverlay().showLoading();
     try{
  await   _repository.getPaymentMethodApi().then((value) {
       if(value.status == true){
       paymentData.value = value;
       }else{
         paymentData.value = PaymentDetailsModel();
       }
     });}catch (e){
       print(e);
     }finally{
        isLoading.value = false;
        // LoadingOverlay().hideLoading();
     }
   }

  Future<void> bankDetailsUploadAPI() async {

    updateBankNameError('');
    updateAcHolderNameError('');
    updateACNumberError('');
    updateReTypeError('');
    updateIfscError('');

    LoadingOverlay().showLoading();
    try{

      final data =methodId.value=="2"? {
        "method_id": methodId.value,
        "bank_name": bankNameController.text,
        "account_holder_name": acHolderNameController.text,
        "account_number": acNumberController.text,
        "retype_account_number": reTypeController.text,
        "account_type": selectedAccountType.value,
        "ifsc_code": ifscNameController.text,
      }: methodId.value=="4"?{
        "method_id": methodId.value,
        "pay2cell_number": pay2cellNumberController.text,
      }:
    methodId.value=="1"?
      {
        "method_id": methodId.value,
        "orangemoney_number": orangeMoneyController.text,
      }:
    {
      "method_id": "",
      "orangemoney_number": "",
    };

      final response = await _repository.driverAddPaymentDetailsAPI(data!);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.back();
        if(Get.isRegistered<PaymentMethodController>()){
          Get.find<PaymentMethodController>().fetchAllPaymentMethodApi();
          Get.find<PaymentMethodController>().refresh();
        }
      } else if(response.status == false && response.type == 'bank_name'){
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