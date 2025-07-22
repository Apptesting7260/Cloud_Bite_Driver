


import 'package:cloud_bites_driver/app/modules/my_profile/model/specific_date_delivery_model.dart';

import '../../../core/app_exports.dart';

class SpecificDateDeliveryController extends GetxController {

  TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  final Repository _repository = Repository();

  Rx<ApiResponse<SpecificDateDeliveryModel>> totalDeliveriesResponse = Rx<ApiResponse<SpecificDateDeliveryModel>>(ApiResponse.loading());
  RxList<SpecificDateDeliveryData> totalDeliveries = <SpecificDateDeliveryData>[].obs;
  RxInt currentPage = 1.obs;
  RxBool hasMore = true.obs;
  RxBool isLoading = false.obs;

  RxString date = WidgetDesigns.getCurrentDate().obs;

  @override
  void onInit() {
    final arg = Get.arguments;
    date.value = arg["date"] ?? WidgetDesigns.getCurrentDate();
    super.onInit();
    fetchSpecificDateDeliveries();
  }

  Future<void> fetchSpecificDateDeliveries({bool loadMore = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      if (!loadMore) {
        currentPage.value = 1;
        totalDeliveriesResponse.value = ApiResponse.loading();
      }

      final response = await _repository.specificDateDeliveriesAPI(
          {
          "date": WidgetDesigns.convertDateFormat(date.value),
          "search": searchController.text,
          "page": currentPage.value.toString(),
          "limit":"4"
          }
      );

      if (loadMore) {
        totalDeliveries.addAll(response.data ?? <SpecificDateDeliveryData>[]);
      } else {
        totalDeliveries.value = response.data ?? <SpecificDateDeliveryData>[];
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
    await fetchSpecificDateDeliveries();
  }

  Future<void> loadMoreTopProducts() async {
    if (hasMore.value && !isLoading.value) {
      await fetchSpecificDateDeliveries(loadMore: true);
    }
  }
}