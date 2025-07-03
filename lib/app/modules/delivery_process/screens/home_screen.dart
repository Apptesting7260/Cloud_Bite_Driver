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
                case BottomSheetState.newOrderArrived:
                  return _buildOrderAvailableSheet();
                case BottomSheetState.acceptedOrderSheet:
                  return _acceptedOrderSheet();
                default:
                  return SizedBox.shrink();
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
            CustomAnimatedButton(
              onTap: () {
                controller.toggleOnlineStatus();
              },
              text: "Go Offline",
            ),
          ],
        ),
      ),
    );
  }


  // Order Coming Sheet------
  Widget _buildOrderAvailableSheet() {
    final order = Get.find<BottomSheetController>().currentOrder.value;
    if (order == null) return SizedBox.shrink();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.remainingTime.value == controller.totalTime) {
        controller.startTimer();
      }
    });

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order.pickupDistance} (${order.deliveryTime})",
                      style: TextStyle(
                          fontFamily: AppFontFamily.generalSansMedium,
                          color: AppTheme.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                      //style: AppFontStyle.text_20_500(AppTheme.black, fontFamily: AppFontFamily),
                    ),
                    WidgetDesigns.hBox(10),
                    Row(
                      children: [
                        Text(
                          "Order ID : ",
                          style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        WidgetDesigns.wBox(5),
                        Text(
                          "${order.orderNumber}",
                          style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                      ],
                    ),
                    WidgetDesigns.hBox(16),
                    Row(
                      children: [
                        Text(
                          "${order.quantity} item${(int.tryParse(order.quantity ?? '0')?? 0) > 1 ? 's' : ''}",
                          style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        WidgetDesigns.wBox(5),
                        SvgPicture.asset(ImageConstants.ellipseImage),
                        WidgetDesigns.wBox(5),
                        Text(
                          "P${ order.totalAmount}",
                          style: AppFontStyle.text_18_400(AppTheme.red, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                      ],
                    ),
                  ],
                ),
                Obx(() {
                  final remainingTime = controller.remainingTime.value;
                  final progress = remainingTime / controller.totalTime;
                  Color timerColor;

                  // Change color based on remaining time
                  if (progress > 0.5) {
                    timerColor = AppTheme.primaryColor;
                  } else if (progress > 0.25) {
                    timerColor = AppTheme.blueColor;
                  } else {
                    timerColor = AppTheme.grey;
                  }

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(timerColor),
                          strokeWidth: 4,
                        ),
                      ),
                      Text(
                        '$remainingTime',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: timerColor,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            WidgetDesigns.hBox(16),
            _buildLocationRow(
              title: "Pickup Location",
              address: "${order.restaurantName}",
              time: order.pickupDuration,
            ),
            WidgetDesigns.hBox(16),

            _buildLocationRow(
              title: "Delivery Location",
              address: order.userAddress.split(',').take(3).join(','),
              time: order.deliveryDuration,
            ),
            WidgetDesigns.hBox(24),
            Column(
              children: [
                CustomAnimatedButton(
                  onTap: () {
                    controller.stopTimer();
                    controller.bottomSheetController.acceptOrder();
                  },
                  text: "Accept Order",
                ),
                WidgetDesigns.hBox(16),
                GestureDetector(
                  onTap: () {
                    controller.bottomSheetController.rejectOrder();
                  },
                  child: Text('Reject Order',
                  style: TextStyle(
                    color: AppTheme.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                  )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow({
    required String title,
    required String address,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(8),
              Row(
                children: [
                  Icon(Icons.location_on, color: AppTheme.blueColor, size: 16),
                  WidgetDesigns.wBox(5),
                  Expanded(
                    child: Text(
                      address,
                      style: AppFontStyle.text_14_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular,overflow: TextOverflow.clip),
                    ),
                  ),
                  WidgetDesigns.wBox(5),
                  Text(
                    time,
                    style: AppFontStyle.text_14_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }



  // AcceptedOrderScreen
  Widget _acceptedOrderSheet() {
    final List<Map<String, String>> orderItems = [
      {
        'name': 'Butter Chicken And Rice',
        'size': 'Small',
        'quantity': 'Qty: 2'
      },
      {
        'name': 'Butter Chicken And Rice',
        'size': 'Small',
        'quantity': 'Qty: 2'
      },
      {
        'name': 'Butter Chicken And Rice',
        'size': 'Small',
        'quantity': 'Qty: 2'
      },
    ];
    final orderDetails = Get.find<BottomSheetController>().orderDetails.value;
    if (orderDetails == null) return SizedBox.shrink();
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          // margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle (removed to match image)
                // Order header
                Text(
                    "${orderDetails.data?.orderDetail?.userdata?.firstName} " " ${orderDetails.data?.orderDetail?.userdata?.lastName}",
                    style: AppFontStyle.text_20_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium)
                ),
                WidgetDesigns.hBox(8),
                Text(
                    "${orderDetails.data?.orderDetail?.orderdata?.orderId}",
                    style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular)
                ),
                WidgetDesigns.hBox(10),
                Row(
                  children: [
                    Text(
                      "${orderDetails.data?.orderDetail?.orderdata?.quantity} item",
                      style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                    ),
                    WidgetDesigns.wBox(5),
                    SvgPicture.asset(ImageConstants.ellipseImage),
                    WidgetDesigns.wBox(5),
                    Text(
                      "P${orderDetails.data?.orderDetail?.orderdata?.deliveryCharge}",
                      style: AppFontStyle.text_18_400(AppTheme.red, fontFamily: AppFontFamily.generalSansRegular),
                    ),
                  ],
                ),
                WidgetDesigns.hBox(24),
                // Location info
                _buildLocationRow(
                  title: "Pickup Location",
                  address: "${orderDetails.data?.orderDetail?.vendordata?.address}",
                  time: "${orderDetails.data?.pickUpLocation?.distance}",
                ),
                WidgetDesigns.hBox(16),
            
                _buildLocationRow(
                  title: "Delivery Location",
                  address: "${orderDetails.data?.orderDetail?.userAddressData?.completeAddress}",
                  time: "${orderDetails.data?.deliveryLocation?.distance}",
                ),
                WidgetDesigns.hBox(16),
            
                _buildLocationRow(
                  title: "Payment Method",
                  address: "Credit Card",
                  time: "",
                ),
                WidgetDesigns.hBox(24),
            
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [Color(0xFFF8EEF4), Color(0xFFEFF7FC)],
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageConstants.profileNameIcon),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                            'Daniel Smith',
                            style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium)
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFFB6568E), Color(0xFF5FB6E3)]
                          ),
                        ),
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
            
                WidgetDesigns.hBox(16),
            
                SizedBox(
                  height: orderItems.length * 72.0, // Adjust height based on item count
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    itemCount: orderItems.length,
                    itemBuilder: (context, index) {
                      return _buildSimpleOrderItem(
                        orderItems[index]['name']!,
                        orderItems[index]['size']!,
                        orderItems[index]['quantity']!,
                      );
                    },
                  ),
                ),
            
                WidgetDesigns.hBox(16),
            
                // Payment details
                Text(
                  'Payment Details',
                  style: AppFontStyle.text_20_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                ),
                WidgetDesigns.hBox(10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Status',
                          style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        Text(
                          'Paid',
                          style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                        )
                      ],
                    ),
                    WidgetDesigns.hBox(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppFontStyle.text_18_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        Text(
                          'P100',
                          style: AppFontStyle.text_18_500(AppTheme.redText, fontFamily: AppFontFamily.generalSansMedium),
                        )
                      ],
                    ),
                  ],
                ),
                WidgetDesigns.hBox(30),
                CustomAnimatedButton(
                  onTap: () {},
                  text: "Send Code",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Simplified order item widget
  Widget _buildSimpleOrderItem(String name, String size, String quantity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Image.asset(ImageConstants.profile),
          WidgetDesigns.wBox(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppFontStyle.text_16_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium)),
              WidgetDesigns.hBox(4),
              Text(size, style: TextStyle(color: Colors.grey)),
              WidgetDesigns.hBox(4),
              Text(quantity, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}