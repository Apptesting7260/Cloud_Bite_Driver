import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PhoneOtpVerifyScreen extends StatelessWidget{

  final PhoneOtpVerifyController controller = Get.put(PhoneOtpVerifyController());

  @override
  Widget build(BuildContext context) {
      return Container(
        decoration:
        const BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomBackButtonAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Verify Phone Number',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppTheme.whiteColor, fontSize: 25),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Please enter the verification code sent to ${controller.phoneNo.value}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppTheme.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                Flexible(
                  flex: 2,
                  child: Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Pinput(
                                  controller: controller.otpController,
                                  length: 6,
                                  // onCompleted: (pin) => controller.verifyOtp(),
                                  // onSubmitted: (pin) => controller.verifyOtp(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) {
                                    controller.updateOtpError("");
                                  },
                                  forceErrorState: true,
                                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                  validator: (value) {
                                    if(controller.otpController.text.isEmpty || controller.otpController.text == ""){
                                      return "Enter OTP";
                                    }
                                    if(controller.otpController.text.length != 6){
                                      return "Enter 6 digits of OTP";
                                    }
                                    return null;
                                  },
                                  errorTextStyle: WidgetDesigns.errorTextStyle(),
                                  defaultPinTheme: PinTheme(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(60),
                                          color: Color(0xffF4F5F7))),
                                  // fieldsCount: 6,
                                  // onSubmit: (String pin) => controller.verifyOtp(pin),
                                ),
                                Obx(() {
                                  return controller.otpError.value !=""?Text(controller.otpError.value,style: WidgetDesigns.errorTextStyle(),).paddingOnly(top: 10):SizedBox();
                                },),
                              ],
                            ),

                          ),
                          const SizedBox(height: 30),
                          CustomAnimatedButton(
                            // isEnabled: controller.isFormValid,
                            onTap: () {
                              /*if(controller.formKey.currentState!.validate()){
                                controller.verifyOtp();
                              }*/
                              // StageNavigator.navigateToStageInApp("1");
                            },
                            text: 'Verify',
                          ),
                          const SizedBox(height: 20),
                          Obx(() => TextButton(
                            onPressed: controller.resendEnabled.value
                                ? controller.resendOtp
                                : null,
                            child: Text(
                              controller.resendEnabled.value
                                  ? 'Resend Code'
                                  : 'Resend Code in ${controller.remainingTime.value}s',
                              style: TextStyle(
                                color: controller.resendEnabled.value
                                    ? AppTheme.primaryColor
                                    : Colors.grey,
                                decoration: controller.resendEnabled.value
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: AppTheme.primaryColor,
                                decorationThickness: 2,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}