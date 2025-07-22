import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/gradient_switch.dart';

class NotificationSettingsScreen extends StatelessWidget {
  NotificationSettingsScreen({super.key});
  final NotificationSetController controller = Get.put(NotificationSetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: AppTheme.white , title: "Notification"),
      body: Obx((){
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(20),
              Obx((){
                return  _buildNotificationSwitch(
                  title: 'Push notification',
                  subtitle: 'Allow the app to push notification in application',
                  value: controller.pushNotifications.value,
                  onChanged: (value) {
                    controller.pushNotifications.value = value;
                    controller.updateNotificationSettings();
                  },
                );
              }),
            _buildNotificationSwitch(
              title: 'Email notification',
              subtitle: 'Forward all account notifications to your email address',
              value: controller.emailNotifications.value,
              onChanged: (value) {
                controller.emailNotifications.value = value;
                controller.updateNotificationSettings();
              },
            ),
            _buildNotificationSwitch(
              title: 'Incoming deliveries',
              subtitle: 'Allow announce notifications of new incoming deliveries',
              value: controller.incomingDeliveries.value,
              onChanged: (value) {
                controller.incomingDeliveries.value = value;
                controller.updateNotificationSettings();
              },
            ),
            _buildNotificationSwitch(
              title: 'Delivery completed',
              subtitle: 'Notify when the delivery has arrived to the destination',
              value: controller.deliveryCompleted.value,
              onChanged: (value) {
                controller.deliveryCompleted.value = value;
                controller.updateNotificationSettings();
              },
            ),
          _buildNotificationSwitch(
            title: 'Invoices & payments',
            subtitle: 'Send notifications about complete payments',
            value: controller.invoicesPayments.value,
            onChanged: (value) {
              controller.invoicesPayments.value = value;
              controller.updateNotificationSettings();
            },
          ),
            ],
          ),
        );
      })
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                ),
                WidgetDesigns.hBox(4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          GradientSwitch(
              value: value,
              onChanged: onChanged)
        ],
      ),
    );
  }
}