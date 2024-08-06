import 'package:flutter/material.dart';

class DeliveryDetailsPage extends StatefulWidget {
  const DeliveryDetailsPage({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailsPage> createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  int _selectedPosition = -1; // Track selected index (none initially)

  final List<DeliveryEvent> _events = [
    DeliveryEvent(
        title: 'Order Placed', subtitle: '2023-12-19 12:00 PM Order Created!'),
    DeliveryEvent(title: 'Testing 2', subtitle: '2023-12-19 12:15 PM'),
    DeliveryEvent(title: 'Testing 3', subtitle: '2023-12-19 12:30 PM'),
  ]; // Your actual events list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parcel Tracker'),
      ),
      body: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0, // Remove card elevation
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0), // Set border radius to zero
            ),
            color: Colors.transparent, // Set card color to transparent
            child: InkWell(
              // Tappable area for event
              onTap: () {
                setState(() {
                  // Update selected index
                  _selectedPosition = _selectedPosition == index ? -1 : index;
                });
              },
              splashColor:
                  Colors.transparent, // Set splash color to transparent
              highlightColor:
                  Colors.transparent, // Set highlight color to transparent
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressLine(index),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _events[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (_selectedPosition == index)
                            Text(_events[index].subtitle),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    getIconWidget(index),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressLine(int index) {
    return SizedBox(
      width: 50, // Width of the progress bar area
      child: Column(
        children: List.generate(
          1,
          (i) {
            final isSelected = _selectedPosition == index;

            return Row(
              children: [
                Container(
                  width: 10, // Width of the circle
                  height: 10, // Height of the circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2, // Height of the line
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }

  Widget getIconWidget(int index) {
    if (_selectedPosition == index) {
      return const Icon(Icons.arrow_upward, color: Colors.blue);
    } else {
      return const Icon(Icons.arrow_downward, color: Colors.grey);
    }
  }
}

class DeliveryEvent {
  final String title;
  final String subtitle;

  const DeliveryEvent({required this.title, required this.subtitle});
}
