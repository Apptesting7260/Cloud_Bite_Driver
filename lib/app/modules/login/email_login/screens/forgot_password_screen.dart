import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordScreenInLogin extends StatelessWidget{

  final ForgotPasswordControllerInLogin controller =Get.put(ForgotPasswordControllerInLogin());

   ForgotPasswordScreenInLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: CustomBackButtonAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppTheme.whiteColor,
                    fontSize: 27,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Enter your registered email to receive reset \npassword code',
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Column(
                          children: [
                            GetBuilder<ForgotPasswordControllerInLogin>(
                                builder: (context) {
                                  return Form(
                                    key: controller.formKey,
                                    child: CustomTextFormField(
                                      controller: controller.emailAddressController,
                                      readOnly: false,
                                      hintText: "Email Address",
                                      onChanged: (value) {
                                        controller.updateEmailError("");
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email is required';
                                        }
                                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        if (controller.emailError.value.isNotEmpty) {
                                          return controller.emailError.value;
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomAnimatedButton(
                          onTap: () {
                            if(controller.formKey.currentState!.validate()){
                              controller.sendOtpForForget();
                            }
                          },
                          text: 'Send Code',
                        ),
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