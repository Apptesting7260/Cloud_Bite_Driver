import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/transaction_history_model.dart';

class MyWalletController extends GetxController{
  var items = List.generate(
    4,
        (index) {
      // Different images for each index
      final images = [
        ImageConstants.supportIcon,
        ImageConstants.supportIcon,
        ImageConstants.supportIcon,
        ImageConstants.supportIcon,
      ];
      final name = [
        '#SP0023900',
        '#SP0023900',
        '#SP0023900',
        '#SP0023900',
      ];
      final dateTime = [
        'Mon, 04 Apr - 12:00 AM',
        'Mon, 04 Apr - 12:00 AM',
        'Mon, 04 Apr - 12:00 AM',
        'Mon, 04 Apr - 12:00 AM',
      ];

      final count = [
        '-P37',
        '+P100',
        '-P37',
        '+P100'
      ];

      final status = [
        'Refund',
        'Credit',
        'Refund',
        'Credit'
      ];

      final countColor = [
        AppTheme.redText,
        AppTheme.green,
        AppTheme.redText,
        AppTheme.green,
      ];

      return {
        "images": images[index],
        "name": name[index],
        "dateTime": dateTime[index],
        "count": count[index],
        "status": status[index],
        "countColor": countColor[index]
      };
    },
  ).obs;

  @override
  void onInit() {
    initScrollListener();
    fetchTransactionHistory();
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






}