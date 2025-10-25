import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/routes/stage_navigator.dart';

class EmailLoginController extends GetxController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FormValidators formValidators = FormValidators();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.toggle();
    update();
  }

  var emailError = ''.obs;
  updateEmailError(String value) {
    emailError.value = value;
    update();
  }

  var passwordError = ''.obs;
  updatePasswordError(String value) {
    passwordError.value = value;
    update();
  }

  Future<void> loginWithEmailAPI() async {
    updateEmailError('');
    updatePasswordError('');
    LoadingOverlay().showLoading();
    String? fcmToken = await storageServices.returnFCMToken();
    try{
      final data = {
        "type": "email",
        "email": emailController.text,
        "password": passwordController.text,
        "fcm_token": fcmToken ?? '',
    };

      final response = await _repository.emailLoginAPI(data);

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        var selectedId = response.data?.deliverymethod ?? '';
        response.data?.loginToken != null ? storageServices.saveToken("${response.data?.loginToken}") : storageServices.saveDriverID("${response.data?.id}");
        storageServices.saveStages("${response.data?.stages}");
        storageServices.saveToken("${response.data?.loginToken}");
        storageServices.saveFirstName("${response.data?.firstName}");
        storageServices.saveLastName("${response.data?.lastName}");
        storageServices.saveDriverID("${response.data?.id}");
        storageServices.saveAddress("${response.data?.address}");
        storageServices.saveDeliveryID(selectedId);
        if(selectedId == "1"){
          storageServices.saveDeliveryType("car");
        }else if(selectedId == "2"){
          storageServices.saveDeliveryType("bike");
        }else if(selectedId == "3"){
          storageServices.saveDeliveryType("foot");
        }
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        StageNavigator.navigateToStage("${response.data?.stages}");
      }
      else if(response.status == false && response.type == 'email'){
        LoadingOverlay().hideLoading();
        updateEmailError(response.message.toString());
      }
      else if(response.status == false && response.type == 'password'){
        LoadingOverlay().hideLoading();
        updatePasswordError(response.message.toString());
      }
      else {
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While login');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }
    catch(e){
      print("$e---------3333333");
      LoadingOverlay().hideLoading();
    }
  }
}