import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AddNewAddress extends StatelessWidget {
  final locCtrl = Get.put(LocationController());

  AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Obx(() {
                if (locCtrl.currentLatLng.value == null) {
                  locCtrl.fetchCurrentLocation();
                  return const Center(child: CircularProgressIndicator());
                }

                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: locCtrl.currentLatLng.value ?? const LatLng(0, 0),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) {
                      locCtrl.setMapController(controller);
                    },
                    onCameraMove: (position) {
                      locCtrl.tempLatLng.value = position.target;
                    },
                    onCameraIdle: () {
                      locCtrl.updateFromCameraMovement();
                    },
                    compassEnabled: true,
                  ),
                );
              }),

              Center(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: REdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor.withOpacity(0.1),
                                      AppTheme.blueColor.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppTheme.primaryColor.withOpacity(0.15),
                                        AppTheme.blueColor.withOpacity(0.15),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: AppTheme.primaryGradient,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: -50,
                                left: -50,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                      // margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          MyText(
                                            title:
                                            "Driver is here",
                                            tColor: Colors.white,
                                            fWeight: FontWeight.w600,
                                          ),
                                          SizedBox(height: 2),
                                          MyText(
                                            title:
                                            "Move the pin to change location",
                                            fSize: 12,
                                            fWeight: FontWeight.w400,
                                            tColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Triangle pointer
                                    ClipPath(
                                      clipper: TriangleClipper(),
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      color: Colors.white,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                              locCtrl.locationError.value = "";

                            },
                            child: Image.asset(
                              ImageConstants.backIconImage,
                              height: 44,
                            ),
                          ),
                          Spacer(),
                          MyText(
                            title: "Select Location",
                            tColor: Colors.black,
                            fSize: 18,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    TextField(
                      controller: locCtrl.searchTextController,
                      onChanged: locCtrl.searchPlaces,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'GeneralSans',
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText:
                        "Search for a building, street name, or area",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Image.asset(
                            ImageConstants.wsearchIconImage,
                            color: Colors.black,
                            height: 10,
                            width: 10,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ).paddingOnly(top: 15, right: 15, left: 15),
                    Obx(
                          () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: locCtrl.suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = locCtrl.suggestions[index];
                          return Container(
                            margin: EdgeInsets.only(left: 20,right:20),
                            color: Colors.white,
                            child: ListTile(
                              title: MyText(title: suggestion['description']!),
                              onTap: () async {
                                final latlng = await locCtrl
                                    .getLatLngFromPlaceId(
                                  suggestion['place_id']!,
                                );
                                final target = LatLng(
                                  latlng['lat']!,
                                  latlng['lng']!,
                                );
                                locCtrl.moveCameraTo(target);
                                locCtrl.searchTextController.clear();
                                locCtrl.suggestions.clear();
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(
                          () {
                        return DraggableScrollableSheet(
                          // expand: locCtrl.issheetScroll.value ,
                          controller: locCtrl.sheetController,
                          initialChildSize: 0.40,
                          minChildSize: 0.40,
                          maxChildSize: locCtrl.issheetScroll.value? 0.65:0.40,
                          builder: (context, scrollController) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      locCtrl.type.value ="Home";
                                      locCtrl.issheetScroll.value = false;
                                      locCtrl.sheetController.animateTo(
                                        0.35,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child:
                                    locCtrl.issheetScroll.value
                                        ? Image.asset(ImageConstants.mapBackImage)
                                        : GestureDetector(
                                      onTap: () async {
                                        await locCtrl
                                            .fetchCurrentLocation(); // Fetch and update currentLatLng
                                        if (locCtrl.currentLatLng.value !=
                                            null) {
                                          locCtrl.moveCameraTo(
                                            locCtrl.currentLatLng.value!,
                                          ); // Move camera
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,

                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(25),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  ImageConstants.mapPinImage,
                                                ),
                                                MyText(
                                                  title:
                                                  "  Use Current Location",
                                                  tColor:
                                                  AppTheme.primaryColor,
                                                  fWeight: FontWeight.w500,
                                                  fSize: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(height: 20),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30),
                                      ),
                                    ),
                                    child: ListView(
                                      controller: scrollController,
                                      physics:  AlwaysScrollableScrollPhysics(),
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 5,
                                            margin: const EdgeInsets.only(top: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              ImageConstants.placeLocationImage,
                                              width: 25,
                                              height: 25,
                                            ),
                                            SizedBox(width: 10),
                                            Obx(() {
                                              return Flexible(
                                                child: MyText(
                                                  title: locCtrl.titleAddress.value,
                                                  fSize: 20,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Obx(() {
                                          return MyText(
                                            title: locCtrl.address.value,
                                            tColor: Color(0xff626162),
                                          );
                                        }),
                                        const SizedBox(height: 24),
                                        Obx(() {
                                          return locCtrl.issheetScroll.value
                                              ? Form(
                                            key: locCtrl.formKey,
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  validator: (p0) {
                                                    if (p0 == null ||
                                                        p0.isEmpty) {
                                                      return "House no. is required";
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                  locCtrl.houseController,
                                                  hintText:
                                                  "House no./flat No./Apartment no.",
                                                ),
                                                SizedBox(height: 20),
                                                SizedBox(
                                                  height: 50,
                                                  child: ListView.separated(
                                                    scrollDirection: Axis.horizontal,
                                                    separatorBuilder: (context, index) => SizedBox(width: 10),
                                                    itemCount: 3,
                                                    itemBuilder: (context, index) {
                                                      return Obx(() {
                                                        final String type = locCtrl.placeList[index]['value'].toString();
                                                        final bool isSelected = locCtrl.selectionList[index];
                                                        final bool isDisabled =
                                                            (Get.arguments != null && Get.arguments['home'] == true && type == 'home') ||
                                                                (Get.arguments != null && Get.arguments['office'] == true && type == 'office');

                                                        return CustomContainer(
                                                          ontap: isDisabled
                                                              ? null // Disable interaction
                                                              : () {
                                                            locCtrl.type.value = type;
                                                            locCtrl.selectionList.value = List.generate(
                                                              locCtrl.selectionList.length,
                                                                  (i) => i == index,
                                                            );
                                                            locCtrl.expandSheet(type == "other" ? 0.65 : 0.54);
                                                          },
                                                          gradient: isDisabled
                                                              ? LinearGradient(
                                                            colors: [Colors.grey.shade300, Colors.grey.shade300],
                                                          )
                                                              : isSelected
                                                              ? AppTheme.primaryGradient
                                                              : const LinearGradient(
                                                            colors: [
                                                              AppTheme.primaryColor20,
                                                              AppTheme.blueColor20,
                                                            ],
                                                          ),
                                                          content: Row(
                                                            children: [
                                                              Image.asset(
                                                                locCtrl.placeList[index]['image'].toString(),
                                                                height: 17,
                                                                color: isDisabled
                                                                    ? Colors.grey
                                                                    : (isSelected ? Colors.white : null),
                                                              ).paddingOnly(right: 5),
                                                              MyText(
                                                                title: locCtrl.placeList[index]['name'].toString(),
                                                                tColor: isDisabled
                                                                    ? Colors.grey
                                                                    : (isSelected ? Colors.white : Colors.black),
                                                                fWeight: FontWeight.w400,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Obx(
                                                        () {
                                                      return locCtrl.locationError.value==""?SizedBox(): Row(
                                                        children: [
                                                          MyText(title: locCtrl.locationError.value,tColor: Colors.red  ,fSize: 13,fWeight: FontWeight.w400,),
                                                        ],
                                                      );
                                                    }
                                                ),
                                                locCtrl.type.value == "other"
                                                    ? CustomTextField(
                                                  validator: (p0) {
                                                    if (locCtrl.type.value ==
                                                        "other") {
                                                      if (p0 == null ||
                                                          p0.isEmpty) {
                                                        return "Save as is required";
                                                      }
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                  locCtrl.otherController,
                                                  hintText: "Save As",
                                                ).paddingOnly(top: 20)
                                                    : SizedBox(),
                                                SizedBox(height: 20),
                                                CustomAnimatedButton(
                                                  height: 60,
                                                  onTap: () {
                                                    if (locCtrl.formKey.currentState!.validate()) {
                                                      print(locCtrl.type.value);
                                                      locCtrl.addLocation();
                                                    }
                                                  },
                                                  text: "Save Location",
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: CustomAnimatedButton(
                                              height: 60,
                                              onTap: () {
                                                // locCtrl.expandSheet(0.54);
                                                final dataToReturn = {
                                                  "address": locCtrl.address.value,
                                                  "lat": locCtrl.tempLatLng.value?.latitude,
                                                  "lng": locCtrl.tempLatLng.value?.longitude,
                                                };
                                                Get.back(result: dataToReturn);
                                              },
                                              text: "Confirm Location",
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}