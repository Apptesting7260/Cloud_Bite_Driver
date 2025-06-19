import 'package:cloud_bites_driver/app/constants/image_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/custom_widgets/my_text.dart';
import '../controllers/no_internet_connection_controller.dart';

class NoInternetConnectionView extends GetView<NoInternetConnectionController> {
  const NoInternetConnectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false, // 🔒 Prevent back
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageConstants.no_internet_IMAGE,height:100,width: 100,),
                SizedBox(height: 25,),
                MyText(title: "Whoops!",tColor: Colors.black,fSize: 24,),
                SizedBox(height: 20,),
                MyText(title: "No Internet Connection found",fSize: 18,fWeight: FontWeight.w400,),
                MyText(title: "Check your connection or try again",fSize: 18,fWeight: FontWeight.w400,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
