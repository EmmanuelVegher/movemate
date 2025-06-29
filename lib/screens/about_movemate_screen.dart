import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

class AboutMovemateScreen extends StatelessWidget {
  const AboutMovemateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About MoveMate', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/movemate_logo.png', height: 200),
            const SizedBox(height: 20),
            const Text(
              'MoveMate v1.0.0',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your trusted partner for fast, reliable, and secure parcel delivery. We are committed to providing the quickest shipment experience you ever have.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kMutedTextColor, fontSize: 16),
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('Terms of Service'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
            const Spacer(),
            const Text('© 2023 MoveMate. All Rights Reserved.', style: TextStyle(color: kMutedTextColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}