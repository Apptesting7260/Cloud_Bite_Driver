import 'package:cloud_bites_driver/app/core/app_exports.dart';

class HomeController extends GetxController{
/*  GoogleMapController? mapController;
  Rx<CameraPosition?> initialCameraPosition = Rx<CameraPosition?>(null);

  @override
  void onInit() {
    super.onInit();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    final userLocation = await location.getLocation();

    initialCameraPosition.value = CameraPosition(
      target: LatLng(userLocation.latitude!, userLocation.longitude!),
      zoom: 14.0,
    );
  }*/
}