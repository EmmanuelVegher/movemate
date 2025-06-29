import 'package:flutter/material.dart';
import 'package:movemate/screens/estimated_amount_screen.dart';
import 'package:movemate/utils/colors.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  // NEW: State to manage the selected category chip
  int _selectedCategoryIndex = -1; // -1 means no chip is selected

  final List<String> _categories = [
    'Documents', 'Glass', 'Liquid', 'Food', 'Electronic', 'Product', 'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Calculate', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: kTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Destination', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildTextField(icon: Icons.unarchive_outlined, label: 'Sender location'),
            const SizedBox(height: 15),
            _buildTextField(icon: Icons.archive_outlined, label: 'Receiver location'),
            const SizedBox(height: 15),
            _buildTextField(icon: Icons.scale_outlined, label: 'Approx weight'),
            const SizedBox(height: 30),

            // --- Packaging Section (Unchanged) ---
            const Text('Packaging', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('What are you sending?'),
            const SizedBox(height: 10),
            _buildPackagingDropdown(),
            const SizedBox(height: 30),

            // --- NEWLY ADDED CATEGORIES SECTION ---
            const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('What are you sending?'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(_categories.length, (index) {
                return ChoiceChip(
                  label: Text(_categories[index]),
                  selected: _selectedCategoryIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      // If a chip is tapped, update the state to the new index.
                      // If it's tapped again (deselected), set state to -1.
                      _selectedCategoryIndex = selected ? index : -1;
                    });
                  },
                  selectedColor: kPrimaryColor,
                  labelStyle: TextStyle(
                      color: _selectedCategoryIndex == index ? Colors.white : kTextColor
                  ),
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                  showCheckmark: false, // The design does not show a checkmark
                );
              }),
            ),
            // --- END OF NEWLY ADDED SECTION ---

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EstimatedAmountScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Calculate', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required IconData icon, required String label}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: kMutedTextColor),
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPackagingDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: 'Box',
          icon: const Icon(Icons.keyboard_arrow_down),
          items: <String>['Box', 'Pallet', 'Crate']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const Icon(Icons.inventory_2_outlined, color: kMutedTextColor),
                  const SizedBox(width: 10),
                  Text(value),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ),
    );
  }
}