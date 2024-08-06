import 'package:Lekhone/models/models.dart';
import 'package:Lekhone/utils/image_utils.dart';

class DeliveryData {
  static List<DeliveryMethod> deliveryMethods = [
    DeliveryMethod(
      deliveryMethod: 'From door to parcel center',
      duration: '2 - 3 days',
      image: ImageUtils.icsDoorToParcel,
    ),
    DeliveryMethod(
      deliveryMethod: 'From door to door',
      duration: '1 - 2 days',
      image: ImageUtils.icDoorToDoor,
    ),
  ];
}
