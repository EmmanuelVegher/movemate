import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

import 'order_delivered_screen.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- ADD A FLOATING ACTION BUTTON FOR DEMO PURPOSES ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This simulates the delivery being completed
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OrderDeliveredScreen()),
          );
        },
        backgroundColor: kAccentColor,
        child: const Icon(Icons.check),
        tooltip: 'Simulate Delivery',
      ),
      body: Stack(
        children: [
          // Background map
          Image.asset(
            'assets/images/map_placeholder.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Top back button
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: kTextColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: _TrackingDetailsPanel(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TrackingDetailsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildParcelDestination(),
          const SizedBox(height: 20),
          _buildTimeline(),
          const SizedBox(height: 20),
          _buildDriverInfo(),
        ],
      ),
    );
  }

  Widget _buildParcelDestination() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Parcel Destination', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 5),
        Text('4 Meyappa Chettiar Rd', style: TextStyle(color: kMutedTextColor)),
        Divider(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Estimated Time', style: TextStyle(color: kMutedTextColor)),
            Text('09:50 PM', style: TextStyle(fontWeight: FontWeight.bold)),
            Chip(
              label: Text('5 mins', style: TextStyle(color: Colors.white)),
              backgroundColor: kPrimaryColor,
            )
          ],
        )
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _TimelineTile(title: 'Arriving today!', subtitle: 'Your delivery from Atlanta is arriving today!', date: 'Feb 23 at 9:50pm', isFirst: true, isCompleted: true),
        _TimelineTile(title: 'Has been Shipped', subtitle: 'The parcel is waiting for collection', date: 'Feb 20', isCompleted: true),
        _TimelineTile(title: 'Has been sent', subtitle: 'The parcel is waiting for collection', date: 'Feb 17', isLast: true, isCompleted: true),
      ],
    );
  }

  Widget _buildDriverInfo() {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/user_avatar.png'),
        ),
        title: const Text('Eve Young', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Driver'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(icon: const Icon(Icons.message, color: kPrimaryColor), onPressed: () {})),
            const SizedBox(width: 10),
            Container(
                decoration: BoxDecoration(color: kAccentColor, shape: BoxShape.circle),
                child: IconButton(icon: const Icon(Icons.phone, color: Colors.white), onPressed: () {})),
          ],
        ),
      ),
    );
  }
}

// Custom widget for the timeline tile to make it reusable
class _TimelineTile extends StatelessWidget {
  final String title, subtitle, date;
  final bool isFirst, isLast, isCompleted;

  const _TimelineTile({
    required this.title,
    required this.subtitle,
    required this.date,
    this.isFirst = false,
    this.isLast = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    // This is a simplified representation. For a real app, a package like `timeline_tile` would be better.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (!isFirst) Container(width: 2, height: 10, color: Colors.grey),
            Icon(Icons.check_circle, color: isCompleted ? Colors.green : Colors.grey),
            if (!isLast) Expanded(child: Container(width: 2, color: Colors.grey)),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: kMutedTextColor)),
            ],
          ),
        ),
        Text(date, style: const TextStyle(color: kMutedTextColor)),
      ],
    );
  }
}