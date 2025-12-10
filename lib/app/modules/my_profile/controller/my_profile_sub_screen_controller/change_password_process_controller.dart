import 'dart:math';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordProcessController extends GetxController{
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageService =>  _storageService;

  RxBool obscureOldPassword = true.obs;
  RxBool obscureNewPassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  void toggleOldPasswordVisibility() {
    obscureOldPassword.value = !obscureOldPassword.value;
    update();
  }
  void toggleNewPasswordVisibility() {
    obscureNewPassword.value = !obscureNewPassword.value;
    update();
  }
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  var oldPasswordError = ''.obs;
  updateOldPasswordError(String value) {
    oldPasswordError.value = value;
    update();
  }

  var newPasswordError = ''.obs;
  updateNewPasswordError(String value) {
    newPasswordError.value = value;
    update();
  }

  Future<void> changePasswordApi() async {
    updateOldPasswordError('');
    updateNewPasswordError('');
    LoadingOverlay().showLoading();
    try{
      final data = {
        "email": storageService.getEmail(),
        "oldPassword": oldPassword.text.trim(),
        "newPassword": confirmNewPassword.text.trim()
      };

      final response = await _repository.changePasswordForgetAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();

        // showPasswordChangedDialog(Get.context!);
      } else if(response.status == false && response.type == 'changePassword') {
        LoadingOverlay().hideLoading();

        updateOldPasswordError(response.message.toString());
        updateNewPasswordError(response.message.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }else if (response.status == false && response.type == 'old-password') {
        LoadingOverlay().hideLoading();

        updateOldPasswordError(response.message.toString());

      }
    } catch (e) {
      LoadingOverlay().hideLoading();

      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      WidgetDesigns.consoleLog(e.toString(), 'Error While Change Password');
    } finally {
      LoadingOverlay().hideLoading();
      WidgetDesigns.consoleLog(e.toString(), 'Error While Change Password');
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
                            Get.back();
                            Get.back();
                            // Get.offAllNamed(Routes.welcome);
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