import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/screens/live_tracking_screen/models/live_tracking_model.dart';

/// A controller class for the LiveTrackingScreen.
///
/// This class manages the state of the LiveTrackingScreen, including the
/// current liveTrackingModelObj
class LiveTrackingController extends GetxController {
  Rx<LiveTrackingModel> liveTrackingModelObj = LiveTrackingModel().obs;
}