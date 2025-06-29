import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 4.0;
  final Set<int> _selectedFeedback = {}; // Use a Set to store multiple selections

  final List<String> _feedbackOptions = ['Experience', 'Maintenance', 'Timing', 'Care'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Image Section with Close Button
          Stack(
            children: [
              Image.asset('assets/images/truck_background.png', height: 200, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                top: 50,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/user_avatar.png'),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("How was John's service?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Text("Give ratings! According to service.", style: TextStyle(color: kMutedTextColor)),
                  const SizedBox(height: 20),
                  _buildStarRating(),
                  const SizedBox(height: 30),
                  _buildFeedbackOptions(),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Get Help?', style: TextStyle(color: kPrimaryColor)),
                  ),
                ],
              ),
            ),
          ),

          // Submit Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () => setState(() => _rating = index + 1.0),
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: kAccentColor,
                  size: 30,
                ),
              );
            }),
          ),
          Text(_getRatingText(), style: const TextStyle(fontWeight: FontWeight.bold, color: kAccentColor)),
        ],
      ),
    );
  }

  String _getRatingText() {
    if (_rating <= 2) return 'Standard';
    if (_rating <= 4) return 'Excellent!';
    return 'Amazing!';
  }

  Widget _buildFeedbackOptions() {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      children: List.generate(_feedbackOptions.length, (index) {
        bool isSelected = _selectedFeedback.contains(index);
        return InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedFeedback.remove(index);
              } else {
                _selectedFeedback.add(index);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? kPrimaryColor : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
            ),
            child: Text(
              _feedbackOptions[index],
              style: TextStyle(color: isSelected ? Colors.white : kTextColor),
            ),
          ),
        );
      }),
    );
  }
}