import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpScreen({super.key});

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
                'Sign up to deliver food',
                style: AppFontStyle.text_26_600(
                  AppTheme.white,
                  fontFamily: AppFontFamily.generalSansMedium,
                ),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Earn on your schedule, and get paid fast with our\nDriver App',
                style: AppFontStyle.text_14_400(
                  AppTheme.white,
                  fontFamily: AppFontFamily.generalSansRegular,
                ),
                textAlign: TextAlign.center,
              ),
              WidgetDesigns.hBox(30),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(child: signUpFormFields()),
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

  Widget signUpFormFields() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          WidgetDesigns.hBox(10),
          GetBuilder<SignUpController>(
            builder: (context) {
              return controller.loginType.value =="google"?SizedBox.shrink(): CustomTextFormField(
                controller: controller.firstNameController,
                hintText: "First Name",
                onChanged: (value) {
                  controller.updateFirstNameError('');
                },
                hintStyle: AppFontStyle.text_12_400(
                  AppTheme.lightText,
                  fontFamily: AppFontFamily.generalSansRegular,
                ),
                validator: (value) {
                  if (controller.firstNameController.text.isEmpty) {
                    return "First name is required";
                  }
                  if (controller.firstNameError.value.isNotEmpty) {
                    return controller.firstNameError.value;
                  }
                  return null;
                },
              );
            },
          ),
          WidgetDesigns.hBox(16),

          GetBuilder<SignUpController>(
            builder: (context) {
              return controller.loginType.value =="google"?SizedBox.shrink():  CustomTextFormField(
                controller: controller.lastNameController,
                hintText: "Last Name",
                hintStyle: AppFontStyle.text_12_400(
                  AppTheme.lightText,
                  fontFamily: AppFontFamily.generalSansRegular,
                ),
                onChanged: (value) {
                  controller.updateLastNameError('');
                },
                validator: (value) {
                  if (controller.lastNameController.text.isEmpty) {
                    return "Last name is required";
                  }
                  if (controller.lastNameError.value.isNotEmpty ||
                      controller.lastNameError.value != '') {
                    return controller.lastNameError.value;
                  }
                  return null;
                },
              );
            },
          ),
          WidgetDesigns.hBox(16),

          GetBuilder<SignUpController>(
            builder: (context) {
              return CustomTextFormField(
                controller: controller.dobController,
                hintText: "Date Of Birth",
                onChanged: (value) {
                  controller.updateDOBError('');
                },
                validator: (value) {
                  if (controller.dobController.text.isEmpty) {
                    return 'DOB is required';
                  }

                  try {
                    final parts = controller.dobController.text.split('-');
                    if (parts.length != 3) return 'Invalid date format';

                    final selectedDate = DateTime(
                      int.parse(parts[0]),
                      int.parse(parts[1]),
                      int.parse(parts[2]),
                    );

                    final today = DateTime.now();
                    final minDate = DateTime(
                      today.year - 18,
                      today.month,
                      today.day,
                    );
                    final maxDate = DateTime(
                      today.year - 100,
                      today.month,
                      today.day,
                    );

                    if (selectedDate.isAfter(minDate)) {
                      return 'You must be at least 18 years old';
                    }

                    if (selectedDate.isBefore(maxDate)) {
                      return 'Please enter a valid date (max 100 years)';
                    }
                  } catch (e) {
                    return 'Invalid date format';
                  }

                  if (controller.dobError.value.isNotEmpty ||
                      controller.dobError.value != '') {
                    return controller.dobError.value;
                  }

                  return null;
                },
                suffix: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now().subtract(
                        const Duration(days: 365 * 25),
                      ), // Default to 25 years old
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365 * 100),
                      ), // Max 100 years old
                      lastDate: DateTime.now().subtract(
                        const Duration(days: 365 * 18),
                      ), // Min 18 years old
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppTheme.primaryColor,
                              onPrimary: AppTheme.white,
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      controller.dobController.text = formattedDate;
                      controller.dobError.value = '';
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
              );
            },
          ),
          WidgetDesigns.hBox(16),

          GetBuilder<SignUpController>(
            builder: (context) {
              return CustomTextFormField(
                controller: controller.phoneController,
                enabled:
                    controller.isPhoneVerified.value &&
                            controller.countryString.value == "+267"
                        ? false
                        : true,

                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                    controller.checkCountryLength.value,
                  ),
                ],
                onChanged: (value) {
                  print(
                    controller.isPhoneVerified.value &&
                        controller.countryString.value == "+267",
                  );
                  controller.updatePhoneError('');
                  if (controller.countryString.value != "+267") {
                    controller.verifiedPhone.value =
                        controller.countryString.value + value;

                    controller.isPhoneVerified.value = true;
                    controller.update();
                  } else {
                    controller.verifiedPhone.value = '';

                    controller.isPhoneVerified.value = false;
                    controller.update();
                  }
                  print("verify ${controller.verifiedPhone.value}");
                  print("phone controller  ${controller.phoneController.text}");
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required!';
                  }
                  if (value.length != controller.checkCountryLength.value) {
                    return '${controller.checkCountryLength.value} digits required';
                  }
                  if (controller.phoneError.value != '' &&
                      controller.phoneError.value.isNotEmpty) {
                    return controller.phoneError.value;
                  }
                  return null;
                },
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
                            shape: BoxShape.circle,
                          ),
                          boxDecoration: const BoxDecoration(
                            color: AppTheme.boxBgColor,
                          ),
                          onChanged: (CountryCode countryCode) {
                            WidgetDesigns.consoleLog(
                              "${countryCode.code}",
                              "country code --->>",
                            );
                            WidgetDesigns.consoleLog(
                              "${countryCode.dialCode}",
                              "country dialCode --->>",
                            );

                            controller.updateCountryString(
                              countryCode.dialCode.toString(),
                            );

                            if (controller.countryPhoneDigits[int.parse(
                                  countryCode.dialCode.toString().replaceAll(
                                    "+",
                                    '',
                                  ),
                                )] !=
                                null) {
                              controller.checkCountryLength.value =
                                  controller.countryPhoneDigits[int.parse(
                                    countryCode.dialCode.toString().replaceAll(
                                      "+",
                                      '',
                                    ),
                                  )]!;
                            } else {
                              controller.checkCountryLength.value = 10;
                            }

                            if (controller.countryString.value != "+267") {
                              controller.verifiedPhone.value =
                                  controller.countryString.value +
                                  controller.phoneController.text;

                              controller.isPhoneVerified.value = true;
                            } else {
                              controller.verifiedPhone.value = '';
                              controller.isPhoneVerified.value = false;
                            }

                            controller.update();
                          },
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
                    Container(width: 1, height: 30, color: AppTheme.darkText14),
                    WidgetDesigns.wBox(10),
                  ],
                ),
                hintText: "Phone Number",
                suffix: Obx(() {
                  // Show green tick if current phoneNumber is verified
                  if (controller.verifiedPhone.value ==
                      "${controller.countryString.value}${controller.phoneController.text}") {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                        size: 20,
                      ),
                    );
                  }
                  // Show verify button for unverified numbers
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller.phoneController,
                    builder: (context, value, child) {
                      return Visibility(
                        visible: value.text.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.phoneController.text.length ==
                                  controller.checkCountryLength.value) {
                                controller.generateOTPForPhone();
                              }
                            },
                            child: Text(
                              "Verify",
                              style: AppFontStyle.text_12_200(
                                AppTheme.primaryColor,
                                fontFamily: AppFontFamily.generalSansMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              );
            },
          ),

          WidgetDesigns.hBox(16),

          GetBuilder<SignUpController>(
            builder: (context) {
              print(
                "llllllllllllll${controller.disableEmailField.value.toString()}",
              );
              return controller.loginType.value =="google"?SizedBox.shrink():  CustomTextFormField(
                controller: controller.emailController,
                hintText: "Email Address",
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {
                  if (!controller.disableEmailField.value) {
                    controller.updateEmailError('');
                  }
                },
                enabled: !controller.disableEmailField.value,
                validator: (value) {
                  if (controller.emailController.text.isEmpty) {
                    return "Email is required";
                  }
                  if (!FormValidators.isValidEmail(value)) {
                    return "Please enter a valid email";
                  }
                  if (controller.emailError.value.isNotEmpty &&
                      controller.emailError.value != "") {
                    return controller.emailError.value;
                  }
                  return null;
                },
                suffix: Obx(() {
                  if (controller.isEmailVerified.value &&
                      controller.verifiedEmail.value ==
                          controller.emailController.text) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                        size: 20,
                      ),
                    );
                  }
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller.emailController,
                    builder: (context, value, child) {
                      bool isValid = FormValidators.isValidEmail(value.text);
                      return Visibility(
                        visible: value.text.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              if (isValid) {
                                controller.generateOTPForEmail();
                              } else {
                                controller.updateEmailError(
                                  "Please enter a valid email",
                                );
                              }
                            },
                            child: Text(
                              "Verify",
                              style: AppFontStyle.text_12_200(
                                AppTheme.primaryColor,
                                fontFamily: AppFontFamily.generalSansMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              );
            },
          ),

          Obx(() {
            if (controller.loginType.value != 'google') {
              return Column(
                children: [
                  WidgetDesigns.hBox(16),
                  GetBuilder<SignUpController>(
                    builder: (context) {
                      return CustomTextFormField(
                        controller: controller.passwordController,
                        hintText: "Password",
                        obscureText: controller.obscurePassword.value,
                        onChanged: (value) {
                          controller.updatePasswordError('');
                        },
                        validator: (value) {
                          if (controller.passwordController.text.isEmpty) {
                            return "Password is required";
                          }
                          return FormValidators.validatePassword(value!);
                        },
                        suffix: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          }),
          WidgetDesigns.hBox(16),

          GetBuilder<SignUpController>(
            builder: (context) {
              return CustomTextFormField(
                controller: controller.locationController,
                hintText: "Address",
                onChanged: (value) {
                  controller.updateAddressError('');
                },
                validator: (value) {
                  if (controller.locationController.text.isEmpty) {
                    return "Please choose precise location";
                  }
                  if (controller.addressError.value.isNotEmpty ||
                      controller.addressError.value != '') {
                    return controller.addressError.value;
                  }
                  return null;
                },
                enabled: false,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await Get.toNamed(Routes.addNewAddress);
                  if (result is Map<String, dynamic>) {
                    controller.locationAddress = result;
                    controller.locationController.text =
                        result['address'] as String;
                  }
                },
                child: Text(
                  "Choose precise location",
                  style: AppFontStyle.text_14_400(
                    AppTheme.primaryColor,
                    fontFamily: AppFontFamily.generalSansMedium,
                  ),
                ),
              ),
            ],
          ),
          WidgetDesigns.hBox(20),

          CustomAnimatedButton(
            onTap: () {
              if (controller.formKey.currentState!.validate()) {
                controller.registerDriverAPI();
              }
            },
            text: "Continue",
          ),
        ],
      ),
    );
  }
}
