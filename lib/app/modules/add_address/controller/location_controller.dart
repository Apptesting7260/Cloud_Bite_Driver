

import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class LocationController extends GetxController {
  //TODO: Implement LocationController
  // add new address fields
  var formKey = GlobalKey<FormState>();
  var houseController = TextEditingController();
  var addressController = TextEditingController();
  var isDefault = true.obs;
  var type = "".obs;
  var isValidAddress = true.obs;
  var isFetchLocation = false.obs;
  static int selectedIndex = 0; // Only index 2 should be true
  var placeList =
      [
        {'name': 'Home', 'value': 'home', 'image': ImageConstants.placeHomeImage},
        {
          'name': 'Office',
          'value': 'office',
          'image': ImageConstants.placeOfficeImage,
        },
        {
          'name': 'Other',
          'value': 'other',
          'image': ImageConstants.placeLocationImage,
        },
      ].obs;
  String? selectedLocation;
  var selectedLocationType = "".obs;
  final List<Predictions> searchPlace = [];
  final GlobalKey addressKey = GlobalKey();
  var selectionList = List.generate(5, (index) => index == selectedIndex).obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  final count = 0.obs;

  // map screen field
  var currentLatLng = Rxn<LatLng>();
  var tempLatLng = Rxn<LatLng>();
  var otherController = TextEditingController();
  var address = ''.obs;
  final searchTextController = TextEditingController();
  static var apiKey = 'AIzaSyDzQVQbsU8deMxfBC-0SPO2ixd8TGaTNBo';
  final placesService = PlacesService(apiKey);
  var suggestions = <Map<String, dynamic>>[].obs;
  late GoogleMapController mapController;
  var issheetScroll = false.obs;
  var titleAddress = ''.obs;
  var locationError = ''.obs;
  final sheetController = DraggableScrollableController();
  var allLocationData = AllLocationResponse().obs;

  @override
  void onInit() {
    fetchAllLocationApi();
    super.onInit();
  }



  bool doesLocationTypeExist(String type) {
    return allLocationData.value.addresses!.any(
          (place) => place.type.toString().toLowerCase() == type.toLowerCase(),
    );
  }

  void searchPlaces(String input) async {
    if (input.isEmpty) {
      suggestions.clear();
      return;
    }
    suggestions.value = await placesService.getAutocomplete(input);
  }

  Future<Map<String, double>> getLatLngFromPlaceId(String placeId) async {
    return await placesService.getPlaceLatLng(placeId);
  }

  void expandSheet(height) {
    issheetScroll.value = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sheetController.animateTo(
        height,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> fetchCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Location permission is required.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Denied",
        "Please enable location permission in settings.",
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final latLng = LatLng(position.latitude, position.longitude);

    currentLatLng.value = latLng;
    tempLatLng.value = latLng;
    updateAddress(latLng);
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  final Repository _repository = Repository();


  Future<void> updateAddress(LatLng latLng) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey',
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] != null && data['results'].isNotEmpty) {
          // 0 is usually the most accurate
          final result = data['results'][0];
          final formattedAddress = result['formatted_address'];
          final components = result['address_components'];
          print("result ----$result");
          // Optional: extract named business/landmark (like "Next Big Technology")
          final placeName = components.firstWhere(
                (c) =>
            c['types'].contains('premise') ||
                c['types'].contains('point_of_interest'),
            orElse: () => null,
          );

          titleAddress.value = components[1]['long_name'];
          address.value = formattedAddress;
        } else {
          address.value = "Address not found";
        }
      } else {
        address.value = "Error fetching address";
      }
    } catch (e) {
      address.value = "Error: ${e.toString()}";
    }
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void moveCameraTo(LatLng latLng) {
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    currentLatLng.value = latLng;
    tempLatLng.value = latLng;
    updateAddress(latLng);
  }

  void updateFromSearch(LatLng latLng) {
    currentLatLng.value = latLng;
    tempLatLng.value = latLng;
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    updateAddress(latLng);
  }

  void updateTempPosition(LatLng latLng) {
    tempLatLng.value = latLng;
  }

  void updateFromCameraMovement() {
    if (tempLatLng.value != null) {
      currentLatLng.value = tempLatLng.value;
      updateAddress(tempLatLng.value!);
    }
  }

  void addLocation() async {
    locationError.value ="";
    if(type.value==""){
      locationError.value = "Location type is required";

      return;
    }
    update();
    LoadingOverlay().showLoading();
    var request = {
      'type': type.value,
      'is_default': isDefault.value,
      'complete_address': address.value,
      'latitude': "${tempLatLng.value?.latitude ?? "0"}",
      'longitude': "${tempLatLng.value?.longitude ?? "0"}",
      'house_no': houseController.text,
      'save_as': type.value == "other" ? otherController.text : "",
    };
    print(request);
    try {
      await _repository.addNewAddressApi(request).then((value) {
        if (value.status == true) {
          LoadingOverlay().hideLoading();
          fetchAllLocationApi();
          houseController.clear();
          otherController.clear();
          type.value = "";
          issheetScroll.value = false;
          Get.back();
          CustomSnackBar.show(
            message: value.message ?? "Something went wrong!",
          );
        } else {
          if (value.type == "location") {
            locationError.value = value.message ?? "Something went wrong!";
          } else {
            // Get.back();
            CustomSnackBar.show(
              message: value.message ?? "Something went wrong!",
            );
          }
          LoadingOverlay().hideLoading();
        }
        update();
      });
      LoadingOverlay().hideLoading();
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(message: e.toString());
    }
    LoadingOverlay().hideLoading();
  }

  void fetchAllLocationApi() async {
    isFetchLocation.value = true;
    try {
      await _repository.fetchAddressApi().then((value) {
        if (value.status == true) {
          allLocationData.value = value;
        } else {}
        isFetchLocation.value = false;
      });
    } catch (e) {
      isFetchLocation.value = false;
      print(e.toString());
    } finally {
      isFetchLocation.value = false;
    }
  }
}
