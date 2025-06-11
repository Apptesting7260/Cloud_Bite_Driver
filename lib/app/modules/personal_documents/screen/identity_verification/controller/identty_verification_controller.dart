import 'dart:io';
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class IdentityVerificationController extends GetxController{
  final ImagePicker _picker = ImagePicker();
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);

  RxList<String> imagesArray = RxList<String>([]);

  final Repository _repository = Repository();

  Future<void> pickImage(Rx<File?> image, {bool fillImageArray = false}) async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      XFile? pickedFile = pickedImage;
      cropImage(pickedFile, image, fillImageArray: fillImageArray);
      update();
    }
  }

  Future<void> cropImage(XFile? pickedFile,Rx<File?> image,{bool fillImageArray = false}) async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            activeControlsWidgetColor: AppTheme.primaryColor,
            toolbarTitle: 'Image Cropper',
            toolbarColor: AppTheme.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio:CropAspectRatioPresetCustom2x2(),
            statusBarColor: AppTheme.primaryColor,
            lockAspectRatio: true,
            aspectRatioPresets: [CropAspectRatioPresetCustom2x2()],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [CropAspectRatioPresetCustom2x2()],
          ),
          WebUiSettings(
            context: Get.context!,
            presentStyle: WebPresentStyle.dialog,
          ),
        ],
      );
      if (croppedFile != null) {
        image.value = File(croppedFile.path);
        if(fillImageArray && image.value != null){
          imagesArray.add(image.value!.path);
        }
      }
    }
  }

  Future<void> identityUploadAPI() async {
    LoadingOverlay().showLoading();
    try{

      Map<String, dynamic> files = {};
      if(frontImage.value != null ){
        files["front_identity"] = frontImage.value!.path.toString();
        WidgetDesigns.consoleLog(frontImage.value!.path.toString(), "cjhcwcojwicwecbhcjdjdvcjnd");
      }
      if(backImage.value != null ){
        files["back_identity"] = backImage.value!.path.toString();
        WidgetDesigns.consoleLog(backImage.value!.path.toString(), "cjhcwcojwicwecbhcjdjdvcjnd");
      }

      final response = await _repository.uploadIdentityPhotoAPI({},
        files,
      );

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.toNamed(Routes.personalDocumentsScreen);
      }
      else if(response.status == false && response.type == 'document-uploads'){
        LoadingOverlay().hideLoading();
        print(response.message);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Uploading Vehicle Details');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
      print(e);
    }
  }

}