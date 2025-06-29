import 'package:flutter/material.dart';
import 'package:movemate/screens/order_summary_screen.dart'; // We will create this
import 'package:movemate/utils/colors.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  int _selectedPaymentMethod = 1; // 0 for Online, 1 for Cash

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: kTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Price details'),
                    _buildPriceRow('Container fee', '\$42.00'),
                    _buildPriceRow('Driving fee', '\$5.94'),
                    _buildPriceRow('Occupancy taxes', '\$1.27', hasInfo: true),
                    _buildPriceRow('Express Delivery Charge (10%)', '\$5.00', isHighlight: true),
                    const Divider(height: 30),
                    _buildPriceRow('Total (USD)', '\$49.21', isTotal: true),
                    const SizedBox(height: 30),

                    _buildSectionTitle('Payment method'),
                    _buildPaymentOption('Online payment', 0),
                    _buildPaymentOption('Cash on delivery', 1),
                    // ... Add more payment options if needed

                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderSummaryScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Helper methods
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPriceRow(String title, String price, {bool isTotal = false, bool isHighlight = false, bool hasInfo = false}) {
    final style = TextStyle(
      fontSize: isTotal ? 18 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: isHighlight ? kAccentColor : kTextColor,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(title, style: style),
          if (hasInfo) const Icon(Icons.info_outline, color: kMutedTextColor, size: 16),
          const Spacer(),
          Text(price, style: style),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, int value) {
    bool isSelected = _selectedPaymentMethod == value;
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(value == 0 ? Icons.credit_card : Icons.money),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.circle_outlined),
        onTap: () => setState(() => _selectedPaymentMethod = value),
      ),
    );
  }
}