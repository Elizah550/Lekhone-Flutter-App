import 'package:Lekhone/core/utils/size_utils.dart';
import 'package:Lekhone/main.dart';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/theme/app_decoration.dart';
import 'package:Lekhone/screens/theme/app_style.dart';

import 'controller/cancel_order_controller.dart';
import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends GetWidget<CancelOrderController> {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: getPadding(left: 0, right: 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: double.maxFinite,
                  child: Container(
                      margin: getMargin(bottom: 5),
                      padding:
                          getPadding(left: 30, top: 14, right: 30, bottom: 14),
                      decoration: AppDecoration.white.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder16),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Are you sure ?",
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.txtHeadline),
                            Padding(
                                padding: getPadding(top: 33),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: CustomButton(
                                              height: getVerticalSize(46),
                                              text: "no",
                                              margin: getMargin(right: 10),
                                              variant: ButtonVariant
                                                  .OutlineDeeppurple600,
                                              padding:
                                                  ButtonPadding.PaddingAll11,
                                              fontStyle: ButtonFontStyle
                                                  .SFProTextBold18Deeppurple600,
                                              onTap: () {
                                                onTapNo(context);
                                              })),
                                      Expanded(
                                          child: CustomButton(
                                              onTap: () {
                                                onTapyes(context);
                                              },
                                              height: getVerticalSize(46),
                                              text: "Yes",
                                              margin: getMargin(left: 10),
                                              padding:
                                                  ButtonPadding.PaddingAll11,
                                              fontStyle: ButtonFontStyle
                                                  .SFProDisplayBold18))
                                    ]))
                          ])))
            ]));
  }

  /// Navigates to the orderDetailsInTransitScreen when the action is triggered.

  /// When the action is triggered, this function uses the `Get` package to
  /// push the named route for the orderDetailsInTransitScreen.
  onTapNo(BuildContext context) {
    Navigator.pop(context);
  }

  onTapyes(BuildContext context) {
    phoneNumberController.dispose();
    // Navigate to the LoginScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }
}
