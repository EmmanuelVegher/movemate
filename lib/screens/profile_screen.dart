import 'package:flutter/material.dart';
import 'package:movemate/screens/payment_methods_screen.dart';
import 'package:movemate/screens/shipment_history_screen.dart';
import 'package:movemate/utils/colors.dart';

import 'about_movemate_screen.dart';
import 'edit_profile_screen.dart';
import 'help_center_screen.dart';
import 'login_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // --- THE FIX IS HERE: ADD 'context' TO EACH CALL ---
                  _buildProfileOption(context, icon: Icons.person_outline, title: 'Edit Profile'),
                  _buildProfileOption(context, icon: Icons.notifications_outlined, title: 'Notifications'),
                  _buildProfileOption(context, icon: Icons.payment_outlined, title: 'Payment Methods'),
                  _buildProfileOption(context, icon: Icons.history_outlined, title: 'Shipment History'),
                  const Divider(height: 30),
                  _buildProfileOption(context, icon: Icons.help_outline, title: 'Help Center'),
                  _buildProfileOption(context, icon: Icons.info_outline, title: 'About MoveMate'),
                  const Divider(height: 30),
                  _buildProfileOption(context, icon: Icons.logout, title: 'Logout', isLogout: true),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // ... (_buildProfileHeader and _buildProfileOption methods remain unchanged from the previous correct version)
  Widget _buildProfileHeader() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/images/user_avatar.png'),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Emmanuel Vegher',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 5),
              Text(
                  'Current balance: \$1400',
                  style: TextStyle(color: Colors.white70)
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String title, bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : kPrimaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red : kTextColor,
        ),
      ),
      trailing: isLogout ? null : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (isLogout) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Confirm Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                  TextButton(
                    child: const Text('Logout', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else {
          Widget? page;
          switch (title) {
            case 'Edit Profile':
              page = const EditProfileScreen();
              break;
            case 'Notifications':
              page = const NotificationsScreen();
              break;
            case 'Payment Methods':
              page = const PaymentMethodsScreen();
              break;
            case 'Shipment History':
              page = const ShipmentHistoryScreen();
              break;
            case 'Help Center':
              page = const HelpCenterScreen();
              break;
            case 'About MoveMate':
              page = const AboutMovemateScreen();
              break;
          }
          if (page != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => page!));
          }
        }
      },
    );
  }
}
