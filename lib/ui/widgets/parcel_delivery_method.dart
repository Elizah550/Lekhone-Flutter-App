import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class ParcelDeliveryMethod extends StatelessWidget {
  final String deliveryMethod, duration, image;
  final TextEditingController nameController,
      emailController,
      phoneNumberController,
      addressController,
      timeController,
      dateController;
  final bool initiallyExpanded;
  final Function(bool) onExpansionChanged;

  ParcelDeliveryMethod(
      {Key? key,
      required this.image,
      required this.duration,
      required this.deliveryMethod,
      required this.initiallyExpanded,
      required this.onExpansionChanged,
      required this.nameController,
      required this.emailController,
      required this.phoneNumberController,
      required this.addressController,
      required this.timeController,
      required this.dateController,
      required String? Function(String? value) validateName,
      required String? Function(String? value) validateEmail,
      required String? Function(String? value) validatePhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: onExpansionChanged,
        tilePadding: EdgeInsets.zero,
        trailing: const SizedBox.shrink(),
        title: Hero(
          tag: image,
          transitionOnUserGestures: true,
          child: Container(
            height: 102,
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      deliveryMethod,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      duration,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          _buildExpansionChildren(context),
        ],
      ),
    );
  }

  Widget _buildExpansionChildren(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Recipient Info',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 10),
              Text('Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 12.0)
                  // style: Theme.of(context).textTheme.titleLarge,
                  ),
            ],
          ),
          TextFormField(
            controller: nameController,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 10),
              Text('Email',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 12.0)
                  // style: Theme.of(context).textTheme.titleLarge,
                  ),
            ],
          ),
          TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              // Add additional email validation if needed
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 10),
              Text('Phone number',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 12.0)
                  // style: Theme.of(context).textTheme.titleLarge,
                  ),
            ],
          ),
          TextFormField(
            controller: phoneNumberController,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              // Add additional phone number validation if needed
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 10),
              Text('Date',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 12.0)
                  // style: Theme.of(context).textTheme.titleLarge,
                  ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors.yellow,
                      hintColor: Colors.black,
                      colorScheme: ColorScheme.light(primary: Colors.black),
                      buttonTheme: ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                        colorScheme: ColorScheme.light(
                          primary: Color.fromARGB(255, 1, 0, 0),
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (selectedDate != null) {
                dateController.text =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: dateController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 10),
              Text('Time',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 12.0)
                  // style: Theme.of(context).textTheme.headline6?.copyWith(
                  //       color: Colors.black,
                  //     ),
                  ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors.black,
                      hintColor: Colors.black,
                      colorScheme: ColorScheme.light(primary: Colors.black),
                      buttonTheme: ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                        colorScheme: ColorScheme.light(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (selectedTime != null) {
                timeController.text = selectedTime.format(context);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: timeController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Time is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 2),
              Text(
                'Address',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 12.0),
              ),
              Spacer(), // This will take up any available space
              GestureDetector(
                onTap: () {
                  _openAddressBottomSheet(context);
                },
                child: Icon(Icons.edit),
              ),
            ],
          ),

          // Row(
          //   children: [
          //     const SizedBox(width: 10),
          //     Text('Address',
          //         style: Theme.of(context)
          //             .textTheme
          //             .titleLarge
          //             ?.copyWith(fontSize: 12.0)),
          //     GestureDetector(
          //       onTap: () {
          //         _openAddressBottomSheet(context);
          //       },
          //       child: Icon(Icons.edit),
          //     ),
          //   ],
          // ),
          // TextFormField(
          //   controller: addressController,
          //   style: TextStyle(color: Colors.black),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Address is required';
          //     }
          //     return null;
          //   },
          //   decoration: InputDecoration(
          //     // hintText: 'Enter Address',
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.black),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.black),
          //     ),
          //   ),
          // ),

          TextFormField(
            controller: addressController,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _openAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddressBottomSheet(
          addressController: addressController,
        );
      },
    );
  }
}

class AddressBottomSheet extends StatefulWidget {
  final TextEditingController addressController;

  const AddressBottomSheet({Key? key, required this.addressController})
      : super(key: key);

  @override
  _AddressBottomSheetState createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final places =
      GoogleMapsPlaces(apiKey: "AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg");
  late TextEditingController searchController;
  late GoogleMapController mapController;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<String> suggestions = [];
    Timer? _debounce;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Home Address'),
            onTap: () {
              _selectAddress('Home Address');
            },
          ),
          ListTile(
            title: Text('Work Address'),
            onTap: () {
              _selectAddress('Work Address');
            },
          ),
          ListTile(
            title: Text('Add New Address'),
            onTap: () {
              _selectAddress(null);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: searchController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.black,
                hintText: 'Search Address',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            suggestions = [];
                            searchController.clear();
                          });
                        },
                        icon: Icon(Icons.clear_outlined),
                      )
                    : null,
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    _searchPlaces(value);
                  } else {
                    setState(() {
                      suggestions = [];
                    });
                  }
                });
              },
            ),
          ),
          Container(
            height: 200,
            // child: GoogleMap(
            //   initialCameraPosition: CameraPosition(
            //     target: LatLng(37.7749, -122.4194),
            //     zoom: 12.0,
            //   ),
            //   markers: markers,
            //   onMapCreated: (GoogleMapController controller) {
            //     mapController = controller;
            //   },
            // ),
          ),
        ],
      ),
    );
  }

  void _searchPlaces(String query) async {
    if (query.length >= 10) {
      PlacesAutocompleteResponse response = await places.autocomplete(query);

      // Extract suggestions
      List<String> suggestions = response.predictions
          .map((prediction) => prediction.description!)
          .toList();

      // Update the suggestions widget
      updateSuggestionsWidget(suggestions);

      // Clear existing markers
      setState(() {
        markers.clear();
      });

      // Fetch details for each prediction
      for (var prediction in response.predictions) {
        PlacesDetailsResponse details =
            await places.getDetailsByPlaceId(prediction.placeId!);

        // Extract geometry from details
        final double lat = details.result.geometry!.location.lat;
        final double lng = details.result.geometry!.location.lng;

        // Add a marker for each place
        setState(() {
          markers.add(
            Marker(
              markerId: MarkerId(details.result.placeId!),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: prediction.description!),
            ),
          );
        });
      }
    }
  }

  // void _searchPlaces(String query) async {
  //   PlacesAutocompleteResponse response = await places.autocomplete(query);

  //   // Clear existing markers
  //   setState(() {
  //     markers.clear();
  //   });

  //   // Extract suggestion descriptions
  //   List<String> suggestions = response.predictions
  //       .map((prediction) => prediction.description!)
  //       .toList();

  //   // Update UI with suggestions (replace this with your actual widget update)
  //   updateSuggestionsWidget(suggestions);
  // }

  void updateSuggestionsWidget(List<String> suggestions) {
    List<String> limitedSuggestions = suggestions.take(2).toList();

    String selectedAddress =
        limitedSuggestions.isNotEmpty ? limitedSuggestions[0] : '';

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: limitedSuggestions.map((String address) {
        return PopupMenuItem<String>(
          value: address,
          child: Text(address),
        );
      }).toList(),
    ).then((String? selectedValue) {
      if (selectedValue != null) {
        _selectAddress(selectedValue);
        print("Selected-address-----------");
        print(selectedValue);
      }
    });
  }

  // void updateSuggestionsWidget(List<String> suggestions) {
  //   String selectedAddress = suggestions.isNotEmpty ? suggestions[0] : '';

  //   showMenu<String>(
  //     context: context,
  //     position: RelativeRect.fromLTRB(0, 0, 0, 0),
  //     items: suggestions.map((String address) {
  //       return PopupMenuItem<String>(
  //         value: address,
  //         child: Text(address),
  //       );
  //     }).toList(),
  //   ).then((String? selectedValue) {
  //     if (selectedValue != null) {
  //       _selectAddress(selectedValue);
  //     }
  //   });
  // }

  // void updateSuggestionsWidget(List<String> suggestions) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Column(
  //         children: [
  //           ListTile(
  //             title: Text('Suggestions'),
  //             dense: true,
  //           ),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: suggestions.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return ListTile(
  //                   title: Text(suggestions[index]),
  //                   onTap: () {
  //                     _selectAddress(suggestions[index]);
  //                   },
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  // void updateSuggestionsWidget(List<String> suggestions) {
  //   // Replace this with your actual widget update logic
  //   // For example, if you have a ListView widget, you can update its data source
  //   // and it will automatically rebuild with the new suggestions.
  //   // Here is a simple example using a print statement:
  //   print('Suggestions: $suggestions');
  // }

  // void _searchPlaces(String query) async {
  //   PlacesAutocompleteResponse response = await places.autocomplete(query);

  //   // Clear existing markers
  //   setState(() {
  //     markers.clear();
  //   });

  //   // Fetch details for each prediction
  //   for (var prediction in response.predictions) {
  //     PlacesDetailsResponse details =
  //         await places.getDetailsByPlaceId(prediction.placeId!);

  //     // Extract geometry from details
  //     final double lat = details.result.geometry!.location.lat;
  //     final double lng = details.result.geometry!.location.lng;

  //     // Add a marker for each place
  //     setState(() {
  //       markers.add(
  //         Marker(
  //           markerId: MarkerId(details.result.placeId!),
  //           position: LatLng(lat, lng),
  //           infoWindow: InfoWindow(title: prediction.description!),
  //         ),
  //       );
  //     });
  //   }
  // }
  //old -code-------
  // void _selectAddress(String? address) {
  //   if (address != null) {
  //     widget.addressController.text = address;

  //     // Move the map to the selected address
  //     _moveToLocation(address);

  //     Navigator.pop(context, address);
  //   } else {
  //     Navigator.pop(context, null);
  //   }
  // }

  // void _moveToLocation(String address) async {
  //   PlacesDetailsResponse details = await places.getDetailsByPlaceId(
  //     (await places.autocomplete(address)).predictions.first.placeId!,
  //   );

  //   final double lat = details.result.geometry!.location.lat;
  //   final double lng = details.result.geometry!.location.lng;

  //   // Move the map to the selected location
  //   mapController.animateCamera(
  //     CameraUpdate.newLatLng(LatLng(lat, lng)),
  //   );
  // }
//-new------code
  void _selectAddress(String? address) {
    if (address != null) {
      widget.addressController.text = address;
      _moveToLocation(address);
      Navigator.pop(context, address);
    } else {
      Navigator.pop(context, null);
    }
  }

  void _moveToLocation(String address) async {
    int maxRetries = 3;
    int retryCount = 0;
    PlacesDetailsResponse? details;

    do {
      try {
        details = await places.getDetailsByPlaceId(
          (await places.autocomplete(address)).predictions.first.placeId!,
        );
      } catch (e) {
        print("Error fetching details: $e");
        retryCount++;
      }
    } while (details == null && retryCount < maxRetries);

    if (details != null) {
      final double lat = details.result.geometry!.location.lat;
      final double lng = details.result.geometry!.location.lng;

      mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(lat, lng)),
      );

      _updateMarkers(LatLng(lat, lng), address);
    } else {
      // Handle the case when details cannot be retrieved even after retries.
      print("Unable to fetch details after multiple retries");
    }
  }

  // void _moveToLocation(String address) async {
  //   PlacesDetailsResponse details = await places.getDetailsByPlaceId(
  //     (await places.autocomplete(address)).predictions.first.placeId!,
  //   );

  //   final double lat = details.result.geometry!.location.lat;
  //   final double lng = details.result.geometry!.location.lng;

  //   mapController?.animateCamera(
  //     CameraUpdate.newLatLng(LatLng(lat, lng)),
  //   );

  //   _updateMarkers(LatLng(lat, lng), address);
  // }

  void _updateMarkers(LatLng position, String address) {
    setState(() {
      markers.clear();
    });

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(address),
          position: position,
          infoWindow: InfoWindow(
            title: address,
            snippet: '',
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    places.dispose();
    searchController.dispose();
    super.dispose();
  }
}
