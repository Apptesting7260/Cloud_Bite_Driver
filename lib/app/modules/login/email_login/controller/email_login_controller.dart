import 'package:cloud_bites_driver/app/core/app_exports.dart';

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
  }

  var emailError = ''.obs;
  var passwordError = ''.obs;

  updateEmailError(String value) {
    emailError.value = value;
    update();
  }
  updatePasswordError(String value) {
    passwordError.value = value;
    update();
  }


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loginWithEmailAPI() async {
    updateEmailError('');
    updatePasswordError('');
    LoadingOverlay().showLoading();
    try{
      final data = {
        "type": "email",
        "email": emailController.text,
        "password": passwordController.text
      };

      final response = await _repository.emailLoginAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        storageServices.saveStages("${response.data?.stages}");
        storageServices.saveToken("${response.data?.loginToken}");
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.offAllNamed(Routes.homeScreen);
      }
      else if(response.status == false && response.type == 'login'){
        LoadingOverlay().hideLoading();
        updateEmailError(response.message.toString());
        updatePasswordError(response.message.toString());
        print(response.message);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While login');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
    }finally{
      LoadingOverlay().hideLoading();
    }
  }

}