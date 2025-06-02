import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgoOtpVerifyInLoginController extends GetxController{
  final otpController = TextEditingController();
  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString email = "".obs;
  RxString password = "".obs;

  @override
  void onInit() async {
    email.value = await Get.arguments['email'];
    password.value = await Get.arguments['password'];
    // otpController.addListener(_validateForm);
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }

  void startTimer() {
    resendEnabled.value = false;
    remainingTime.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  RxString otpError = "".obs;
  updateOtpError(String value) {
    otpError.value = value;
    update();
  }

  void resendOtp() {
    startTimer();
  }
}