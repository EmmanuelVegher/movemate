import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movemate/screens/parcel_ready_screen.dart'; // The screen to navigate to on tap
import 'package:movemate/utils/colors.dart'; // Your custom colors file

/// A data model for a single shipment item.
class Shipment {
  final String status;
  final String deliveryNumber;
  final String amount;
  final String date;
  final Color statusColor;
  final IconData statusIcon;

  Shipment({
    required this.status,
    required this.deliveryNumber,
    required this.amount,
    required this.date,
    required this.statusColor,
    required this.statusIcon,
  });
}

/// The main screen that displays a history of shipments.
class ShipmentHistoryScreen extends StatefulWidget {
  const ShipmentHistoryScreen({super.key});

  @override
  State<ShipmentHistoryScreen> createState() => _ShipmentHistoryScreenState();
}

class _ShipmentHistoryScreenState extends State<ShipmentHistoryScreen> {
  int _selectedFilterIndex = 0;
  List<Shipment> _filteredShipments = [];

  final List<String> _filters = [
    "All",
    "Completed",
    "In progress",
    "Pending order",
    "Cancelled"
  ];

  // The master list of all shipments.
  final List<Shipment> _allShipments = [
    Shipment(
      status: "in-progress",
      deliveryNumber: "#NEJ2008934122231",
      amount: "\$1400 USD",
      date: "Sep 20, 2023",
      statusColor: Colors.green,
      statusIcon: Icons.history_toggle_off,
    ),
    Shipment(
      status: "loading",
      deliveryNumber: "#NEJ2008934122232",
      amount: "\$230 USD",
      date: "Sep 20, 2023",
      statusColor: kAccentColor,
      statusIcon: Icons.sync, // The rotating icon
    ),
    Shipment(
      status: "completed",
      deliveryNumber: "#NEJ2008934122234",
      amount: "\$3570 USD",
      date: "Sep 18, 2023",
      statusColor: kPrimaryColor,
      statusIcon: Icons.check_circle,
    ),
    Shipment(
      status: "pending order",
      deliveryNumber: "#NEJ2008934122233",
      amount: "\$650 USD",
      date: "Sep 20, 2023",
      statusColor: Colors.orange,
      statusIcon: Icons.pending,
    ),
    Shipment(
      status: "cancelled",
      deliveryNumber: "#NEJ2008934122235",
      amount: "\$120 USD",
      date: "Sep 15, 2023",
      statusColor: Colors.red,
      statusIcon: Icons.cancel,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // On initialization, the filtered list is the same as the master list.
    _filteredShipments = _allShipments;
  }

  /// Filters the master list of shipments based on the selected category.
  void _filterShipments(int index) {
    setState(() {
      _selectedFilterIndex = index;
      String filter = _filters[index].toLowerCase();

      if (filter == 'all') {
        _filteredShipments = _allShipments;
      } else {
        // Find all shipments where the status matches the selected filter.
        _filteredShipments = _allShipments
            .where((shipment) => shipment.status.toLowerCase() == filter)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Shipment history',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          // Horizontal Filter Bar
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedFilterIndex == index;
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: GestureDetector(
                    onTap: () => _filterShipments(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? kAccentColor
                            : Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "${_filters[index]} ${isSelected && index == 0 ? _allShipments.length : ''}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Shipments List Container
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  // Use the filtered list for count and item data.
                  itemCount: _filteredShipments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          // Card is now tappable to navigate to tracking.
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ParcelReadyScreen(),
                              ));
                            },
                            child: ShipmentCard(shipment: _filteredShipments[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A card widget to display details of a single shipment.
/// It is stateful to manage the animation for the loading icon.
class ShipmentCard extends StatefulWidget {
  final Shipment shipment;
  const ShipmentCard({super.key, required this.shipment});

  @override
  State<ShipmentCard> createState() => _ShipmentCardState();
}

class _ShipmentCardState extends State<ShipmentCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller only if the status is 'loading'
    if (widget.shipment.status == 'loading') {
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..repeat(); // Set it to repeat for a continuous spinning effect
    }
  }

  @override
  void dispose() {
    // Dispose the controller if it was initialized to prevent memory leaks
    if (widget.shipment.status == 'loading') {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Conditionally display the animated or static icon
                      if (widget.shipment.status == 'loading')
                        RotationTransition(
                          turns: _controller,
                          child: Icon(widget.shipment.statusIcon, color: widget.shipment.statusColor, size: 16),
                        )
                      else
                        Icon(widget.shipment.statusIcon, color: widget.shipment.statusColor, size: 16),

                      const SizedBox(width: 6),
                      Text(
                        widget.shipment.status,
                        style: TextStyle(
                            color: widget.shipment.statusColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Image.asset('assets/images/box_icon.png', height: 40)
              ],
            ),
            const SizedBox(height: 12),
            const Text('Arriving today!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(
              'Your delivery, ${widget.shipment.deliveryNumber} from Atlanta, is arriving today!',
              style: const TextStyle(color: kMutedTextColor, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Text('${widget.shipment.amount} • ${widget.shipment.date}',
                style: const TextStyle(color: kTextColor, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}