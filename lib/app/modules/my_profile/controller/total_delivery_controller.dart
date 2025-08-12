


import 'package:cloud_bites_driver/app/modules/my_profile/model/total_delivery_model.dart';

import '../../../core/app_exports.dart';

class TotalDeliveryController extends GetxController {

  final Repository _repository = Repository();

  final isFromEarnings = Get.arguments?['isFromEarnings'] ?? false;

  Rx<ApiResponse<TotalDeliveryModel>> totalDeliveriesResponse = Rx<ApiResponse<TotalDeliveryModel>>(ApiResponse.loading());
  RxList<TotalDeliveryData> totalDeliveries = <TotalDeliveryData>[].obs;
  RxInt currentPage = 1.obs;
  RxBool hasMore = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (isFromEarnings) {
      fetchTotalDeliveryAPI();
    } else {
      fetchTopProducts();
    }
    //fetchTopProducts();
  }

  Future<void> fetchTopProducts({bool loadMore = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      if (!loadMore) {
        currentPage.value = 1;
        totalDeliveriesResponse.value = ApiResponse.loading();
      }

      final response = await _repository.totalDeliveriesAPI(
          {
          "page": currentPage.value.toString(),
          "limit":"10",
          "filter": selectedFilter.value == "All" ? "" : selectedFilter.value == "This Month" ? "this_month" : "this_year",
          }
      );

      if (loadMore) {
        totalDeliveries.addAll(response.data ?? <TotalDeliveryData>[]);
      } else {
        totalDeliveries.value = response.data ?? <TotalDeliveryData>[];
      }

      hasMore.value = (response.data?.length ?? 0) >= (int.tryParse(response.limit ?? "10") ?? 10);
      currentPage.value += 1;

      totalDeliveriesResponse.value = ApiResponse.completed(response);
    } catch (e) {
      totalDeliveriesResponse.value = ApiResponse.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTotalDeliveryAPI({bool loadMore = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      if (!loadMore) {
        currentPage.value = 1;
        totalDeliveriesResponse.value = ApiResponse.loading();
      }

      final response = await _repository.totalDeliveriesAPI(
          {
            "start_date": Get.arguments?['startDate'] ?? '',
            "end_date": Get.arguments?['endDate'] ?? '',
            "page": currentPage.value.toString(),
            "length": "10",
          }
      );

      if (loadMore) {
        totalDeliveries.addAll(response.data ?? <TotalDeliveryData>[]);
      } else {
        totalDeliveries.value = response.data ?? <TotalDeliveryData>[];
      }

      hasMore.value = (response.data?.length ?? 0) >= (int.tryParse(response.limit ?? "10") ?? 10);
      currentPage.value += 1;

      totalDeliveriesResponse.value = ApiResponse.completed(response);
    } catch (e) {
      totalDeliveriesResponse.value = ApiResponse.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  RxString selectedFilter = 'All'.obs;

  Future<void> refreshTopProducts() async {
    await fetchTopProducts();
  }

  Future<void> loadMoreTopProducts() async {
    if (hasMore.value && !isLoading.value) {
      await fetchTopProducts(loadMore: true);
    }
  }
}