import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordController extends GetxController{

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPasswordP = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Repository _repository = Repository();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageService =>  _storageService;
  RxBool obscureNewPassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  void toggleNewPasswordVisibility() {
    obscureNewPassword.value = !obscureNewPassword.value;
    update();
  }
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;

  updateNewPasswordError(String value) {
    newPasswordError.value = value;
    update();
  }
  updateConfirmPasswordError(String value) {
    confirmPasswordError.value = value;
    update();
  }


  RxString email = ''.obs;
  @override
  void onInit() {
    email.value = Get.arguments['email'];
    super.onInit();
  }

  Future<void> setPasswordAPI() async {
    updateNewPasswordError('');
    updateConfirmPasswordError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "setPassword",
        "email": storageService.getEmail() != '' ? storageService.getEmail() : email.value,
        "newPassword": newPassword.text,
      };

      final response = await _repository.setPasswordForgetAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        showPasswordChangedDialog(Get.context!);
      }
      else if(response.status == false && response.type == 'verifyAndReset'){
        LoadingOverlay().hideLoading();
        updateNewPasswordError(response.message.toString());
        updateConfirmPasswordError(response.message.toString());
      }
      else {
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While set Password');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

  void showPasswordChangedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(ImageConstants.passwordChangedIcon,height: 80),
              WidgetDesigns.hBox(20),
              Text(
                "Password Changed",
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Password changed successfully, you can login again with a new password",
                style: TextStyle(
                  fontFamily: 'General-Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              WidgetDesigns.hBox(24),
              Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: CustomAnimatedButton(
                          onTap: () {
                            Get.offAllNamed(Routes.welcome);
                          },
                          text: 'Close'
                      )
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}