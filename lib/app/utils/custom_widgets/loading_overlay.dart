
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;
  LoadingOverlay._internal();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void showLoading() {
    if (!_isLoading) {
      _isLoading = true;

      Get.dialog(
        PopScope(
          canPop: false,
          child: Center(
            child: Lottie.asset(
              ImageConstants.loaderJson,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.6),
        barrierDismissible: false,
        useSafeArea: true,
        // name: 'loading_dialog',
      );
    }
  }

  Future<void> hideLoading() async {

    // if(Get.isOverlaysClosed) {
    //   // If overlays are closed, we don't need to hide the loading dialog
    //   return;
    // }
    // while(Get.isDialogOpen == true){
    //   // If a dialog is open, we can safely close it
    //   Get.back();
    // }

    if (_isLoading) {
      _isLoading = false;
      Get.back();
    }
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      ImageConstants.loaderJson,
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}


