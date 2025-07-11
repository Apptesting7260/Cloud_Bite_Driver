import 'package:cloud_bites_driver/app/core/app_exports.dart';

class NotificationScreen extends StatelessWidget{

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: AppTheme.white, title: 'Notification'),
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(14.0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}