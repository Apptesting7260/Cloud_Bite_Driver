import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportController extends GetxController{
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  @override
  void onInit() {
    getFaqData();
    super.onInit();
  }


  List<String> buttonText = [
    "General",
    "Account",
    "Service",
    "Payment",
  ];

  RxString selectedButton = "General".obs;

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


  Future<void> launchWhatsApp(String phone,) async {
    final Uri url = Uri.parse("https://wa.me/$phone");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch whatsApp';
    }
  }


  Future<void> openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'businessdev@cloudbitesbw.com',
      queryParameters: {
        'subject': 'Support Request',
        'body': '',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      // Try launching default email app
      await launchUrl(emailUri, mode: LaunchMode.platformDefault);
    } else {
      // Fallback → open Gmail in browser
      final Uri gmailUri = Uri.parse(
        "https://mail.google.com/mail/?view=cm&fs=1"
            "&to=businessdev@cloudbitesbw.com"
            "&su=Support%20Request"
            "&body=Hi%2C%20I%20need%20help%20with...",
      );

      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
      } else {
        print("No email client or Gmail available.");
      }
    }
  }

  Rx<ApiResponse<FaqModel>> faqData = Rx<ApiResponse<FaqModel>>(ApiResponse.loading());
  setFaqData(ApiResponse<FaqModel> value){
    faqData.value = value;
    update();
  }

  Future<void> getFaqData() async {
    setFaqData(ApiResponse.loading());
    try{
      final apiData = await _repository.getFaqAPI();
      if(apiData.status == true){
        setFaqData(ApiResponse.completed(apiData));
      }else{
        WidgetDesigns.consoleLog("Error", " else Error while get faq data");
        setFaqData(ApiResponse.error("Error while get faq data"));
      }
    }catch(e){
      WidgetDesigns.consoleLog(e.toString(), "Error while get faq data");
      CustomSnackBar.show(message: e.toString());
      setFaqData(ApiResponse.error("Error while get faq data"));
    }
  }


  // In HelpAndSupportController

// Get the current active list based on selected tab
  RxList<CommonFaqData>? get currentFaqList {
    switch (selectedButton.value) {
      case "General":
        return faqData.value.data?.data?.general;
      case "Account":
        return faqData.value.data?.data?.account;
      case "Service":
        return faqData.value.data?.data?.service;
      case "Payment":
        return faqData.value.data?.data?.payment;
      default:
        return null;
    }
  }

// Filter the current list based on search query
  RxList<CommonFaqData>? get filteredFaqList {
    if (_searchQuery.isEmpty) return currentFaqList;

    return currentFaqList?.where((faq) {
      final question = faq.question?.toLowerCase() ?? '';
      final answer = faq.answer?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();
      return question.contains(query) || answer.contains(query);
    }).toList().obs;
  }

}