import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/controller/home_controller.dart';

class HomeScreen extends StatelessWidget{

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      WidgetDesigns.hBox(20),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: AppTheme.newLightGradient,
                        ),
                        child: Icon(Icons.menu, size: 22, color: AppTheme.primaryColor),
                      ),
                      Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppTheme.primaryColor.withOpacity(0.8),
                              AppTheme.blueColor.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetDesigns.hBox(20),
                Flexible(
                  flex: 2,
                  child: Obx(() {
                    if (controller.initialCameraPosition.value == null) {
                      return Image.asset(ImageConstants.mapImage);
                    } else {
                      return GoogleMap(
                        initialCameraPosition: controller.initialCameraPosition.value!,
                        onMapCreated: (GoogleMapController mapController) {
                          controller.mapController = mapController;
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                      );
                    }
                  }),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: CustomAnimatedButton(
                onTap: () {
                  print("Go Online tapped");
                },
                text: 'Go Online',
              ),
            ),
          ],
        ),
      ),
    );
  }
}