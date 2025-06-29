import 'package:flutter/material.dart';
import 'package:movemate/screens/rating_screen.dart'; // Import the rating screen
import 'package:movemate/utils/colors.dart';

class OrderDeliveredScreen extends StatelessWidget {
  const OrderDeliveredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/movemate_logo.png', height: 100),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            // You can use a Lottie animation here too for the checkmark
            Image.asset('assets/images/box_checked.png', height: 250), // Placeholder image
            const SizedBox(height: 30),
            const Text(
              'YOUR ORDER HAS BEEN DELIVERED TO YOUR ADDRESS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Check your messages for the code and phone number of our delivery agent.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kMutedTextColor, fontSize: 16),
            ),
            const Spacer(),
            // --- THIS BUTTON TRIGGERS THE RATING SCREEN ---
            ElevatedButton(
              onPressed: () {
                // Show the RatingScreen as a modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows the sheet to be full-screen
                  backgroundColor: Colors.transparent,
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.9, // Start almost full
                    minChildSize: 0.5,
                    maxChildSize: 0.9,
                    builder: (_, controller) => const RatingScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Give ratings', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: kPrimaryColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Back to home', style: TextStyle(fontSize: 18, color: kPrimaryColor)),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}