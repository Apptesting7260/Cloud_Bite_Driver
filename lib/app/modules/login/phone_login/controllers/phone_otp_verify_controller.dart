import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PhoneOtpVerifyController extends GetxController{

  TextEditingController otpController = TextEditingController();
  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;
  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;
  bool fromSignup = false;

  RxString otpError = "".obs;
  updateOtpError(String value) {
    otpError.value = value;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString phoneNo = "".obs;

  @override
  void onInit() {
    /*phoneNo.value = Get.arguments['num'];
    fromSignup = Get.arguments['fromSignup'] ?? false;*/
    WidgetDesigns.consoleLog(Get.arguments.toString(),"Arguments");
    // otpController.addListener(_validateForm);
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    // otpController.dispose();
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
  void resendOtp() {
    startTimer();
  }
}