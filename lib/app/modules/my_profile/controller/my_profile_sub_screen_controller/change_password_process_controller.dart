import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordProcessController extends GetxController{
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
}