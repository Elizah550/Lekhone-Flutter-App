import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/core/utils/color_constant.dart';
import 'package:Lekhone/core/utils/image_constant.dart';
import 'package:Lekhone/core/utils/size_utils.dart';
import 'package:Lekhone/screens/theme/app_style.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:Lekhone/screens/cancel_order_screen/cancel_order_screen.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/app_bar/appbar_image.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/app_bar/custom_app_bar.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_button.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/models/recently_shipped_data_model.dart';
import 'controller/order_details_in_transit_controller.dart';

class OrderDetailsInTransitScreen extends StatefulWidget {
  OrderDetailsInTransitScreen({Key? key, required this.orderData})
      : super(key: key);
  RecentlyShipped orderData;

  @override
  State<OrderDetailsInTransitScreen> createState() =>
      _OrderDetailsInTransitScreenState();
}

class _OrderDetailsInTransitScreenState
    extends State<OrderDetailsInTransitScreen> {
  OrderDetailsInTransitController controler =
      Get.put(OrderDetailsInTransitController());

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.whiteA700,
        statusBarIconBrightness: Brightness.dark,
      ),
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
              onTap: onTapArrowleft18,
            ),
            centerTitle: true,
            title: AppbarSubtitle1(text: "Order details"),
            styleType: Style.bgFillWhiteA700,
          ),
          body: Container(
            padding: getPadding(top: 24, bottom: 8),
            child: ListView(
              padding: getPadding(left: 16, right: 16),
              children: [
                Padding(
                  padding: getPadding(top: 3),
                  child: Text(
                    "Shipping Address",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(left: 2, top: 12),
                  child: Text(
                    "Lekhone warehouse",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 19),
                  child: Text(
                    "Delivery Address",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(left: 2, top: 11, bottom: 16),
                  child: Text(
                    widget.orderData.Address,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
                Divider(
                  height: getVerticalSize(1),
                  thickness: getVerticalSize(1),
                  color: ColorConstant.gray300,
                ),
                SizedBox(
                  height: getVerticalSize(16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: getPadding(top: 0),
                      child: Text(
                        "Package total",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtBody,
                      ),
                    ),
                    Text(
                      "500.00",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtBody,
                    )
                  ],
                ),
                Padding(
                  padding: getPadding(top: 18, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery charge".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtBody,
                      ),
                      Text(
                        "50.00",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtBody,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: getVerticalSize(1),
                  thickness: getVerticalSize(1),
                  color: ColorConstant.gray300,
                ),
                Padding(
                  padding: getPadding(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold20,
                      ),
                      Text(
                        "550.00",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold20,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(top: 32),
                  child: Text(
                    "Order details",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold20,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 22),
                  child: Text(
                    "Order number",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 12),
                  child: Text(
                    widget.orderData.orderID ?? "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 21),
                  child: Text(
                    "Delivery type".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 12),
                  child: Text(
                    "Lekhone normal",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 20),
                  child: Text(
                    "Delivery status",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 10),
                  child: Text(
                    widget.orderData.stsatus!,
                    style: _getStatusTextStyle(),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 21),
                  child: Text(
                    "Delivery date",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(top: 10, bottom: 0),
                  child: Text(
                    widget.orderData.date ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: getPadding(left: 16, right: 16, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  height: getVerticalSize(54),
                  width: getHorizontalSize(190),
                  text: "Cancel order",
                  variant: ButtonVariant.OutlineDeeppurple600,
                  fontStyle: ButtonFontStyle.SFProTextBold18Deeppurple600,
                  onTap: onTapCancelOrder,
                ),
                CustomButton(
                  height: getVerticalSize(54),
                  width: getHorizontalSize(190),
                  text: "Track order",
                  margin: getMargin(left: 16),
                  onTap: onTapTrackOrder,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _getStatusTextStyle() {
    return widget.orderData.stsatus!.toLowerCase() == "delivered"
        ? AppStyle.txtOutfitRegular16Green
        : widget.orderData.stsatus!.toLowerCase() == "in transit"
            ? AppStyle.txtOutfitRegular16Amber
            : AppStyle.txtOutfitRegular16Red;
  }

  onTapCancelOrder() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.zero,
          content: CancelOrderScreen(),
        );
      },
    );
  }

  onTapTrackOrder() {
    // Implement your logic for tracking order
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrackerApp(),
      ),
    );
  }

  onTapArrowleft18() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrackerApp(),
      ),
    );
  }
}
