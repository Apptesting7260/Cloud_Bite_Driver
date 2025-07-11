import 'package:cloud_bites_driver/app/core/app_exports.dart';

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
}