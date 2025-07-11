import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordController extends GetxController{

  final Repository _repository = Repository();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailAddressController = TextEditingController();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  var emailError = ''.obs;

  updateEmailError(String value) {
    emailError.value = value;
    update();
  }

  Future<void> sendOtpForForget() async {
    updateEmailError('');
    LoadingOverlay().showLoading();
    try{
      final data = {
        "email": emailAddressController.text.trim(),
      };

      final response = await _repository.forgetPasswordAPI(data);

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.toNamed(Routes.forgotPasswordOtpVerifyScreen, arguments: {"email": emailAddressController.text.trim()});
      } else if(response.status == false && response.type == 'forgetPassword'){
        updateEmailError(response.message.toString());
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Forget Password');
      }

    }catch(e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      WidgetDesigns.consoleLog(e.toString(), 'Error While Forget Password');
    }
  }
}