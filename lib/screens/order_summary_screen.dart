import 'package:flutter/material.dart';
import 'package:movemate/screens/order_success_screen.dart'; // The next screen in the flow
import 'package:movemate/utils/colors.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Details', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: kTextColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: kTextColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildSectionTitle('Product details'),
                  _buildProductDetailsCard(),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Selected Method'),
                  _buildSelectedMethodCard(),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Payment method'),
                  _buildPaymentMethodCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Bottom "Place order" button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderSuccessScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Place order', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets for this screen
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProductDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(Icons.person, 'Sender', 'Atlanta, 5243', Icons.person, 'Reciver', 'Chicago, 6342'),
            const Divider(height: 25),
            _buildDetailRow(Icons.all_inbox, 'Condition', 'Breakable Items', Icons.scale, 'Weight', '324 kg'),
            const Divider(height: 25),
            _buildDetailRow(Icons.category, 'Sending', 'Office Stuffs', null, '', ''),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon1, String title1, String value1, IconData? icon2, String title2, String value2) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(icon1, size: 20, color: kMutedTextColor),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title1, style: const TextStyle(color: kMutedTextColor)),
                  Text(value1, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
        ),
        if (icon2 != null)
          Expanded(
            child: Row(
              children: [
                Icon(icon2, size: 20, color: kMutedTextColor),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title2, style: const TextStyle(color: kMutedTextColor)),
                    Text(value2, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedMethodCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Container', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text('2.3 m x 7.5 m', style: TextStyle(color: kMutedTextColor)),
                  const Text('\$600', style: TextStyle(color: kMutedTextColor)),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Change', style: TextStyle(color: kAccentColor)),
                  )
                ],
              ),
            ),
            Image.asset('assets/images/order_summary_art.png', height: 80), // Replace with your asset
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const ListTile(
        leading: Icon(Icons.credit_card, color: kTextColor),
        title: Text('Online payment'),
        trailing: Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}