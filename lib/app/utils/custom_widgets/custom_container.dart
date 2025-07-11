
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomContainer extends StatelessWidget {
  Widget content;
  void Function()? ontap;
  Gradient ? gradient;
  CustomContainer({super.key,this.ontap,this.gradient, required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(top: 10,right: 20,left: 20,bottom:10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient:gradient
        ),
        child:content,
      ),
    );
  }
}
