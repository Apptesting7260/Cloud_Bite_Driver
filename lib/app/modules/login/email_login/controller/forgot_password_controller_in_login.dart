import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordControllerInLogin extends GetxController{

  final TextEditingController emailController = TextEditingController();
  final remainingTime = 60.obs;
  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateForm);
  }

  void _validateForm() {
    _isFormValid = FormValidators.validateEmail(emailController.text) == null;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey();

  RxString emailError = ''.obs;
  void updateEmailError(String error) {
    emailError.value = error;
    update();
  }
}