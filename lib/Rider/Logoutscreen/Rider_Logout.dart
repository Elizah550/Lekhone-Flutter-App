import 'package:Lekhone/Rider/Login.dart';
import 'package:Lekhone/core/utils/size_utils.dart';
import 'package:Lekhone/main.dart';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/theme/app_decoration.dart';
import 'package:Lekhone/screens/theme/app_style.dart';
import 'controller/cancel_order_controller.dart';
import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RiderLogoutScreen extends GetWidget<CancelOrderController> {
  const RiderLogoutScreen({Key? key}) : super(key: key);

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
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            onPrimary: Colors.white,
                                            padding: EdgeInsets.all(11),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide(
                                                  color:
                                                      Colors.deepPurple[600]!),
                                            ),
                                          ),
                                          onPressed: () {
                                            onTapNo(context);
                                          },
                                          child: Text(
                                            "no",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Expanded(
                                      //     child: CustomButton(
                                      //         height: getVerticalSize(46),
                                      //         text: "no",
                                      //         margin: getMargin(right: 10),
                                      //         variant: ButtonVariant
                                      //             .OutlineDeeppurple600,
                                      //         padding:
                                      //             ButtonPadding.PaddingAll11,
                                      //         fontStyle: ButtonFontStyle
                                      //             .SFProTextBold18Deeppurple600,

                                      //         // color: Color.black,
                                      //         onTap: () {
                                      //           onTapNo(context);
                                      //         })),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFFFFCE00),
                                            onPrimary: Colors.white,
                                            padding: EdgeInsets.all(11),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide(
                                                  color:
                                                      Colors.deepPurple[600]!),
                                            ),
                                          ),
                                          onPressed: () {
                                            onTapyes(context);
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //     child: CustomButton(
                                      //         onTap: () {
                                      //           onTapyes(context);
                                      //         },
                                      //         height: getVerticalSize(46),
                                      //         text: "Yes",
                                      //         margin: getMargin(left: 10),
                                      //         padding:
                                      //             ButtonPadding.PaddingAll11,
                                      //         fontStyle: ButtonFontStyle
                                      //             .SFProDisplayBold18))
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
    RiderphoneNumberController.dispose();
    // Navigate to the LoginScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }
}
