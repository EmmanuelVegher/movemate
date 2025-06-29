import 'package:flutter/material.dart';
import 'package:movemate/screens/live_tracking_screen.dart';
import 'package:movemate/utils/colors.dart';

import 'order_delivered_screen.dart';

class ParcelReadyScreen extends StatelessWidget {
  const ParcelReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/images/movemate_logo.png', height: 100),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('assets/images/drone_delivery.png', height: 200), // Replace with your drone asset
            const SizedBox(height: 20),
            const Text(
              'Your order is almost there, ready to pick your parcel',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Timeline (reusing the one from LiveTrackingScreen for consistency)
            _buildTimeline(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // This button takes the user to the live map view.
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrderDeliveredScreen(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Let\'s go', style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Simplified timeline widget for this screen
  Widget _buildTimeline() {
    return const Column(
      children: [
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text('Arriving today!', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Your delivery is arriving today!'),
          trailing: Text('Feb 23 at 9:50pm'),
        ),
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text('Has been Shipped', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('The parcel is waiting for collection'),
          trailing: Text('Feb 20'),
        ),
      ],
    );
  }
}