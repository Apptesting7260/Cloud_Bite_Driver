import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class VehicleDetailController extends GetxController{
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController manufacturerYearController = TextEditingController();

  final RxString selectedVehicleType = ''.obs;
  final List<String> vehicleTypes = [
    'Sedan',
    'SUV',
    'Truck',
    'Motorcycle',
    'Van'
  ];

  final RxString selectedFuelType = ''.obs;
  final List<String> fuelType = [
    'Petrol',
    'Diesel',
    'CNG',
    'Electric',
  ];

  // Image Picker and Cropper Code
  final ImagePicker _picker = ImagePicker();
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);

  Future<void> pickImage(Rx<File?> image) async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      XFile? pickedFile = pickedImage;
      cropImage(pickedFile, image);
      update();
    }
  }

  Future<void> cropImage(XFile? pickedFile,Rx<File?> image,) async {
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
      }

    }
  }
}