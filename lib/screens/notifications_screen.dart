import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _enableNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
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
          SwitchListTile.adaptive(
            title: const Text('Enable Notifications', style: TextStyle(fontWeight: FontWeight.w500)),
            value: _enableNotifications,
            onChanged: (bool value) {
              setState(() {
                _enableNotifications = value;
              });
            },
            activeColor: kPrimaryColor,
          ),
          const Divider(height: 30),
          const Text('Recent Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildNotificationTile(
            icon: Icons.local_shipping,
            color: Colors.green,
            title: 'Your shipment is arriving today!',
            subtitle: '#NEJ2008934122231 is out for delivery.',
            time: '5m ago',
          ),
          _buildNotificationTile(
            icon: Icons.check_circle,
            color: kPrimaryColor,
            title: 'Shipment Delivered',
            subtitle: '#NEJ2008934122234 has been delivered.',
            time: '2d ago',
          ),
          _buildNotificationTile(
            icon: Icons.payment,
            color: kAccentColor,
            title: 'Payment Successful',
            subtitle: 'Payment for order #NEJ2008934122231 was successful.',
            time: '3d ago',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({required IconData icon, required Color color, required String title, required String subtitle, required String time}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(time, style: const TextStyle(color: kMutedTextColor, fontSize: 12)),
      ),
    );
  }
}