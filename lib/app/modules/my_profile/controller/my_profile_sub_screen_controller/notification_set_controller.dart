import 'package:cloud_bites_driver/app/core/app_exports.dart';

class NotificationSetController extends GetxController{
  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();

  // Observable variables for notification settings
  var pushNotifications = true.obs;
  var emailNotifications = true.obs;
  var incomingDeliveries = true.obs;
  var deliveryCompleted = true.obs;
  var invoicesPayments = true.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotificationSettings();
  }

// Get notification settings from API
  Future<void> getNotificationSettings() async {
    try {
      isLoading(true);
      final response = await _repository.getNotificationSetData();
      if (response.status == true && response.data != null) {
        pushNotifications.value = response.data!.pushNotification ?? true;
        emailNotifications.value = response.data!.emailNotification ?? true;
        incomingDeliveries.value = response.data!.incomingDeliveries ?? true;
        deliveryCompleted.value = response.data!.deliveryCompleted ?? true;
        invoicesPayments.value = response.data!.invoicesPayments ?? true;
      } else {
        CustomSnackBar.show(
          message: response.message ?? 'Failed to load notification settings',
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        message: 'Error loading notification settings',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      debugPrint("Error loading notification settings: $e");
    } finally {
      isLoading(false);
    }
  }

  // Update notification settings via API
  Future<void> updateNotificationSettings() async {
    try {
      isLoading(true);
      final response = await _repository.updateNotificationSetData({
        'push_notification': pushNotifications.value.toString(),
        'email_notification': emailNotifications.value.toString(),
        'incoming_deliveries': incomingDeliveries.value.toString(),
        'delivery_completed': deliveryCompleted.value.toString(),
        'invoices_payments': invoicesPayments.value.toString(),
      });

      if (response.status == true) {
        CustomSnackBar.show(
          message: response.message ?? 'Notification settings updated successfully',
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
        await getNotificationSettings();
      } else {
        CustomSnackBar.show(
          message: response.message ?? 'Failed to update notification settings',
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
        // Revert changes if update fails
        getNotificationSettings();
      }
    } catch (e) {
      CustomSnackBar.show(
        message: 'Error updating notification settings',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      debugPrint("Error updating notification settings: $e");
      // Revert changes if update fails
      getNotificationSettings();
    } finally {
      isLoading(false);
    }
  }

}