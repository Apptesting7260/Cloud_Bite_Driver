import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/transaction_history_model.dart';

class MyWalletController extends GetxController{

  @override
  void onInit() {
    initScrollListener();
    fetchTransactionHistory();
    getWalletBalanceApi();
    super.onInit();
  }


  ScrollController scrollController = ScrollController();

  void initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 && !isLoading.value && hasMore.value) {
        loadMoreRevenue();
      }
    });
  }


  final Repository _repository = Repository();

  Rx<ApiResponse<TransactionHistoryModel>> transactionResponse = Rx<ApiResponse<TransactionHistoryModel>>(ApiResponse.loading());
  RxList<TransactionData> transactionApiData = <TransactionData>[].obs;
  RxInt currentPage = 1.obs;
  RxBool hasMore = true.obs;
  RxBool isLoading = false.obs;


  Future<void> fetchTransactionHistory({bool loadMore = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      if (!loadMore) {
        currentPage.value = 1;
        transactionResponse.value = ApiResponse.loading();
      }

      final response = await _repository.driverWithdrawTransactionAPI(
          {
            "page": currentPage.value.toString(),
            "length": "10"
          }
      );

      if (loadMore) {
        transactionApiData.addAll(response.data ?? <TransactionData>[]);

      } else {
        transactionApiData.value = response.data ?? <TransactionData>[];
      }

      hasMore.value = (response.data?.length ?? 0) >= (int.tryParse(response.pagination?.perPage ?? "10") ?? 10);
      currentPage.value += 1;

      transactionResponse.value = ApiResponse.completed(response);
    } catch (e) {
      WidgetDesigns.consoleLog(e.toString(), "errorrrrrr333333333333");
      transactionResponse.value = ApiResponse.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTopProducts() async {
    await fetchTransactionHistory();
  }

  Future<void> loadMoreRevenue() async {
    if (hasMore.value && !isLoading.value) {
      WidgetDesigns.consoleLog("Loading more data", "fetch revenue data");
      await fetchTransactionHistory(loadMore: true);
    }
  }


  RxString walletBalance = "".obs;

  getWalletBalanceApi() async {

    try{
      final apiData = await _repository.walletBalanceAPI();
      if(apiData.status == true){
        walletBalance.value = apiData.data?.wallet ?? "";
        WidgetDesigns.consoleLog("Wallet Balance Data get", apiData.data?.wallet ?? '');
      } else{
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get wallet balance", "error while get wallet balance");
      }
    }catch(e){
      WidgetDesigns.consoleLog(e.toString(), "error while get wallet balance");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }

  }


}