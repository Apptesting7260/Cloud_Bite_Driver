import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/routes/stage_navigator.dart';


class WelcomeController extends GetxController{

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      LoadingOverlay().showLoading();

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
       );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.back();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      String? fcmToken = await storageServices.returnFCMToken();

      var data = {
        "email": googleUser.email,
        "type": "google",
        "fcm_token": fcmToken ?? '',
      };

      final response = await _repository.socialLoginAPI(data);
      if (response.status == true) {
        if (response.data != null) {
          StageNavigator.navigateToStage(response.data!.stages.toString());
          WidgetDesigns.consoleLog("hcbdbscsi111111111111111", "");
        } else {
          WidgetDesigns.consoleLog("hcbdbscsi22222222222222", "");
          Get.offAllNamed(Routes.signUpScreen);
          /*Get.offAllNamed(Routes.signUpScreen, arguments: {
            'email': googleUser.email,
          });*/
        }
      } else {
        WidgetDesigns.consoleLog("hcbdbscsi3333333333333333", "");
        CustomSnackBar.show(
          message: response.message ?? "Something went wrong!",
          useGradient: true,
        );
      }

    } on PlatformException catch (e) {
      // Get.back();
      print('Google Sign-In PlatformException: ${e.message}');
      CustomSnackBar.show(
        message: 'Google Sign-In failed. Please check your configuration.',
        color: AppTheme.redText,
        tColor: AppTheme.white
      );
    }finally {
      LoadingOverlay().hideLoading();
    }
  }
}