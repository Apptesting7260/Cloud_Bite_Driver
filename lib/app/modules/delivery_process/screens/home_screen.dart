import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/controller/bottom_sheet_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget{

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.myProfileScreen);
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: AppTheme.newLightGradient,
                        ),
                        child: Icon(Icons.menu, size: 22, color: AppTheme.primaryColor),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.notificationScreen);
                      },
                      child: Container(
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
                    ),
                  ],
                ),
              ),
              WidgetDesigns.hBox(20),
              Flexible(
                flex: 2,
                //child: Image.asset(ImageConstants.mapImage),
                child: Obx((){
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
                })
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomAnimatedButton(
              onTap: () {
                controller.toggleOnlineStatus();
              },
              text: "Go Online",
            ),
          ),
          Obx(() {
            final sheet = controller.bottomSheetController.currentSheet.value;

            if (controller.isOnline.value && sheet == BottomSheetState.none) {
              // Prevent bottomSheetController not being shown if online
              controller.bottomSheetController.showLookingForOrders();
            }

            if (!controller.isOnline.value) {
              // OFFLINE => Show "Go Online" button
              return Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: CustomAnimatedButton(
                  onTap: () {
                    controller.toggleOnlineStatus();
                  },
                  text: 'Go Online',
                ),
              );
            } else {
              // ONLINE => bottomSheet decides what to show
              switch (sheet) {
                case BottomSheetState.lookingForOrders:
                  return _buildLookingForOrdersSheet();
                default:
                  return SizedBox.shrink(); // Or future: add order arrived, etc.
              }
            }
          }),
        ],
      ),
    );
  }

  Widget _buildLookingForOrdersSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // You're Online Chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.8),
                    AppTheme.blueColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Text(
                "You're Online",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            WidgetDesigns.hBox(20),

            // Looking for orders
            Text(
              "Looking for orders",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.black,
              ),
            ),
            WidgetDesigns.hBox(8),

            // Subtext
            Text(
              "Sit back and wait while we search orders for you. It might take a while.",
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.grey,
              ),
              textAlign: TextAlign.center,
            ),
            WidgetDesigns.hBox(24),

            // Go Offline Button
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: CustomAnimatedButton(
                onTap: () {
                  controller.toggleOnlineStatus();
                },
                text: "Go Offline",
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNewOrderSheet(Map<String, dynamic> order) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("New Order"),
            Text("Pickup: ${order['pickup']}"),
            Text("Drop: ${order['drop']}"),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // send socket emit to accept
                    //controller.driverRepo.acceptOrder(order['orderId']);
                    controller.bottomSheetController.showOrderDetails(order);
                  },
                  child: Text("Accept"),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    //controller.driverRepo.rejectOrder(order['orderId']);
                    controller.bottomSheetController.showLookingForOrders();
                  },
                  child: Text("Reject"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}