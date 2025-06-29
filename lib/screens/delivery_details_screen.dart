import 'package:flutter/material.dart';
import 'package:movemate/screens/pricing_screen.dart';
import 'package:movemate/utils/colors.dart';

// Dummy data for box options
class BoxOption {
  final String title;
  final String dimensions;
  final String price;
  final String imagePath;

  BoxOption(this.title, this.dimensions, this.price, this.imagePath);
}

class DeliveryDetailsScreen extends StatefulWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}


class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  int _selectedDeliveryOption = 0; // 0 for Express, 1 for Normal
  int _selectedBoxIndex = 1; // Default to Truck container
  int _selectedCategoryIndex = -1; // -1 for none selected

  final List<BoxOption> _boxOptions = [
    BoxOption('Large box', '50" x 60"', '\$200', 'assets/images/box_large.png'),
    BoxOption('Truck container', '50" x 60"', '\$370', 'assets/images/truck_container.png'),
    BoxOption('Container', '2.3 m x 7.5 m', '\$600', 'assets/images/container.png'),
  ];

  final List<String> _categories = ['Documents', 'Glass', 'Liquid', 'Food', 'Electronic', 'Product', 'Others'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Details', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: kTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Delivery Option Section ---
            _buildSectionTitle('Delivery Option'),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildSelectableCard(
                    title: 'Express Delivery', icon: Icons.delivery_dining, index: 0, groupValue: _selectedDeliveryOption,
                    onTap: () => setState(() => _selectedDeliveryOption = 0)),
                const SizedBox(width: 15),
                _buildSelectableCard(
                    title: 'Normal Delivery', icon: Icons.local_shipping, index: 1, groupValue: _selectedDeliveryOption,
                    onTap: () => setState(() => _selectedDeliveryOption = 1)),
              ],
            ),
            const SizedBox(height: 10),
            if (_selectedDeliveryOption == 0)
              const Row(
                children: [
                  Icon(Icons.info_outline, color: kAccentColor, size: 16),
                  SizedBox(width: 5),
                  Text('Express delivery charge extra 10% cost', style: TextStyle(color: kAccentColor)),
                ],
              ),

            // --- Product Details Section ---
            const SizedBox(height: 30),
            _buildSectionTitle('Product Details'),
            const SizedBox(height: 10),
            _buildTextField(icon: Icons.production_quantity_limits, label: 'Product name'),
            const SizedBox(height: 15),
            _buildTextField(icon: Icons.scale_outlined, label: 'Approx weight'),

            // --- Available Boxes Section ---
            const SizedBox(height: 30),
            _buildSectionTitle('Available boxes'),
            const SizedBox(height: 10),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _boxOptions.length,
                itemBuilder: (context, index) {
                  return _buildBoxCard(
                    option: _boxOptions[index],
                    isSelected: _selectedBoxIndex == index,
                    onTap: () => setState(() => _selectedBoxIndex = index),
                  );
                },
              ),
            ),


            // --- Categories Section ---
            const SizedBox(height: 30),
            _buildSectionTitle('Categories'),
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
                      _selectedCategoryIndex = selected ? index : -1;
                    });
                  },
                  selectedColor: kPrimaryColor,
                  labelStyle: TextStyle(
                      color: _selectedCategoryIndex == index ? Colors.white : kTextColor
                  ),
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                );
              }),
            ),

            // --- Next Button ---
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PricingScreen()));
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

  // Helper methods for building UI components
  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
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

  Widget _buildSelectableCard({required String title, required IconData icon, required int index, required int groupValue, required VoidCallback onTap}) {
    bool isSelected = index == groupValue;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: isSelected ? Colors.white : kTextColor),
              const SizedBox(height: 5),
              Text(title, style: TextStyle(color: isSelected ? Colors.white : kTextColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoxCard({required BoxOption option, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? kPrimaryColor : Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(option.title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : kTextColor)),
            Text(option.dimensions, style: TextStyle(color: isSelected ? Colors.white70 : kMutedTextColor, fontSize: 12)),
            Text(option.price, style: TextStyle(color: isSelected ? Colors.white70 : kMutedTextColor, fontSize: 12)),
            const Spacer(),
            Align(alignment: Alignment.bottomRight, child: Image.asset(option.imagePath, height: 40))
          ],
        ),
      ),
    );
  }
}