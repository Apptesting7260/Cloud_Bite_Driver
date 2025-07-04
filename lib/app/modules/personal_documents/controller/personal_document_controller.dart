import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PersonalDocumentController extends GetxController{
  var isLoading = true.obs;

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;


  @override
  void onInit() {
    final token = storageServices.getToken();
    print("============$token=================In Personal Document Screen");
    getPersonalDocumentListData();
    super.onInit();
  }

  final Repository _repository = Repository();

  RxList<Map<String, dynamic>> documentList = <Map<String, dynamic>>[
    {
      "route": Routes.profilePhotoScreen,
    },
    {
      "route": Routes.identityVerificationScreen,
    },
    {
      "route": Routes.drivingLicenseScreen,
    },
  ].obs;

  void updateDocumentsFromApi(List<Map<String, dynamic>> apiData) {
    documentList.value = apiData;
  }

  Rx<ApiResponse<ListPersonalDocumentModel>> listPersonalDocumentData = Rx<ApiResponse<ListPersonalDocumentModel>>(ApiResponse.loading());
  setPersonalDocumentListData(ApiResponse<ListPersonalDocumentModel> value){
    listPersonalDocumentData.value = value;
  }

  getPersonalDocumentListData() async{
    print('token');
    setPersonalDocumentListData(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.listPersonalDocumentAPI();
      if(apiData.status == true){
        WidgetDesigns.consoleLog("Personal Documents List Data get", "get personal document list data");
        setPersonalDocumentListData(ApiResponse.completed(apiData));
      } else{
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get document list data", "error while get document list data");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while document list data", color: AppTheme.redText, tColor: AppTheme.white);
        setPersonalDocumentListData(ApiResponse.error(apiData.message?.toString() ?? "Error while get data"));
      }

    } catch(e){
      setPersonalDocumentListData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get document list data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
    finally{
      isLoading.value = false;
    }
  }
}