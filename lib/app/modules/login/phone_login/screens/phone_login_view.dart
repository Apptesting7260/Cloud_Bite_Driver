import 'package:cloud_bites_driver/app/core/app_exports.dart';


class PhoneLoginView extends StatelessWidget {

  final PhoneLoginController controller = Get.put(PhoneLoginController());

   PhoneLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: CustomBackButtonAppBar(onBackPressed: () {
                  Get.offAllNamed(Routes.welcome);
                },),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Login Your Account',
                        style: AppFontStyle.text_26_600(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Please login to your existing account',
                      style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                    const SizedBox(height: 60),
                    Flexible(
                      flex: 2,
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: controller.formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                GetBuilder<PhoneLoginController>(
                                    builder: (controller) {
                                      return CustomTextFormField(
                                        alignLabelWithHint: false,
                                        readOnly: false,
                                        controller: controller.phoneController,
                                        textInputType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(controller.checkCountryLength.value),
                                        ],
                                        prefix: Row(
                                          mainAxisSize: MainAxisSize.min,
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
                                                    // controller.updateCountryString(countryCode.dialCode.toString().split("+").last);
                                                    controller.updateCountryString((countryCode.dialCode ?? '+91').replaceAll('+', ''));
                                                    if(controller.countryPhoneDigits[countryCode.code.toString()] != null){
                                                      controller.checkCountryLength.value = controller.countryPhoneDigits[countryCode.code] ?? 10;
                                                    } else {
                                                      controller.checkCountryLength.value = 10;
                                                    }
                                                    controller.update();
                                                  },
                                                  // initialSelection: "+${controller.countryString}",
                                                  initialSelection: 'BW',
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
                                        onChanged: (value) {
                                          controller.updatePhoneError("");
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {

                                            return 'Phone number is required!';
                                          }
                                          if (value.length != controller.checkCountryLength.value) {

                                            return '${controller.checkCountryLength.value} digits required';
                                          }
                                          if(controller.phoneError.value != '' && controller.phoneError.value.isNotEmpty){
                                            return controller.phoneError.value;
                                          }
                                          return null;
                                        },
                                      );
                                    }
                                ),
                                const SizedBox(height: 16),
                                GetBuilder<PhoneLoginController>(
                                    builder: (context) {
                                      return CustomTextFormField(
                                        controller: controller.passwordController,
                                        hintText: "Password",
                                        readOnly: false,
                                        obscureText: controller.obscurePassword.value,
                                        onChanged: (value) {
                                          controller.updatePasswordError('');
                                        },
                                        suffix: IconButton(
                                          icon: Icon(
                                            controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            controller.togglePasswordVisibility();
                                          },
                                        ),
                                        validator: (value) {
                                          if(controller.passwordController.text.isEmpty){
                                            return 'Password is required';
                                          }

                                          if(controller.passwordError.value.isNotEmpty || controller.passwordError.value != ''){
                                            return controller.passwordError.value;
                                          }

                                          return null;
                                        },
                                      );
                                    }
                                ),

                                const SizedBox(height: 20),
                                CustomAnimatedButton(
                                  onTap: () {
                                  /*  if(controller.formkey.currentState!.validate()) {
                                      if(controller.countryString.value !="267"){
                                        controller.loginWithPhoneAPI2();
                                      }else{
                                        controller.loginWithPhoneAPI();
                                      }
                                    }*/
                                    if(controller.formkey.currentState!.validate()) {
                                      controller.loginWithPhoneAPI();
                                    }
                                  },
                                  text: 'Login',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !controller.fromSignup,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgotPasswordPhoneScreenInLogin);
                              },
                              child:
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppTheme.primaryColor,
                                    decorationThickness: 2),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      padding:
                                      WidgetStatePropertyAll(EdgeInsets.all(0))),
                                  onPressed: (){
                                    Get.toNamed(Routes.signUpScreen);
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: AppTheme.blueColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppTheme.blueColor,
                                        decorationStyle: TextDecorationStyle.solid,
                                        decorationThickness: 2),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
