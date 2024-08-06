import 'package:Lekhone/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyParcelWidget extends StatefulWidget {
  const MyParcelWidget({Key? key, required Map<String, String> parcelDetails, required Null Function() onPressed})
      : _parcelDetails = parcelDetails,
        super(key: key);

  final Map<String, String> _parcelDetails;

  @override
  _MyParcelWidgetState createState() => _MyParcelWidgetState();
}

class _MyParcelWidgetState extends State<MyParcelWidget> {
  late Map<String, String> parcelDetails;

  @override
  void initState() {
    super.initState();
    parcelDetails = widget._parcelDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildParcelCard(context, parcelDetails),
      ],
    );
  }

  Widget _buildParcelCard(
      BuildContext context, Map<String, String> parcelDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 174,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  parcelDetails['Trip_id'] ?? 'Loading...',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(
                  height: 31,
                  width: 78,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          ImageUtils.icAmazon), // Update with your image URL
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parcelDetails['Status'] ?? 'Loading...',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 3),
                Text(
                  'Last update: 3 hours ago',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 5,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                  child: LinearProgressIndicator(
                    value: 0.9,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    backgroundColor: const Color(0xFFF8F8F8),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SvgPicture.asset(ImageUtils
                          .icDetailsSVG), // Update with your SVG asset path
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
