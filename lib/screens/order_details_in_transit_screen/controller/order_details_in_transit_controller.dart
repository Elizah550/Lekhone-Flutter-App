import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/models/order_details_in_transit_model.dart';

/// A controller class for the OrderDetailsInTransitScreen.
///
/// This class manages the state of the OrderDetailsInTransitScreen, including the
/// current orderDetailsInTransitModelObj
class OrderDetailsInTransitController extends GetxController {
  Rx<OrderDetailsInTransitModel> orderDetailsInTransitModelObj =
      OrderDetailsInTransitModel().obs;
}
