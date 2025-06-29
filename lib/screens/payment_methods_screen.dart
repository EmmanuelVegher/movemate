import 'package:flutter/material.dart';
import 'package:movemate/screens/add_payment_method_screen.dart'; // <-- IMPORT THE NEW SCREEN
import 'package:movemate/utils/colors.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
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
            _buildPaymentCard('assets/images/visa_logo.png', '**** **** **** 6342'),
            const SizedBox(height: 15),
            _buildPaymentCard('assets/images/mastercard_logo.png', '**** **** **** 8931'),
            const Spacer(),
            OutlinedButton.icon(
              // --- MODIFIED: ADD NAVIGATION LOGIC ---
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddPaymentMethodScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Payment Method'),
              style: OutlinedButton.styleFrom(
                foregroundColor: kPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(String logoPath, String cardNumber) {
    return Card(
      child: ListTile(
        leading: Image.asset(logoPath, height: 25),
        title: Text(cardNumber, style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 2)),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}