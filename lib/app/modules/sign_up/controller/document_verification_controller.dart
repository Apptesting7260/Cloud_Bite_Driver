import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DocumentVerificationController extends GetxController{

  RxList<Map<String, dynamic>> pendingDocsList = <Map<String, dynamic>>[
    {
      "title": "Personal Documents",
      "image": ImageConstants.personalDocImage,
      "route": Routes.personalDocumentsScreen,
    },
    {
      "title": "Vehicle Details",
      "image": ImageConstants.vehicleDetailImage,
      "route": Routes.vehicleDetailsScreen,
    },
    {
      "title": "Bank Account Details",
      "image": ImageConstants.vehicleDetailImage,
      "route": Routes.bankDetailsScreen,
    },
  ].obs;

  void updateDocumentsFromApi(List<Map<String, dynamic>> apiData) {
    pendingDocsList.value = apiData;
  }

}