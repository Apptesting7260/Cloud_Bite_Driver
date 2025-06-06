import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordOtpVerifyController extends GetxController{

  TextEditingController otpController = TextEditingController();

  RxString otpError = "".obs;
  updateOtpError(String value) {
    otpError.value = value;
    update();
  }

  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;

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
  void resendOtp() {
    startTimer();
  }
}