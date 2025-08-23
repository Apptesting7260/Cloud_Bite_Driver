import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class VehicleDetailController extends GetxController{
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController manufacturerYearController = TextEditingController();

  final DocumentVerificationController controller = Get.put(DocumentVerificationController());

  // Images
  RxBool isRCFrontImage = false.obs;
  RxBool isRCBackImage = false.obs;

  Rx<File?> rcFrontImage = Rx<File?>(null);
  Rx<File?> rcBackImage = Rx<File?>(null);

  RxList<String> imagesArray = RxList<String>([]);

  var vehicleNameError = ''.obs;
  updateVehicleNameError(String value) {
    vehicleNameError.value = value;
    update();
  }

  var brandNameError = ''.obs;
  updateBrandNameError(String value) {
    brandNameError.value = value;
    update();
  }

  var registrationNumError = ''.obs;
  updateRegistrationNameError(String value) {
    registrationNumError.value = value;
    update();
  }

  var yearOfManufactureError = ''.obs;
  updateManufactureYearError(String value) {
    yearOfManufactureError.value = value;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();

  final RxString selectedFuelType = ''.obs;
  final List<String> fuelType = [
    'Diesel',
    'Petrol',
    'Compressed Natural Gas',
    'Electric'
  ];

  // Image Picker and Cropper Code
  final ImagePicker _picker = ImagePicker();
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);

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

  Future<void> vehicleDetailsUploadAPI() async {
    updateVehicleNameError('');
    updateBrandNameError('');
    updateRegistrationNameError('');
    updateManufactureYearError('');

    LoadingOverlay().showLoading();
     try{

       if(frontImage.value == null && backImage.value == null){
         CustomSnackBar.show(message: 'Front and Back Side of RC Image is required', color: AppTheme.redText, tColor: AppTheme.white);
       }

      Map<String, dynamic> files = {};
      if(frontImage.value != null ){
        files["rc_front_image"] = frontImage.value!.path.toString();
      }
      if(backImage.value != null ){
        files["rc_back_image"] = backImage.value!.path.toString();
      }

      final response = await _repository.uploadVehicleDetailsAPI({
        "vehicle_name": vehicleNameController.text,
        "brand": brandNameController.text,
        "year_of_manufacture": manufacturerYearController.text,
        "registration_number": registrationNumberController.text,
        "fuel_type": selectedFuelType.value
      },
        files,
      );

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.back();
      }
      else if(response.status == false && response.type == 'vehicle_name'){
        LoadingOverlay().hideLoading();
        updateVehicleNameError(response.message.toString());
        print(storageServices.getToken());
        print(response.message);
      }
      else if(response.status == false && response.type == 'brand'){
        LoadingOverlay().hideLoading();
        updateBrandNameError(response.message.toString());
        print(storageServices.getToken());
        print(response.message);
      }
      else if(response.status == false && response.type == 'year_of_manufacture'){
        LoadingOverlay().hideLoading();
        updateManufactureYearError(response.message.toString());
        print(storageServices.getToken());
        print(response.message);
      }
      else if(response.status == false && response.type == 'registration_number'){
        LoadingOverlay().hideLoading();
        updateManufactureYearError(response.message.toString());
        print(storageServices.getToken());
        print(response.message);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        print(storageServices.getToken());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
      print(e);
    }
  }

}