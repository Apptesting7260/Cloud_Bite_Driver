import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SupportController extends GetxController{
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  updateSearchQuery(String searchController){
    _searchController.text = searchController;
    _searchQuery = searchController;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();



  final Repository _repository = Repository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  updateLoading(bool value){
    _isLoading = value;
    update();
  }

  bool _isValidation = true;
  bool get isValidation => _isValidation;
  updateValidation(bool value){
    _isValidation = value;
    update();
  }

  Future<void> contactUsApi() async {
    LoadingOverlay().showLoading();
    try {
      final data = {
        "message": messageController.text,
      };

      final response = await _repository.contactSupportAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        updateValidation(false);
        messageController.clear();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else if(response.status == false && response.type == 'support'){
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), "error while contact us");
      }
      else {
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Want Support');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

}