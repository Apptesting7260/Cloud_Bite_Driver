import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordInLoginController extends GetxController{

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  @override
  void onInit() {
    newPasswordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
    super.onInit();
  }

  void _validateForm() {
    _isFormValid =
        FormValidators.validatePassword(newPasswordController.text) == null &&
            FormValidators.validatePassword(confirmPasswordController.text) ==
                null &&
            newPasswordController.text == confirmPasswordController.text;
    print(_isFormValid);
    update();
  }
}