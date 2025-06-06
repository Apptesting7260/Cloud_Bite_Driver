import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordController extends GetxController{

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  RxString email = ''.obs;


}