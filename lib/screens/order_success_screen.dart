import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movemate/utils/colors.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button
        title: Image.asset('assets/images/movemate_logo.png', height: 30),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            // Lottie Animation!
            Lottie.asset(
              'assets/animations/success_check.json', // Your Lottie file
              height: 150,
              repeat: false,
            ),
            const SizedBox(height: 20),
            const Text(
              'ORDER HAS BEEN PLACED!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'We will keep you posted about the status of the order. We will send you a alert when the order is ready for delivery.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kMutedTextColor, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/order_placed_art.png', height: 150), // Replace with your asset
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to tracking screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Track your order', style: TextStyle(fontSize: 18, color: Colors.white)),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}