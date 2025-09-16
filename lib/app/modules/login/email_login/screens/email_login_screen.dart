import 'package:cloud_bites_driver/app/core/app_exports.dart';

class EmailLoginScreen extends StatelessWidget{

  final EmailLoginController controller = Get.put(EmailLoginController());

   EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
        const BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: const CustomBackButtonAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login With Email',
                  style: AppFontStyle.text_26_600(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please login to your existing account',
                  style: AppFontStyle.text_18_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
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
                              GetBuilder<EmailLoginController>(
                                builder: (context) {
                                  return CustomTextFormField(
                                    controller: controller.emailController,
                                    hintText: "Email Address",
                                    readOnly: false,
                                    onChanged: (value) {
                                      controller.updateEmailError('');
                                    },
                                    validator: (value) {
                                      if(controller.emailController.text.isEmpty){
                                        return 'Email is required';
                                      }

                                      if(!FormValidators.isValidEmail(value)){
                                        return "Please enter a valid email";
                                      }

                                      if(controller.emailError.value.isNotEmpty || controller.emailError.value != ''){
                                        return controller.emailError.value;
                                      }
                                      return null;
                                    },
                                  );
                                }
                              ),
                              const SizedBox(height: 16),
                              GetBuilder<EmailLoginController>(
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
                              const SizedBox(height: 8),
                              const SizedBox(height: 30),
                              CustomAnimatedButton(
                                onTap: () {
                                  if(controller.formkey.currentState!.validate()) {
                                    controller.loginWithEmailAPI();
                                  }
                                },
                                text: 'Login',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.forgotPasswordInLogin);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppTheme.primaryColor,
                                      decorationThickness: 2),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  child: Row(
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
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                        onPressed: (){
                          Get.toNamed(Routes.signUpScreen);
                        },
                        child: const Text(
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
                ),
              ],
            ),
          ),
        ),
      );
  }
}