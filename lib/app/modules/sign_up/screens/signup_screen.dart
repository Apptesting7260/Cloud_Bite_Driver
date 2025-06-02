import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SignUpScreen extends StatelessWidget{

  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: CustomBackButtonAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetDesigns.hBox(10),
              Text(
                'Create New Account',
                style: AppFontStyle.text_30_600(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry.',
                style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                textAlign: TextAlign.center,
              ),
              WidgetDesigns.hBox(30),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                          child: signUpFormFields()
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget signUpFormFields(){
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.firstNameController,
          hintText: "First Name",
          //validator: FormValidators.validateName(value),
        ),
        WidgetDesigns.hBox(16),

        CustomTextFormField(
          controller: controller.lastNameController,
          hintText: "Last Name",
          //validator: FormValidators.validatePassword,
        ),
        WidgetDesigns.hBox(16),

        CustomTextFormField(
          controller: controller.dobController,
          hintText: "Date Of Birth",
          //validator: FormValidators.validatePassword,
        ),
        WidgetDesigns.hBox(16),

        CustomTextFormField(
         controller: controller.phoneController,
         textInputType: TextInputType.number,
         inputFormatters: [
           FilteringTextInputFormatter.digitsOnly,
           LengthLimitingTextInputFormatter(controller.checkCountryLength.value),
         ],
         prefix: Row(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Stack(
               clipBehavior: Clip.none,
               children: [
                 CountryCodePicker(
                   padding: EdgeInsets.zero,
                   flagWidth: 40,
                   margin: EdgeInsets.zero,
                   flagDecoration: const BoxDecoration(
                       shape: BoxShape.circle
                   ),
                   boxDecoration: const BoxDecoration(color: AppTheme.boxBgColor,),
                   onChanged: (CountryCode countryCode) {
                     WidgetDesigns.consoleLog("${countryCode.code}","country code --->>");
                     WidgetDesigns.consoleLog("${countryCode.dialCode}","country dialCode --->>");

                     controller.updateCountryString(countryCode.dialCode.toString());

                     if(controller.countryPhoneDigits[int.parse(countryCode.dialCode.toString().replaceAll("+", ''))] != null){
                       controller.checkCountryLength.value = controller.countryPhoneDigits[int.parse(countryCode.dialCode.toString().replaceAll("+", ''))]!;
                     } else {
                       controller.checkCountryLength.value = 10;
                     }
                   },
                   initialSelection: controller.countryString.value,
                 ),
                 Positioned(
                   right: -6,
                   top: 2,
                   bottom: 2,
                   child: SvgPicture.asset(ImageConstants.downArrow),
                 ),
               ],
             ),
             WidgetDesigns.wBox(15),
             Container(width: 1,height: 30,color: AppTheme.darkText14,),
             WidgetDesigns.wBox(10),
           ],
         ),
         hintText: "Phone Number",
          suffix: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller.phoneController,
            builder: (context, value, child) {
              return Visibility(
                visible: value.text.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      customOtpDialog("${controller.countryString.value} ${controller.phoneController.text}", context, "phone");
                    },
                    child: Text(
                      "Verify",
                      style: AppFontStyle.text_12_200(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        WidgetDesigns.hBox(16),

        CustomTextFormField(
          controller: controller.emailController,
          hintText: "Email Address",
          suffix:  ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller.emailController,
            builder: (context, value, child) {
              return Visibility(
                visible: value.text.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      customOtpDialog("${controller.emailController.text}", context, "email");
                    },
                    child: Text(
                      "Verify",
                      style: AppFontStyle.text_12_200(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        WidgetDesigns.hBox(16),

        CustomTextFormField(
          controller: controller.passwordController,
          hintText: "Password",
        ),
        WidgetDesigns.hBox(16),

        CustomTextFormField(
          controller: controller.confirmPasswordController,
          hintText: "Confirm Password",
        ),
        WidgetDesigns.hBox(16),

        CustomTextFormField(
          controller: controller.locationController,
          hintText: "Location",
        ),
        WidgetDesigns.hBox(20),

        CustomAnimatedButton(
            onTap: () {
              Get.toNamed(Routes.deliveryMethodScreen);
            },
            text: "Continue"
        )
      ],
    );
  }

  customOtpDialog(title, context, type)  {
    return Get.dialog(
      barrierDismissible: false,
      Dialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Verification", style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular)),
              Text("Send an OTP to: $title", style: AppFontStyle.text_12_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular)).paddingOnly(bottom: 30),
              Pinput(
                length: 6, controller: controller.otpController,
              ),
              Obx(() {
                return controller.otpError.value !=""?Text(controller.otpError.value, style: AppFontStyle.text_12_200(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular)).paddingOnly(top: 10):SizedBox();
              },),
              Obx(
                    () => TextButton(
                  onPressed: () {
                    if (controller.resendEnabled.value) {
                      if (type == "phone") {
                        //controller.phoneAuth(true);
                      } else {

                      }
                    }
                  },
                  child: Text(
                    controller.resendEnabled.value
                        ? 'Resend Code'
                        : 'Resend Code in ${controller.remainingTime.value}s',
                    style: TextStyle(
                      color:
                      controller.resendEnabled.value
                          ? AppTheme.primaryColor
                          : Colors.grey,
                      decoration:
                      controller.resendEnabled.value
                          ? TextDecoration.underline
                          : null,
                      decorationColor: AppTheme.primaryColor,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: CustomAnimatedButton(
                      onTap: () {
                        Get.back();
                      },
                      text: "Cancel",
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomAnimatedButton(
                      onTap: () async {
                        /*if (type == "phone") {
                          await controller.phoneAuth(false);

                          if (controller.isPhoneVerified.value &&
                              (Get.isDialogOpen ?? false)) {
                            Navigator.pop(context);
                          }
                        } else{
                          await controller.emailAuth(false);

                          if (controller.isEmailVerified.value &&
                              (Get.isDialogOpen ?? false)) {
                            Navigator.pop(context);
                          }
                        }*/
                      },
                      text: "Ok",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}