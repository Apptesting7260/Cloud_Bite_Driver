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
         "uuid": googleUser.id,
      };

      final response = await _repository.socialLoginAPI(data);
      String email = googleUser.email;
      if (response.status == true) {
        storageServices.saveToken("${response.data?.loginToken}");
        storageServices.saveDriverID("${response.data?.id}");
        storageServices.saveFirstName("${response.data?.firstName}");
        storageServices.saveLastName("${response.data?.lastName}");
        storageServices.saveAddress("${response.data?.address}");
        storageServices.saveDOB("${response.data?.dateOfBirth}");
        if (response.data != null) {
          if(response.data!.emailVerified == true) {
            storageServices.saveEmail(response.data?.email ?? '');
            storageServices.saveEmailVerified(true);
          }
          if(response.data?.stages == "1"|| response.data?.stages == null){
            print(".........${response.data?.stages}........");
            storageServices.saveToken("${response.data?.loginToken}");
            Get.offAllNamed(Routes.signUpScreen, arguments: {
              'email': email,
              'isVerified': response.data?.emailVerified ?? false
            });
          }else{
            StageNavigator.navigateToStage(response.data!.stages.toString());
          }
        } else {
          Get.offAllNamed(Routes.signUpScreen, arguments: {
            'email': email,
            'isVerified': response.data?.emailVerified ?? false
          });
        }
      } else {
        CustomSnackBar.show(
          message: response.message ?? "Something went wrong!",
          tColor: AppTheme.white,
          color: AppTheme.redText
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