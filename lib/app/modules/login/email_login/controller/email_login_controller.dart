import 'package:cloud_bites_driver/app/core/app_exports.dart';

class EmailLoginController extends GetxController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FormValidators formValidators = FormValidators();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  @override
  void onInit() {
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    super.onInit();
  }

  void _validateForm() {
    _isFormValid = FormValidators.validateEmail(emailController.text) == null &&
        FormValidators.validatePassword(passwordController.text) == null;
    update();
  }
}