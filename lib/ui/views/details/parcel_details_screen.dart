import 'package:flutter/material.dart';
import 'package:Lekhone/data/data.dart';
import 'package:Lekhone/models/models.dart';
import 'package:Lekhone/ui/views/views.dart';
import 'package:Lekhone/ui/widgets/widgets.dart';

class ParcelDetailsScreen extends StatelessWidget {
  final Parcel parcel;

  ParcelDetailsScreen({
    Key? key,
    required this.parcel,
  }) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  bool areFieldsEmpty() {
    return nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        addressController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty;
  }

  bool areFieldsValid() {
    return validateName(nameController.text) == null &&
        validateEmail(emailController.text) == null &&
        validatePhoneNumber(phoneNumberController.text) == null;
  }

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
                'Parcel details',
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
                'Select delivery method',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 11),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DeliveryData.deliveryMethods.length,
                itemBuilder: (context, index) {
                  DeliveryMethod deliverMethod =
                      DeliveryData.deliveryMethods[index];
                  return ParcelDeliveryMethod(
                    initiallyExpanded: false,
                    onExpansionChanged: (value) {
                      debugPrint('-----$index: $value');
                    },
                    image: deliverMethod.image,
                    duration: deliverMethod.duration,
                    deliveryMethod: deliverMethod.deliveryMethod,
                    nameController: nameController,
                    emailController: emailController,
                    phoneNumberController: phoneNumberController,
                    addressController: addressController,
                    timeController: timeController,
                    dateController: dateController,
                    validateName: validateName,
                    validateEmail: validateEmail,
                    validatePhoneNumber: validatePhoneNumber,
                  );
                },
              ),
              const SizedBox(height: 11),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () {
                    if (areFieldsEmpty()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Required Fields'),
                            content:
                                Text('Please fill in all required fields.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (!areFieldsValid()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Invalid Fields'),
                            content:
                                Text('Please correct the highlighted fields.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Perform further actions or navigate to the next screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ParcelCheckboxScreen(
                            parcel: parcel,
                            deliveryMethod: DeliveryData.deliveryMethods[0],
                            nameController: nameController,
                            emailController: emailController,
                            phoneNumberController: phoneNumberController,
                            addressController: addressController,
                            dateController: dateController,
                            timeController: timeController,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Checkout',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 11),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Parcel details',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
