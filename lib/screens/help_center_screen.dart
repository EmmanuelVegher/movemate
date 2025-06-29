import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          _buildFaqTile(
            question: 'How do I track my shipment?',
            answer: 'You can track your shipment from the Home screen by tapping on the tracking card, or from the Shipment History tab by selecting an active order.',
          ),
          _buildFaqTile(
            question: 'What payment methods are accepted?',
            answer: 'We accept all major credit and debit cards, including Visa and Mastercard. You can also opt for Cash on Delivery for eligible orders.',
          ),
          _buildFaqTile(
            question: 'How is the shipping cost calculated?',
            answer: 'Shipping cost is calculated based on the distance between the sender and receiver, the approximate weight of the parcel, and the selected delivery option (Express or Normal).',
          ),
        ],
      ),
    );
  }

  Widget _buildFaqTile({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias, // Ensures the ExpansionTile color is contained
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w500)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: Text(answer, style: const TextStyle(color: kMutedTextColor)),
          ),
        ],
      ),
    );
  }
}