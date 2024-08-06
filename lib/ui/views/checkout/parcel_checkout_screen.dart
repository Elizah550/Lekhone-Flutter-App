import 'package:Lekhone/screens/Snackbar/src/awesome_snackbar_content.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/models/recently_shipped_data_model.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/order_details_in_transit_screen.dart';
import 'package:Lekhone/src/content_type.dart';
import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:Lekhone/models/models.dart';
import 'package:Lekhone/ui/widgets/widgets.dart';
import 'package:Lekhone/utils/image_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Lekhone/screens/global.dart';

class ParcelCheckboxScreen extends StatelessWidget {
  final Parcel parcel;
  final DeliveryMethod deliveryMethod;
  final TextEditingController nameController,
      emailController,
      phoneNumberController,
      addressController,
      dateController,
      timeController;

  ParcelCheckboxScreen({
    Key? key,
    required this.parcel,
    required this.deliveryMethod,
    required this.nameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.addressController,
    required this.dateController,
    required this.timeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: ListView(
            children: [
              Text(
                'Checkout',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 17),
              Text(
                'Parcel size',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 11),
              ParcelSizeWidget(
                isDone: true,
                size: parcel.size,
                image: parcel.image,
                dimension: parcel.dimension,
                description: parcel.description,
              ),
              const SizedBox(height: 5),
              Text(
                'Delivery method',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 11),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.background,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: Hero(
                      tag: deliveryMethod.image,
                      transitionOnUserGestures: true,
                      child: Container(
                        height: 102,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(deliveryMethod.image),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  deliveryMethod.deliveryMethod,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                Text(
                                  deliveryMethod.duration,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.only(
                      left: 6,
                      bottom: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(4),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Checkout details',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 11),
              Container(
                height: 207,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 19,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(7),
                  image: const DecorationImage(
                    image: AssetImage(ImageUtils.icsCardBackground),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '•••• •••• •••• 0142',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${nameController.text}',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .headlineMedium!
                          //     .copyWith(color: Colors.white),
                        ),
                        Text(
                          '10/26',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 21),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Summary',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(
                          width: 45,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Edit',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        SvgPicture.asset(
                                          ImageUtils.icDetailsSVG,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.pop(context);
                              //       },
                              //     ),
                              //     Text(
                              //       'Edit',
                              //       style:
                              //           Theme.of(context).textTheme.bodyMedium,
                              //     ),
                              //     SvgPicture.asset(
                              //       ImageUtils.icDetailsSVG,
                              //     ),
                              //   ],
                              // ),
                              // Container(
                              //   height: 1,
                              //   color: Colors.black,
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recipient',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '${nameController.text}\n${emailController.text}\n${phoneNumberController.text}\n${addressController.text}\n${timeController.text}\n${dateController.text}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            // Add any other styling properties you need
                          ),
                        ),
                        // Text(
                        //   '${nameController.text}\n${emailController.text}\n${phoneNumberController.text}\n${addressController.text}',
                        //   // style: Theme.of(context).textTheme.headlineSmall,
                        //   style: TextStyle(
                        //     fontFamily: 'poppins',
                        //     fontSize: 16,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parcel size',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          parcel.size,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery method',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          deliveryMethod.deliveryMethod,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          //NOT NEEDED IF function here
                          if (dateController.text.isNotEmpty) {
                            const Duration delayDuration = Duration(seconds: 5);
                            Duration(seconds: 5);
                            Tripdetails(
                              context,
                              dateController.text,
                              timeController.text,
                              "+91", // Pass the country code directly as "+91"
                              phoneNumberController.text,
                              nameController.text,
                              emailController.text,
                              addressController.text,
                            );
                            Future.delayed(delayDuration, () {
                              bookAppointment(
                                context,
                                dateController.text,
                                timeController.text,
                                "+91", // Pass the country code directly as "+91"
                                phoneNumberController.text,
                                nameController.text,
                                emailController.text,
                                deliveryMethod.deliveryMethod,
                                parcel.size,
                              );
                            });
                            // final snackBar = SnackBar(
                            //   elevation: 0,
                            //   behavior: SnackBarBehavior.floating,
                            //   backgroundColor: Color.fromARGB(0, 236, 232, 232),
                            //   content: AwesomeSnackbarContent(
                            //     title: 'Order placed successfully ! ',
                            //     message: 'Your order is on the way !!',
                            //     contentType: ContentType.success,
                            //   ),
                            // );

                            // ScaffoldMessenger.of(context)
                            //   ..hideCurrentSnackBar()
                            //   ..showSnackBar(snackBar);
                            Future.delayed(delayDuration, () {
                              Fluttertoast.showToast(
                                msg:
                                    'Order placed successfully!\nYour order is on the way!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(0, 236, 232, 232),
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                            });

                            // Future.delayed(delayDuration, () {
                            //       Fluttertoast.showToast(
                            //   msg:
                            //       'Order placed successfully!\nYour order is on the way!',
                            //   toastLength: Toast.LENGTH_SHORT,
                            //   gravity: ToastGravity.BOTTOM,
                            //   timeInSecForIosWeb: 1,
                            //   backgroundColor: Color.fromARGB(0, 236, 232, 232),
                            //   textColor: Colors.black,
                            //   fontSize: 16.0,
                            // );
                            // };

                            fetchDetails(phoneNumberController.text,
                                dateController.text, timeController.text);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const TrackerApp(),
                            //   ),
                            // );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const TrackerApp(),
                            //   ),
                            // );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         OrderDetailsInTransitScreen(
                            //       orderData: RecentlyShipped(
                            //         nameController.text,
                            //         "1213224",
                            //         dateController.text,
                            //         'In Transit',
                            //       ),
                            //     ),
                            //   ),
                            // );
                          }
                        },
                        child: Text(
                          'Pay \$45.0',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 11),
            ],
          ),
        ),
      ),
    );
  }
}
