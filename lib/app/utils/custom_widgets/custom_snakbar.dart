
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomSnackBar {
  static void show(
      {
        Color tColor=Colors.white,
        Color color= Colors.black,
        required String message,
        bool useGradient = true,
      }) {

    Fluttertoast.showToast(msg: message,backgroundColor: color, textColor: tColor, gravity: ToastGravity.TOP,);
  }
}
