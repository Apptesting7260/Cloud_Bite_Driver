import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PersonalDetailsController extends GetxController{
  var isLoading = true.obs;

  @override
  void onInit() {
    getDriverData();
    super.onInit();
  }

  final Repository _repository = Repository();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  Rx<ApiResponse<GetDriverDataModel>> driverData = Rx<ApiResponse<GetDriverDataModel>>(ApiResponse.loading());
  setDriverData(ApiResponse<GetDriverDataModel> value){
    driverData.value = value;
  }

  getDriverData() async{
    setDriverData(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.getDriverDataAPI();
      if(apiData.status == true){
        isLoading.value = false;
        WidgetDesigns.consoleLog("Driver Data get", "get driver data");
        setDriverData(ApiResponse.completed(apiData));
      } else{
        isLoading.value = false;
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get driver data", "error while get driver data");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while get driver data", color: AppTheme.redText, tColor: AppTheme.white);
        setDriverData(ApiResponse.error(apiData.message?.toString() ?? "Error while get driver data"));
      }

    } catch(e){
      isLoading.value = false;
      setDriverData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get driver data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
    finally{
      isLoading.value = false;
    }
  }
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } else {
        return "No address available";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}