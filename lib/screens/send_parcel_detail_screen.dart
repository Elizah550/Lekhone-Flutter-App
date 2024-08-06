import 'package:flutter/material.dart';
import 'package:Lekhone/screens/widgets/my_parcel_delivery_method.dart';

class SendParcelDetailScreen extends StatefulWidget {
  const SendParcelDetailScreen({Key? key}) : super(key: key);

  @override
  _SendParcelDetailScreenState createState() => _SendParcelDetailScreenState();
}

class _SendParcelDetailScreenState extends State<SendParcelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: ListView(
          children: [
            Text(
              'Send parcel',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 17,
            ),
            Text(
              'Delivery method',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 11,
            ),
            const MyParcelDeliveryMethod(
              parcelDeliveryMethod: 'From door to parcel center',
              parcelDeliveryDuration: '1 - 2 days',
              parcelDeliveryImage: 'assets/images/img_door_to_parcel.png',
            ),
            const MyParcelDeliveryMethod(
              parcelDeliveryMethod: 'From door to door',
              parcelDeliveryDuration: '2 - 3 days',
              parcelDeliveryImage: 'assets/images/img_door_to_door.png',
            ),
          ],
        ),
      ),
    );
  }
}
