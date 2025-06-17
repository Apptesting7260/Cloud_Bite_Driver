import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DocumentVerificationController extends GetxController{
  var isLoading = true.obs;

  @override
  void onInit() {
    getDocumentListData();
    super.onInit();
  }

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();

  RxList<Map<String, dynamic>> pendingDocsList = <Map<String, dynamic>>[
    {
      "image": ImageConstants.personalDocImage,
      "route": Routes.personalDocumentsScreen,
    },
    {
      "image": ImageConstants.vehicleDetailImage,
      "route": Routes.vehicleDetailsScreen,
    },
    {
      "image": ImageConstants.vehicleDetailImage,
      "route": Routes.bankDetailsScreen,
    },
  ].obs;

  Rx<ApiResponse<DocumentListModel>> documentListData = Rx<ApiResponse<DocumentListModel>>(ApiResponse.loading());
  setDocumentListData(ApiResponse<DocumentListModel> value){
    documentListData.value = value;
  }

  getDocumentListData() async{
    setDocumentListData(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.documentsListAPI();
      if(apiData.status == true){
        WidgetDesigns.consoleLog("Documents List Data get", "get document list data");
        setDocumentListData(ApiResponse.completed(apiData));
        storageServices.saveStages(apiData.stage.toString());
      } else{
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get document list data", "error while get document list data");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while document list data", color: AppTheme.redText, tColor: AppTheme.white);
        setDocumentListData(ApiResponse.error(apiData.message?.toString() ?? "Error while get data"));
      }

    } catch(e){
      setDocumentListData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get document list data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
    finally{
      isLoading.value = false;
    }
  }
}