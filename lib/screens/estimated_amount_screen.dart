import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

class EstimatedAmountScreen extends StatelessWidget {
  const EstimatedAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/images/movemate_logo.png', height: 100),
            const SizedBox(height: 50),
            Image.asset('assets/images/box_icon.png', height: 200),
            const SizedBox(height: 30),
            const Text('Total Estimated Amount', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1460),
              duration: const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Text(
                  '\$${value.toStringAsFixed(0)} USD',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: kGreenColor),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'This amount is estimated this will vary if you change your location or weight',
              textAlign: TextAlign.center,
              style: TextStyle(color: kMutedTextColor),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Pop until we get back to the main screen
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Back to home', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}