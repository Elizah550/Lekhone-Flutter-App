import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:Lekhone/data/data.dart';
import 'package:Lekhone/models/models.dart';
import 'package:Lekhone/ui/views/details/parcel_details_screen.dart';
import 'package:Lekhone/ui/widgets/parcel_size_widget.dart';

class SendParcelScreen extends StatelessWidget {
  const SendParcelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TrackerApp(),
              ),
            );
            // Navigator.pop(context);
          },
        ),
        title: Text(
          'Send parcel',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: ListView(
            children: [
              const SizedBox(height: 25),
              Text(
                'Parcel Size',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ParcelData.parcelList.length,
                itemBuilder: (context, index) {
                  Parcel parcel = ParcelData.parcelList[index];
                  return ParcelSizeWidget(
                    size: parcel.size,
                    image: parcel.image,
                    dimension: parcel.dimension,
                    description: parcel.description,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParcelDetailsScreen(
                            parcel: parcel,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
