import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ProfilePhotoController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);
  RxList<String> imagesArray = RxList<String>([]);

  final PersonalDocumentController controller = Get.put(PersonalDocumentController());

  final Repository _repository = Repository();

  /*Future<void> pickImage(Rx<File?> image, {bool fillImageArray = false}) async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      XFile? pickedFile = pickedImage;
      cropImage(pickedFile, image, fillImageArray: fillImageArray);
      update();
    }
  }*/
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

  Future<void> cropImage(XFile? pickedFile,Rx<File?> image,{ bool fillImageArray = false}) async {
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
  Future<void> uploadProfilePhotoAPI() async {
    LoadingOverlay().showLoading();
    try{
      Map<String, dynamic> files = {};
      if(profileImage.value != null ){
        files["profile_photo"] = profileImage.value!.path.toString();
        WidgetDesigns.consoleLog(profileImage.value!.path.toString(), "cjhcwcojwicwecbhcjdjdvcjnd");
      }

      final response = await _repository.uploadProfilePhotoAPI({},
        files,
      );

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.back();
        controller.getPersonalDocumentListData();
      }
      else if(response.status == false && response.type == 'document-uploads'){
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Uploading Profile Image');
      }
      else {
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Uploading Profile Image');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
      print(e);
    }
  }
}