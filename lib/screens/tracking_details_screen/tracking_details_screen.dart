import 'dart:async';

import 'package:Lekhone/core/utils/color_constant.dart';
import 'package:Lekhone/core/utils/image_constant.dart';
import 'package:Lekhone/core/utils/size_utils.dart';
import 'package:Lekhone/screens/Maps/home_page.dart';
import 'package:Lekhone/screens/global.dart';
import 'package:Lekhone/screens/live_tracking_one_screen/live_tracking_one_screen.dart';
import 'package:Lekhone/screens/live_tracking_screen/live_tracking_screen.dart';
import 'package:Lekhone/screens/theme/app_decoration.dart';
import 'package:Lekhone/screens/theme/app_style.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_image_view.dart';
import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/app_bar/appbar_image.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/app_bar/custom_app_bar.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_button.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingDetailsScreen extends StatefulWidget {
  final String tripId;
  const TrackingDetailsScreen({Key? key, required this.tripId})
      : super(key: key);

  @override
  State<TrackingDetailsScreen> createState() => _TrackingDetailsScreenState();
}

class _TrackingDetailsScreenState extends State<TrackingDetailsScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: ColorfulSafeArea(
            color: ColorConstant.whiteA700,
            child: Scaffold(
                backgroundColor: ColorConstant.whiteA700,
                appBar: CustomAppBar(
                    height: getVerticalSize(79),
                    leadingWidth: 42,
                    leading: AppbarImage(
                        height: getSize(24),
                        width: getSize(24),
                        svgPath: ImageConstant.imgArrowleft,
                        margin: getMargin(left: 18, top: 29, bottom: 26),
                        onTap: () {
                          // Navigator.pop(context);
                          onTapArrowleft12();
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "Tracking details".tr),
                    styleType: Style.bgFillWhiteA700),
                body: Container(
                    width: double.maxFinite,
                    padding: getPadding(all: 16),
                    child: ListView(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: getPadding(all: 16),
                                  decoration: AppDecoration.fillGray50.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder8),
                                  child: Row(children: [
                                    CustomIconButton(
                                        height: 64,
                                        width: 64,
                                        shape: IconButtonShape.CircleBorder32,
                                        padding: IconButtonPadding.PaddingAll14,
                                        child: CustomImageView(
                                            svgPath: ImageConstant
                                                .imgArrowdownDeepPurple600)),
                                    Padding(
                                        padding: getPadding(
                                            left: 8, top: 8, bottom: 4),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("# 202022194".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtHeadline),
                                              Container(
                                                  height: getVerticalSize(16),
                                                  width: getHorizontalSize(140),
                                                  margin: getMargin(top: 12),
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                "On going 9 may"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtFootnote)),
                                                        Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Container(
                                                                height:
                                                                    getSize(3),
                                                                width:
                                                                    getSize(3),
                                                                margin:
                                                                    getMargin(
                                                                        left:
                                                                            60,
                                                                        top: 5),
                                                                decoration: BoxDecoration(
                                                                    color: ColorConstant
                                                                        .black900,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            getHorizontalSize(1)))))
                                                      ]))
                                            ]))
                                  ])),
                              Container(
                                  height: getVerticalSize(224),
                                  width: getHorizontalSize(396),
                                  margin: getMargin(top: 16),
                                  child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        CustomImageView(
                                            imagePath:
                                                ImageConstant.imgRectangle4428,
                                            height: getVerticalSize(224),
                                            width: getHorizontalSize(396),
                                            radius: BorderRadius.circular(
                                                getHorizontalSize(8)),
                                            alignment: Alignment.center),
                                        CustomButton(
                                            height: getVerticalSize(40),
                                            width: getHorizontalSize(143),
                                            text: "Live tracking".tr,
                                            margin:
                                                getMargin(left: 8, bottom: 8),
                                            padding: ButtonPadding.PaddingAll11,
                                            fontStyle: ButtonFontStyle
                                                .SFProTextBold15WhiteA700,
                                            onTap: () {
                                              onTapMapPage();
                                              // Timer.periodic(
                                              //     Duration(seconds: 30),
                                              //     (Timer timer) {
                                              //   onTapMapPage();
                                              //   ScaffoldMessenger.of(context)
                                              //       .showSnackBar(
                                              //     SnackBar(
                                              //       content:
                                              //           Text('Map Updated !!!'),
                                              //       duration: Duration(
                                              //           seconds:
                                              //               2), // Adjust the duration as needed
                                              //     ),
                                              //   ); // Call the function every 2 minutes (120 seconds)
                                              // });
                                            },
                                            alignment: Alignment.bottomLeft)
                                      ])),
                              Padding(
                                  padding: getPadding(top: 21),
                                  child: Text("Tracking History".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold20)),
                              SizedBox(
                                height: getVerticalSize(16),
                              ),
                              Row(
                                children: [
                                  CustomImageView(
                                    svgPath: ImageConstant.imgTrackingOrder,
                                    height: getSize(318),
                                  ),
                                  SizedBox(width: getHorizontalSize(14)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Checking".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 8),
                                                child: Text(
                                                    "Completed 9 may".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtFootnote))
                                          ]),
                                      SizedBox(
                                        height: getVerticalSize(40),
                                      ),
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Waiting for pick2".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 13),
                                                child: Text(
                                                    "Completed 10 may".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtFootnote))
                                          ]),
                                      SizedBox(
                                        height: getVerticalSize(40),
                                      ),
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("In transit2".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 15),
                                                child: Text("On transit 102".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtFootnote))
                                          ]),
                                      SizedBox(
                                        height: getVerticalSize(40),
                                      ),
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Out of delivery2".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 13),
                                                child: Text("Pending 13 may".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtFootnote))
                                          ])
                                    ],
                                  )
                                ],
                              ),
                            ]),
                      ],
                    )))));
  }

  // onTapLivetracking() {
  //   Get.toNamed(
  //     AppRoutes.liveTrackingOneScreen,
  //   );
  // }

  void onTapLivetracking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveTrackingOneScreen(),
      ),
    );
  }

  // void onTapMapPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MapPage(
  //         startLatitude: yourStartLatitude,
  //         startLongitude: yourStartLongitude,
  //         endLatitude: yourEndLatitude,
  //         endLongitude: yourEndLongitude,
  //       ),
  //     ),
  //   );
  // }
  void onTapMapPage() async {
    try {
      Map<String, dynamic>? data = await Mapfetch(Map_id: widget.tripId);

      if (data != null) {
        Map<String, dynamic> responseData = data;
        print("Received data: $data");

        if (responseData['body'] != null &&
            responseData['body']['Started'] != null &&
            responseData['body']['Started']['Longitude'] != null) {
          dynamic longitudeValue = responseData['body']['Started']['Longitude'];

          if (longitudeValue is String) {
            // Check if the value is a valid double
            try {
              double startedLongitudeNumeric = double.parse(longitudeValue);
              print('Started Longitude: $startedLongitudeNumeric');
              print("Here--for--testing");
              print(responseData['body']['Started']['Latitude']);
              var startlat = responseData['body']['Started']['Latitude'];
              print(startlat);
              var startlong = responseData['body']['Started']['Longitude'];
              print(startlong);
              var endlat = responseData['body']['Ended']['Latitude'];
              var endlong = responseData['body']['Ended']['Longitude'];
              var currentlat = responseData['body']['Latitude'];
              var currentlong = responseData['body']['Longitude'];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(
                    tripId: widget.tripId,
                    startLatitude: startlat,
                    startLongitude: startlong,
                    endLatitude: endlat,
                    endLongitude: endlong,
                    currentLatitude: currentlat,
                    currentLongitude: currentlong,
                  ),
                ),
              );
            } catch (e) {
              print('Error parsing longitude as double: $e');
            }
          } else {
            print('Error: Longitude is not a String');
          }
        } else {
          print('Error: Longitude not found in the response');
        }
      } else {
        print("Error: Mapfetch returned null");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  onTapArrowleft12() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TrackerApp()));
    // Get.back();
  }
}
