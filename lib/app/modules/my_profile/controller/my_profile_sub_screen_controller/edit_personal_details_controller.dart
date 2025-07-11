import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:http/http.dart' as http;

class EditPersonalDetailsController extends GetxController {

  final PersonalDetailsController controller = Get.put(PersonalDetailsController());


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);
  RxList<String> imagesArray = RxList<String>([]);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Map<String, dynamic>? locationAddress;

  var firstNameError = ''.obs;
  var lastNameError = ''.obs;
  var dobError = ''.obs;
  var addressError = ''.obs;

  updateFirstNameError(String value) {
    firstNameError.value = value;
    update();
  }
  updateLastNameError(String value) {
    lastNameError.value = value;
    update();
  }
  updateDOBError(String value) {
    dobError.value = value;
    update();
  }
  updateAddressError(String value) {
    addressError.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _handleLocationPermission(Get.context!);
    firstNameController.text = storageServices.getFirstName();
    lastNameController.text = storageServices.getLastName();
    dobController.text = _formatDate(storageServices.getDOB());
    locationController.text = storageServices.getAddress();
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    locationController.dispose();
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "N/A";
    try {
      final date = DateTime.parse(dateString);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "Invalid date";
    }
  }

  final GlobalKey addressKey = GlobalKey();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  RxBool isValidAddress = true.obs;

  String googleAPIKey = "${dotenv.env['googleAPIKey']}";

  Future<List<Predictions>> searchAutocomplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": googleAPIKey,
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final parse = jsonDecode(response.body);
        if (parse['status'] == "OK") {
          SearchPlaceModel searchPlaceModel = SearchPlaceModel.fromJson(parse);
          return searchPlaceModel.predictions ?? [];
        }
      }
    } catch (err) {
      debugPrint("Error: $err");
    }
    return [];
  }

  Future<void> getLatLang(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      var first = locations.first;
      latitude.value = first.latitude;
      longitude.value = first.longitude;
      debugPrint("Latitude: ${latitude.value}, Longitude: ${longitude.value}");
    }
  }

  double? _latitude;
  double? _longitude;


  void _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomSnackBar.show(message: "Location services are disabled.", tColor: AppTheme.white, color: AppTheme.redText);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      CustomSnackBar.show(message: "Permission permanently denied.", tColor: AppTheme.white, color: AppTheme.redText);
      return;
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      try {
        Position locData = await Geolocator.getCurrentPosition();
        print("Position fetched: ${locData.latitude}, ${locData.longitude}");
        _latitude = locData.latitude;
        _longitude = locData.longitude;

        print("Notifier values: $_latitude, $_longitude");

        WidgetDesigns.consoleLog("Latitude: $_latitude", "");
        WidgetDesigns.consoleLog("Longitude: $_longitude", "");
      } catch (e) {
        CustomSnackBar.show(message: "Error getting location: $e", tColor: AppTheme.white, color: AppTheme.redText);
      }
    }
  }


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

  Future<void> updateDriverProfileAPI() async {
    updateFirstNameError('');
    updateLastNameError('');
    updateDOBError('');
    updateAddressError('');

    if (locationAddress == null && locationController.text.isNotEmpty) {
      locationAddress = {
        'lat': _latitude ?? 0.0,
        'lng': _longitude ?? 0.0,
        'address': locationController.text
      };
    }

    LoadingOverlay().showLoading();
    try{
      Map<String, dynamic> files = {};
      if(profileImage.value != null ){
        files["profile_photo"] = profileImage.value!.path.toString();
        WidgetDesigns.consoleLog(profileImage.value!.path.toString(), "ProfilePhoto.......");
      }

      final response = await _repository.updateDriverDetails({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "dob": dobController.text,
        "latitude": locationAddress!['lat']?.toString() ?? '0.0',
        "longitude": locationAddress!['lng']?.toString() ?? '0.0',
        "address": locationController.text
      },
          files
      );

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        storageServices.saveFirstName(firstNameController.text);
        storageServices.saveLastName(lastNameController.text);
        storageServices.saveDOB(dobController.text);
        storageServices.saveAddress(locationController.text);
        Get.back();
        controller.getDriverData();
      }
      else if(response.status == false && response.type == 'edit'){
        LoadingOverlay().hideLoading();
        updateFirstNameError(response.message.toString());
        updateLastNameError(response.message.toString());
        updateDOBError(response.message.toString());
        updateAddressError(response.message.toString());
        print(response.message);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While update driver data');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
    }finally{
      LoadingOverlay().hideLoading();
    }
  }

}