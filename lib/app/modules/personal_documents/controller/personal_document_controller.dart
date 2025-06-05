import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PersonalDocumentController extends GetxController{

  RxList<Map<String, dynamic>> documentList = <Map<String, dynamic>>[
    {
      "title": "Profile Photo",
      "route": Routes.profilePhotoScreen,
    },
    {
      "title": "Identity Verification",
      "route": Routes.identityVerificationScreen,
    },
    {
      "title": "Driving License",
      "route": Routes.drivingLicenseScreen,
    },
  ].obs;

  void updateDocumentsFromApi(List<Map<String, dynamic>> apiData) {
    documentList.value = apiData;
  }
}