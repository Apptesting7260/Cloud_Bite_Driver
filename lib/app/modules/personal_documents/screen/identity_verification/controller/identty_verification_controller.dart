import 'dart:io';
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class IdentityVerificationController extends GetxController{
  final ImagePicker _picker = ImagePicker();
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);

  final PersonalDocumentController controller = Get.put(PersonalDocumentController());

  RxList<String> imagesArray = RxList<String>([]);

  final Repository _repository = Repository();

  Future<void> pickImage(Rx<File?> image, {bool fillImageArray = false}) async {
    final source = await Get.bottomSheet<ImageSource>(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppTheme.primaryColor),
              title: Text(
                'Take Photo',
                style: AppFontStyle.text_16_400(Colors.black),
              ),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppTheme.primaryColor),
              title: Text(
                'Choose from Gallery',
                style: AppFontStyle.text_16_400(Colors.black),
              ),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      await _processImageSelection(source, image, fillImageArray: fillImageArray);
    }
  }

  Future<void> _processImageSelection(
      ImageSource source,
      Rx<File?> image, {
        bool fillImageArray = false,
      }) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      await cropImage(pickedImage, image, fillImageArray: fillImageArray);
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
            initAspectRatio:CropAspectRatioPresetCustom9x6(),
            statusBarColor: AppTheme.primaryColor,
            lockAspectRatio: true,
            aspectRatioPresets: [CropAspectRatioPresetCustom9x6()],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [CropAspectRatioPresetCustom9x6()],
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
        Get.back();
        controller.getPersonalDocumentListData();
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