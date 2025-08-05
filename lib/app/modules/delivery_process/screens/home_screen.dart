import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/controller/bottom_sheet_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
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
                        child: Icon(
                          Icons.menu,
                          size: 22,
                          color: AppTheme.primaryColor,
                        ),
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
                child: Obx(() {
                  if (controller.initialCameraPosition.value == null) {
                    return Image.asset(ImageConstants.mapImage);
                  } else {
                    return GoogleMap(
                      /*initialCameraPosition:
                          controller.initialCameraPosition.value!,*/
                      initialCameraPosition: controller.initialCameraPosition.value ?? CameraPosition(
                        target: LatLng(0, 0),
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController mapController) {
                        controller.mapController = mapController;
                        if (controller.orderDetails.value != null) {
                          controller.updateMapWithDirections();
                        }
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: controller.markers.toSet(),
                      polylines: controller.polylines.toSet(),
                      zoomControlsEnabled: true,
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
                case BottomSheetState.sendOtpSheet:
                  return _sendOtpSheet();
                case BottomSheetState.orderPickedSheet:
                  return _orderPickedUpSheet();
                case BottomSheetState.afterReadyForDeliveryBuild:
                  return afterReadyForDeliveryBuild();
                case BottomSheetState.orderDeliveredSheet:
                  return orderDeliveredUpSheet();
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
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
              style: TextStyle(fontSize: 14, color: AppTheme.grey),
              textAlign: TextAlign.center,
            ),
            WidgetDesigns.hBox(16),

            // Pulse loader
            SpinKitPulse(
              color: AppTheme.primaryColor,
              size: 60.0,
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
      if (Get.find<BottomSheetController>().currentSheet.value ==
          BottomSheetState.newOrderArrived && (controller.remainingTime.value == controller.totalTime)) {
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
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
            Container(
              margin: EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            WidgetDesigns.hBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.restaurantName,
                      style: AppFontStyle.text_20_500(
                        AppTheme.black,
                        fontFamily: AppFontFamily.generalSansMedium,
                      ),
                    ),
                    WidgetDesigns.hBox(10),
                    Text(
                      "${order.pickupDistance} (${order.deliveryTime})",
                      style: TextStyle(
                        fontFamily: AppFontFamily.generalSansMedium,
                        color: AppTheme.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      //style: AppFontStyle.text_20_500(AppTheme.black, fontFamily: AppFontFamily),
                    ),
                    WidgetDesigns.hBox(10),
                    Row(
                      children: [
                        Text(
                          "Order ID : ",
                          style: AppFontStyle.text_18_400(
                            AppTheme.grey,
                            fontFamily: AppFontFamily.generalSansRegular,
                          ),
                        ),
                        WidgetDesigns.wBox(5),
                        Text(
                          order.orderNumber,
                          style: AppFontStyle.text_18_400(
                            AppTheme.grey,
                            fontFamily: AppFontFamily.generalSansRegular,
                          ),
                        ),
                      ],
                    ),
                    WidgetDesigns.hBox(16),
                    Row(
                      children: [
                        Text(
                          "${order.quantity} item${(int.tryParse(order.quantity ?? '0') ?? 0) > 1 ? 's' : ''}",
                          style: AppFontStyle.text_18_400(
                            AppTheme.grey,
                            fontFamily: AppFontFamily.generalSansRegular,
                          ),
                        ),
                        WidgetDesigns.wBox(5),
                        SvgPicture.asset(ImageConstants.ellipseImage),
                        WidgetDesigns.wBox(5),
                        Text(
                          "P${order.deliveryCharge}",
                          style: AppFontStyle.text_18_400(
                            AppTheme.red,
                            fontFamily: AppFontFamily.generalSansRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                controller.bottomSheetController.orderDetails.value?.data?.pickUp == true
                    ? SizedBox()
                    : Obx(() {
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                timerColor,
                              ),
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
              address: order.restaurantName,
              time: order.pickupDuration,
              pickUp:
                  controller
                      .bottomSheetController
                      .orderDetails
                      .value
                      ?.data
                      ?.pickUp ??
                  false,
            ),

            WidgetDesigns.hBox(16),

            _buildLocationRow(
              title: "Delivery Location",
              address: order.userAddress.split(',').take(3).join(','),
              time: order.deliveryDuration,
            ),
            WidgetDesigns.hBox(24),
            controller.bottomSheetController.orderDetails.value?.data?.pickUp ==
                    true
                ? CustomAnimatedButton(
                  onTap: () {
                    controller.readyForDeliveryEvent();
                  },
                  text: "Ready For Delivery",
                )
                : Column(
                  children: [
                    CustomAnimatedButton(
                      onTap: () {
                        controller.bottomSheetController.acceptOrder();
                        controller.stopAcceptanceTimer();
                      },
                      text: "Accept Order",
                    ),
                    WidgetDesigns.hBox(16),
                    GestureDetector(
                      onTap: () {
                        controller.bottomSheetController.rejectOrder();
                      },
                      child: Text(
                        'Reject Order',
                        style: TextStyle(
                          color: AppTheme.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
    bool pickUp = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: AppFontStyle.text_18_500(
                      AppTheme.black,
                      fontFamily: AppFontFamily.generalSansMedium,
                    ),
                  ),
                  WidgetDesigns.wBox(10),
                  pickUp
                      ? MyText(title: "Completed", tColor: AppTheme.green)
                      : SizedBox(),
                ],
              ),
              WidgetDesigns.hBox(8),
              Row(
                children: [
                  Icon(Icons.location_on, color: AppTheme.blueColor, size: 16),
                  WidgetDesigns.wBox(5),
                  Expanded(
                    child: Text(
                      address,
                      style: AppFontStyle.text_14_400(
                        AppTheme.grey,
                        fontFamily: AppFontFamily.generalSansRegular,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  WidgetDesigns.wBox(5),
                  Text(
                    time,
                    style: AppFontStyle.text_14_400(
                      AppTheme.black,
                      fontFamily: AppFontFamily.generalSansRegular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

 /* // Accepted Order sheet
  Widget _acceptedOrderSheet() {
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
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
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                WidgetDesigns.hBox(20),
                Text(
                  "${orderDetails.data?.orderDetail?.vendordata?.restaurantName}",
                  style: AppFontStyle.text_20_500(
                    AppTheme.black,
                    fontFamily: AppFontFamily.generalSansMedium,
                  ),
                ),
                WidgetDesigns.hBox(8),
                Text(
                  "${orderDetails.data?.orderDetail?.orderdata?.orderId}",
                  style: AppFontStyle.text_18_400(
                    AppTheme.grey,
                    fontFamily: AppFontFamily.generalSansRegular,
                  ),
                ),
                WidgetDesigns.hBox(10),
                Row(
                  children: [
                    Text(
                      "${orderDetails.data?.orderDetail?.orderdata?.quantity} item",
                      style: AppFontStyle.text_18_400(
                        AppTheme.grey,
                        fontFamily: AppFontFamily.generalSansRegular,
                      ),
                    ),
                    WidgetDesigns.wBox(5),
                    SvgPicture.asset(ImageConstants.ellipseImage),
                    WidgetDesigns.wBox(5),
                    Text(
                      "P${orderDetails.data?.orderDetail?.orderdata?.deliveryCharge}",
                      style: AppFontStyle.text_18_400(
                        AppTheme.red,
                        fontFamily: AppFontFamily.generalSansRegular,
                      ),
                    ),
                  ],
                ),
                WidgetDesigns.hBox(24),
                // Location info
                _buildLocationRow(
                  title: "Pickup Location",
                  address:
                      "${orderDetails.data?.orderDetail?.vendordata?.address}",
                  time: "${orderDetails.data?.pickUpLocation?.distance}",
                ),
                WidgetDesigns.hBox(16),
                _buildLocationRow(
                  title: "Delivery Location",
                  address:
                      "${orderDetails.data?.orderDetail?.userAddressData?.completeAddress}",
                  time: "${orderDetails.data?.deliveryLocation?.distance}",
                ),
                WidgetDesigns.hBox(16),
                Text(
                  'Payment Method',
                  style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                ),
                WidgetDesigns.hBox(10),
                Row(
                  children: [
                    Icon(Icons.camera_alt, color: AppTheme.blueColor, size: 16),
                    WidgetDesigns.wBox(5),
                    Text(
                      "${orderDetails.data?.orderDetail?.orderdata?.paymentMethod}",
                      style: AppFontStyle.text_14_400(
                        AppTheme.grey,
                        fontFamily: AppFontFamily.generalSansRegular,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppUrls.imageUrl}${orderDetails.data?.orderDetail?.userdata?.image}",
                              placeholder:
                                  (context, url) =>
                                      ShimmerBox(width: 20, height: 20),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        WidgetDesigns.wBox(12),
                        Expanded(
                          child: Text(
                            "${orderDetails.data?.orderDetail?.userdata?.firstName} "
                            " ${orderDetails.data?.orderDetail?.userdata?.lastName}",
                            style: AppFontStyle.text_18_500(
                              AppTheme.black,
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final phoneNumber = orderDetails.data?.orderDetail?.userdata?.phone ?? '';
                            final url = 'tel:$phoneNumber';

                            try {
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                Get.snackbar('Error', 'Could not launch dialer');
                              }
                            } catch (e) {
                              Get.snackbar('Error', 'Failed to make call: ${e.toString()}');
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFB6568E), Color(0xFF5FB6E3)],
                              ),
                            ),
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                WidgetDesigns.hBox(16),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      orderDetails.data?.orderDetail?.orderItemsData?.length,
                  itemBuilder: (context, index) {

                    final item = orderDetails.data?.orderDetail?.orderItemsData?[index];
                    String variantOrAddon = "";

                    // Handle variants first
                    if (item?.variant != null && item!.variant!.isNotEmpty) {
                      variantOrAddon = item.variant!.map((v) => v.datumName ?? "").join(", ");
                    }
                    // Then handle add-ons if no variants
                    else if (item?.addOns != null && item!.addOns!.isNotEmpty) {
                      variantOrAddon = item.addOns!.map((a) => a.name ?? "").join(", ");
                    }

                    return _buildSimpleOrderItem(
                      "${item?.productImages?[0]}",
                      "${item?.productTitle?[0]}",
                      variantOrAddon,
                      "${item?.quantity}"
                    );
                  },
                ),
                WidgetDesigns.hBox(16),
                // Payment details
                Text(
                  'Payment Details',
                  style: AppFontStyle.text_20_500(
                    AppTheme.black,
                    fontFamily: AppFontFamily.generalSansMedium,
                  ),
                ),
                WidgetDesigns.hBox(10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Status',
                          style: AppFontStyle.text_18_400(
                            AppTheme.grey,
                            fontFamily: AppFontFamily.generalSansRegular,
                          ),
                        ),
                        Text(
                          "${orderDetails.data?.orderDetail?.orderdata?.paymentStatus}",
                          style: AppFontStyle.text_18_500(
                            AppTheme.black,
                            fontFamily: AppFontFamily.generalSansMedium,
                          ),
                        ),
                      ],
                    ),
                    WidgetDesigns.hBox(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppFontStyle.text_18_400(
                            AppTheme.grey,
                            fontFamily: AppFontFamily.generalSansRegular,
                          ),
                        ),
                        Text(
                          "P${orderDetails.data?.orderDetail?.orderdata?.totalAmount}",
                          style: AppFontStyle.text_18_500(
                            AppTheme.redText,
                            fontFamily: AppFontFamily.generalSansMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                WidgetDesigns.hBox(30),
                CustomAnimatedButton(
                  onTap: () {
                    controller.sendOtp();
                  },
                  text: "Send Code",
                ),
                Obx(() {
                  if (!controller.isSlid.value) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFB6568E),
                            Color(0xFF5FB6E3),
                            Color(0xFFDAEAF4),
                          ],
                        ),
                      ),
                      child: SlideAction(
                        text: 'Slide After Arrival',
                        textStyle: TextStyle(color: Colors.white, fontSize: 16),
                        outerColor: Colors.transparent,
                        innerColor: Colors.transparent,
                        sliderButtonIcon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        elevation: 0,
                        height: 56,
                        borderRadius: 40,
                        sliderRotate: false,
                        submittedIcon: Icon(Icons.check, color: Colors.white),
                        onSubmit: () {
                          controller.onSlideCompleted();
                        },
                      ),
                    );
                  } else {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: CustomAnimatedButton(
                        key: ValueKey("sendOtpBtn"),
                        onTap: () {
                          controller.sendOtp();
                        },
                        text: "Send Code",
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        );
      },
    );
  }*/


  Widget _acceptedOrderSheet() {
    final orderDetails = Get.find<BottomSheetController>().orderDetails.value;
    if (orderDetails == null) return SizedBox.shrink();
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              // Scrollable part
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        alignment: Alignment.center,
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      WidgetDesigns.hBox(20),
                      Text(
                        "${orderDetails.data?.orderDetail?.vendordata?.restaurantName}",
                        style: AppFontStyle.text_20_500(
                          AppTheme.black,
                          fontFamily: AppFontFamily.generalSansMedium,
                        ),
                      ),
                      WidgetDesigns.hBox(8),
                      Text(
                        "${orderDetails.data?.orderDetail?.orderdata?.orderId}",
                        style: AppFontStyle.text_18_400(
                          AppTheme.grey,
                          fontFamily: AppFontFamily.generalSansRegular,
                        ),
                      ),
                      WidgetDesigns.hBox(10),
                      Row(
                        children: [
                          Text(
                            "${orderDetails.data?.orderDetail?.orderdata?.quantity} item",
                            style: AppFontStyle.text_18_400(
                              AppTheme.grey,
                              fontFamily: AppFontFamily.generalSansRegular,
                            ),
                          ),
                          WidgetDesigns.wBox(5),
                          SvgPicture.asset(ImageConstants.ellipseImage),
                          WidgetDesigns.wBox(5),
                          Text(
                            "P${orderDetails.data?.orderDetail?.orderdata?.deliveryCharge}",
                            style: AppFontStyle.text_18_400(
                              AppTheme.red,
                              fontFamily: AppFontFamily.generalSansRegular,
                            ),
                          ),
                        ],
                      ),
                      WidgetDesigns.hBox(24),
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
                      Text(
                        'Payment Method',
                        style: AppFontStyle.text_18_500(AppTheme.black,
                            fontFamily: AppFontFamily.generalSansMedium),
                      ),
                      WidgetDesigns.hBox(10),
                      Row(
                        children: [
                          Icon(Icons.camera_alt, color: AppTheme.blueColor, size: 16),
                          WidgetDesigns.wBox(5),
                          Text(
                            "${orderDetails.data?.orderDetail?.orderdata?.paymentMethod}",
                            style: AppFontStyle.text_14_400(
                              AppTheme.grey,
                              fontFamily: AppFontFamily.generalSansRegular,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
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
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: "${AppUrls.imageUrl}${orderDetails.data?.orderDetail?.userdata?.image}",
                                  placeholder: (context, url) => ShimmerBox(width: 20, height: 20),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            WidgetDesigns.wBox(12),
                            Expanded(
                              child: Text(
                                "${orderDetails.data?.orderDetail?.userdata?.firstName} ${orderDetails.data?.orderDetail?.userdata?.lastName}",
                                style: AppFontStyle.text_18_500(
                                  AppTheme.black,
                                  fontFamily: AppFontFamily.generalSansMedium,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final phoneNumber = orderDetails.data?.orderDetail?.userdata?.phone ?? '';
                                final url = 'tel:$phoneNumber';
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                                } else {
                                  Get.snackbar('Error', 'Could not launch dialer');
                                }
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFB6568E), Color(0xFF5FB6E3)],
                                  ),
                                ),
                                child: Icon(Icons.call, color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      WidgetDesigns.hBox(16),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderDetails.data?.orderDetail?.orderItemsData?.length,
                        itemBuilder: (context, index) {
                          final item = orderDetails.data?.orderDetail?.orderItemsData?[index];
                          String variantOrAddon = "";
                          if (item?.variant != null && item!.variant!.isNotEmpty) {
                            variantOrAddon = item.variant!.map((v) => v.datumName ?? "").join(", ");
                          } else if (item?.addOns != null && item!.addOns!.isNotEmpty) {
                            variantOrAddon = item.addOns!.map((a) => a.name ?? "").join(", ");
                          }
                          return _buildSimpleOrderItem(
                              "${item?.productImages?[0]}",
                              "${item?.productTitle}",
                              variantOrAddon,
                              "${item?.quantity}"
                          );
                        },
                      ),
                      WidgetDesigns.hBox(16),
                      Text(
                        'Payment Details',
                        style: AppFontStyle.text_20_500(
                          AppTheme.black,
                          fontFamily: AppFontFamily.generalSansMedium,
                        ),
                      ),
                      WidgetDesigns.hBox(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Status',
                            style: AppFontStyle.text_18_400(AppTheme.grey,
                                fontFamily: AppFontFamily.generalSansRegular),
                          ),
                          Text(
                            "${orderDetails.data?.orderDetail?.orderdata?.paymentStatus?.capitalizeFirst}",
                            style: AppFontStyle.text_18_500(
                              AppTheme.black,
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ],
                      ),
                      WidgetDesigns.hBox(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: AppFontStyle.text_18_400(AppTheme.grey,
                                fontFamily: AppFontFamily.generalSansRegular),
                          ),
                          Text(
                            "P${orderDetails.data?.orderDetail?.orderdata?.totalAmount}",
                            style: AppFontStyle.text_18_500(
                              AppTheme.redText,
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ],
                      ),
                      WidgetDesigns.hBox(16),
                    ],
                  ),
                ),
              ),

              // Fixed bottom button
              Obx(() {
                if (!controller.isSlid.value) {
                  return Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [Color(0xFFB6568E), Color(0xFF5FB6E3), Color(0xFFDAEAF4)],
                      ),
                    ),
                    child: SlideAction(
                      text: 'Slide After Arrival',
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      outerColor: Colors.transparent,
                      innerColor: Colors.transparent,
                      sliderButtonIcon: Icon(Icons.arrow_forward, color: Colors.white),
                      elevation: 0,
                      height: 56,
                      borderRadius: 40,
                      sliderRotate: false,
                      submittedIcon: Icon(Icons.check, color: Colors.white),
                      onSubmit: () {
                        controller.onSlideCompleted();
                        return null;
                      },
                    ),
                  );
                } else {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: CustomAnimatedButton(
                      key: ValueKey("sendOtpBtn"),
                      onTap: () {
                        controller.sendOtp();
                      },
                      text: "Verify Code",
                    ),
                  );
                }
              }),
              WidgetDesigns.hBox(10),
            ],
          ),
        );
      },
    );
  }


  Widget afterReadyForDeliveryBuild() {
    final orderDetails = Get.find<BottomSheetController>().orderDetails.value;
    if (orderDetails == null) return SizedBox.shrink();
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        // margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            WidgetDesigns.hBox(20),
            Text(
              "${orderDetails.data?.orderDetail?.vendordata?.restaurantName}",
              style: AppFontStyle.text_20_500(
                AppTheme.black,
                fontFamily: AppFontFamily.generalSansMedium,
              ),
            ),
            WidgetDesigns.hBox(8),
            Text(
              "${orderDetails.data?.orderDetail?.orderdata?.orderId}",
              style: AppFontStyle.text_18_400(
                AppTheme.grey,
                fontFamily: AppFontFamily.generalSansRegular,
              ),
            ),
            WidgetDesigns.hBox(10),
            Row(
              children: [
                Text(
                  "${orderDetails.data?.orderDetail?.orderdata?.quantity} item",
                  style: AppFontStyle.text_18_400(
                    AppTheme.grey,
                    fontFamily: AppFontFamily.generalSansRegular,
                  ),
                ),
                WidgetDesigns.wBox(5),
                SvgPicture.asset(ImageConstants.ellipseImage),
                WidgetDesigns.wBox(5),
                Text(
                  "P${orderDetails.data?.orderDetail?.orderdata?.deliveryCharge}",
                  style: AppFontStyle.text_18_400(
                    AppTheme.red,
                    fontFamily: AppFontFamily.generalSansRegular,
                  ),
                ),
              ],
            ),
            WidgetDesigns.hBox(24),
            _buildLocationRow(
              title: "Delivery Location",
              address:
                  "${orderDetails.data?.orderDetail?.userAddressData?.completeAddress}",
              time: "${orderDetails.data?.deliveryLocation?.distance}",
            ),
            WidgetDesigns.hBox(20),
            /*CustomAnimatedButton(
              onTap: () {
                controller.sendOtp();
              },
              text: "Send Code",
            ),*/
            Obx(() {
              if (!controller.isSlid.value) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB6568E),
                        Color(0xFF5FB6E3),
                        Color(0xFFDAEAF4),
                      ],
                    ),
                  ),
                  child: SlideAction(
                    text: 'Slide After Arrival',
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    outerColor: Colors.transparent,
                    innerColor: Colors.transparent,
                    sliderButtonIcon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    elevation: 0,
                    height: 56,
                    borderRadius: 40,
                    sliderRotate: false,
                    submittedIcon: Icon(Icons.check, color: Colors.white),
                    onSubmit: () {
                      controller.onSlideCompleted();
                      return null;
                    },
                  ),
                );
              } else {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: CustomAnimatedButton(
                    key: ValueKey("sendOtpBtn"),
                    onTap: () {
                      controller.sendOtp();
                    },
                    text: "Verify Code",
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  // Simplified order item widget

  Widget _buildSimpleOrderItem(
    String images,
    String name,
    String size,
    String quantity,
  ) {
    print("${AppUrls.imageUrl}$images-------------images");
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              height: 60,
              width: 60,
              imageUrl: "${AppUrls.imageUrl}$images",
              placeholder: (context, url) => ShimmerBox(width: 60, height: 60),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        WidgetDesigns.wBox(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppFontStyle.text_16_500(
                AppTheme.black,
                fontFamily: AppFontFamily.generalSansMedium,
              ),
            ),
            WidgetDesigns.hBox(4),
            Text(size, style: TextStyle(color: Colors.grey)),
            WidgetDesigns.hBox(4),
            Text("Qty $quantity", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  // Send OTP Sheet
  Widget _sendOtpSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.resendEnabled.value) {
        controller.startResendTimer();
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Obx(() {
          return Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    WidgetDesigns.hBox(20),
                    Text(
                      'Verify Phone Number',
                      style: AppFontStyle.text_24_500(
                        AppTheme.black,
                        fontFamily: AppFontFamily.generalSansMedium,
                      ),
                    ),
                    WidgetDesigns.hBox(10),
                    Text(
                      'Please enter the verification code sent to',
                      style: AppFontStyle.text_16_400(
                        AppTheme.grey,
                        fontFamily: AppFontFamily.generalSansRegular,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    WidgetDesigns.hBox(10),
                    Text(
                      controller.otpPhoneNumber.value,
                      style: AppFontStyle.text_18_400(
                        AppTheme.black,
                        fontFamily: AppFontFamily.generalSansMedium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    WidgetDesigns.hBox(20),
                    GetBuilder<HomeController>(
                      builder: (context) {
                        return Column(
                          children: [
                            Pinput(
                              length: 6,
                              controller: controller.otpController,
                              defaultPinTheme: PinTheme(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Color(0xffF4F5F7),
                                ),
                              ),
                              onChanged: (value) {
                                controller.updateOtpError('');
                              },
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Please Enter Otp';
                                }
                                if (value.length != 6) {
                                  return 'OTP must be 6 digits';
                                }
                                return null;
                              },
                            ),
                            Obx(() {
                              return controller.otpError.value != ""
                                  ? Text(
                                    controller.otpError.value,
                                    style: WidgetDesigns.errorTextStyle(),
                                  ).paddingOnly(top: 10)
                                  : SizedBox();
                            }),
                          ],
                        );
                      },
                    ),
                    WidgetDesigns.hBox(20),
                    CustomAnimatedButton(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.verifyOtp();
                        }
                      },
                      text: 'Verify',
                    ),
                    // WidgetDesigns.hBox(20.0),
                    // Obx(
                    //       () => TextButton(
                    //     onPressed: controller.resendEnabled.value
                    //         ? () {
                    //       // Reset timer and resend OTP
                    //       controller.startResendTimer();
                    //       controller.otpController.clear();
                    //       controller.otpError.value = '';
                    //       controller.sendOtp();
                    //     }
                    //         : null,
                    //     child: Text(
                    //       controller.resendEnabled.value
                    //           ? 'Resend Code'
                    //           : 'Resend Code in ${controller.remainingTimer.value}s',
                    //       style: TextStyle(
                    //         color: controller.resendEnabled.value
                    //             ? AppTheme.primaryColor
                    //             : Colors.grey,
                    //         decoration: controller.resendEnabled.value
                    //             ? TextDecoration.underline
                    //             : null,
                    //         decorationColor: AppTheme.primaryColor,
                    //         decorationThickness: 2,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Order PickedUp Sheet
  Widget _orderPickedUpSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
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
            Container(
              margin: EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            WidgetDesigns.hBox(20),
            SvgPicture.asset(ImageConstants.rightIcon),
            WidgetDesigns.hBox(10),
            Text(
              'Order Pickup successfully!',
              style: AppFontStyle.text_22_500(
                AppTheme.black,
                fontFamily: AppFontFamily.generalSansMedium,
              ),
            ),
            WidgetDesigns.hBox(10),
            Text(
              'Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.',
              style: AppFontStyle.text_16_400(
                AppTheme.grey,
                fontFamily: AppFontFamily.generalSansRegular,
              ),
              textAlign: TextAlign.center,
            ),
            WidgetDesigns.hBox(20),
            CustomAnimatedButton(
              onTap: () {
                controller.getCurrentOrderDetailsEvent();
                controller.isSlid.value = false;
              },
              text: "Continue",
            ),
          ],
        ),
      ),
    );
  }

  Widget orderDeliveredUpSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
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
            Container(
              margin: EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            WidgetDesigns.hBox(20),
            SvgPicture.asset(ImageConstants.rightIcon),
            WidgetDesigns.hBox(10),
            Text(
              'Order Delivered successfully!',
              style: AppFontStyle.text_22_500(
                AppTheme.black,
                fontFamily: AppFontFamily.generalSansMedium,
              ),
            ),
            WidgetDesigns.hBox(10),
            Text(
              'Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.',
              style: AppFontStyle.text_16_400(
                AppTheme.grey,
                fontFamily: AppFontFamily.generalSansRegular,
              ),
              textAlign: TextAlign.center,
            ),
            WidgetDesigns.hBox(20),
            CustomAnimatedButton(
              onTap: () {
                controller.bottomSheetController.orderDetails.value?.data  =null;
                controller.bottomSheetController.orderDetails.refresh();
                controller.bottomSheetController.hideAllSheets();
                controller.bottomSheetController.showLookingForOrders();
                controller.clearMapAfterDelivery();
                controller.isSlid.value = false;
              },
              text: "Go Home",
            ),
          ],
        ),
      ),
    );
  }
}
