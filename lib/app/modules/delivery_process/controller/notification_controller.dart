import 'package:cloud_bites_driver/app/core/app_exports.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNotificationAPi();
  }

  final Repository repository = Repository();

  Rx<ApiResponse<NotificationResponseModel>> notificationResponse = Rx<ApiResponse<NotificationResponseModel>>(ApiResponse.loading());

  RxInt currentPage = 1.obs;
  RxBool hasMorePages = true.obs;
  bool isLoadingMore = false;

  /// Call this to initially or additionally load data
  Future<void> getNotificationAPi({bool isPagination = false}) async {
    if (isPagination && isLoadingMore) return;

    if (isPagination) {
      isLoadingMore = true;
    } else {
      notificationResponse.value = ApiResponse.loading();
      currentPage.value = 1;
      hasMorePages.value = true;
    }

    try {
      final response = await repository.notificationAPI({"page_number": currentPage.value});

      if (response.status == true) {
        final existingData = notificationResponse.value.data?.data ?? {};

        // Merge old + new paginated data
        if (isPagination) {
          response.data.forEach((key, value) {
            if (existingData.containsKey(key)) {
              existingData[key]?.addAll(value);
            } else {
              existingData[key] = value;
            }
          });
          notificationResponse.value = ApiResponse.completed(
            NotificationResponseModel(
              status: true,
              message: response.message,
              data: existingData,
              currentPage: response.currentPage,
              totalPages: response.totalPages,
              totalNotifications: response.totalNotifications,
            ),
          );
        } else {
          setNotificationData(ApiResponse.completed(response));
        }

        // Update pagination flags
        currentPage.value++;
        hasMorePages.value = currentPage.value <= (int.parse(response.totalPages ?? '1'));
      } else {
        setNotificationData(ApiResponse.error(response.message.toString()));
        WidgetDesigns.consoleLog(response.message.toString(), "error response");
      }
    } catch (e) {
      setNotificationData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "catch error notification");
      LoadingOverlay().hideLoading();
    } finally {
      isLoadingMore = false;
    }
  }

  void setNotificationData(ApiResponse<NotificationResponseModel> response) {
    notificationResponse.value = response;
  }
}