import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class WelcomeScreen extends StatelessWidget{

  final WelcomeController controller = Get.put(WelcomeController());

   WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black54,
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.lighten,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.loginBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          // bottomSheet: Container(),
          backgroundColor: Colors.black.withOpacity(0.3),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                        'Welcome!',
                        style: AppFontStyle.text_30_400(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium)
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        'Your go-to app for sharing and ordering delicious cloud goodies from your favorite cooks, vendors and food spots in Botswana. ',
                         style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular,
                         overflow: TextOverflow.visible),
                    ),
                  ),
                  // const SizedBox(height: 40),

                  const SizedBox(height: 20),
                  CustomAnimatedButton(
                    onTap: () => Get.toNamed(Routes.emailLogin),
                    text: 'Login with Email',
                  ),
                  const SizedBox(height: 16),

                  GestureDetector(
                      onTap: () => Get.toNamed(Routes.phoneLogin),
                      child: Center(
                          child: Text(
                            'Log In With Phone Number',
                            style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                          ))),
                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      'Or continue with',
                      style: AppFontStyle.text_16_400(AppTheme.whiteColor, fontFamily: AppFontFamily.generalSansRegular),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialLoginButton(
                          onPressed: () async {
                            controller.signInWithFacebook(Get.context!);
                          }, url: ImageConstants.facebookLoginImage),

                      WidgetDesigns.wBox(5),

                      _socialLoginButton(
                          onPressed: () async {
                            controller.signInWithGoogle(Get.context!);
                          }, url: ImageConstants.googleLoginImage),

                      WidgetDesigns.wBox(5),

                      if (Platform.isIOS) ...[
                        _socialLoginButton(
                            onPressed: () async {
                              controller.signInWithApple(Get.context!);
                            },
                            url: ImageConstants.appleLoginImage
                        ),
                        WidgetDesigns.wBox(5),
                      ],
                    ],
                  ),
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                      ),
                      TextButton(
                        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _socialLoginButton({
    required VoidCallback onPressed,
    required String url,
  }) {
    return GestureDetector(
        onTap: onPressed,
        child: CustomImageView(height: 46, width: 46, imageUrl: url));
  }
}