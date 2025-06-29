import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:movemate/screens/address_details_screen.dart';
import 'package:movemate/screens/search_screen.dart';
import 'package:movemate/screens/tracking_order_screen.dart';
import 'package:movemate/utils/colors.dart';
import 'package:movemate/utils/custom_page_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variable to hold the current address, with an initial loading message.
  String _currentAddress = 'Loading location...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// Fetches the device's current location and updates the UI.
  /// Handles permissions and converts coordinates to a human-readable address.
  Future<void> _getCurrentLocation() async {
    // 1. Check for location permissions and service status.
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _currentAddress = 'Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => _currentAddress = 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _currentAddress = 'Permissions permanently denied.');
      return;
    }

    // 2. If permissions are granted, get the current position and address.
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        if (mounted) {
          setState(() {
            _currentAddress = "${place.locality}, ${place.administrativeArea}";
          });
        }
      }
    } catch (e) {
      if (mounted) setState(() => _currentAddress = 'Failed to get location.');
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: CustomScrollView(
        slivers: [
          // The app bar now receives the dynamic address from the state.
          _buildSliverAppBar(context, _currentAddress),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tracking', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildTrackingCard(context),
                  const SizedBox(height: 30),
                  const Text('Available vehicles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildVehicleList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, String address) {
    return SliverAppBar(
      backgroundColor: kPrimaryColor,
      pinned: true,
      floating: true,
      expandedHeight: 150.0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/user_avatar.png'),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.white70, size: 16),
              SizedBox(width: 4),
              Text('Your location', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Text(address, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildSearchBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(SlideUpRoute(page: const SearchScreen())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: const Row(
          children: [
            Icon(Icons.search, color: kMutedTextColor),
            SizedBox(width: 10),
            Text('Enter the receipt number ...', style: TextStyle(color: kMutedTextColor)),
            Spacer(),
            CircleAvatar(
              backgroundColor: kAccentColor,
              radius: 18,
              child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrackingOrderScreen())),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Shipment Number', style: TextStyle(color: kMutedTextColor)),
                  const Spacer(),
                  Image.asset('assets/images/forklift_icon.png', height: 30),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Text('NEJ2008934122231', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TrackingDetailColumn(icon: Icons.unarchive_outlined, title: 'Sender', value: 'Atlanta, 5243'),
                  _TrackingDetailColumn(icon: Icons.access_time, title: 'Time', value: '2 day - 3 days'),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TrackingDetailColumn(icon: Icons.archive_outlined, title: 'Receiver', value: 'Chicago, 6342'),
                  _TrackingDetailColumn(icon: Icons.check_circle_outline, title: 'Status', value: 'Waiting to collect'),
                ],
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddressDetailsScreen())),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: kAccentColor),
                    SizedBox(width: 5),
                    Text('Add Stop', style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleList() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildVehicleCard('Ocean freight', 'International', 'assets/images/ocean_freight.png'),
          const SizedBox(width: 15),
          _buildVehicleCard('Cargo freight', 'Reliable', 'assets/images/cargo_freight.png'),
          const SizedBox(width: 15),
          _buildVehicleCard('Air freight', 'Fastest', 'assets/images/air_freight.png'),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(String title, String subtitle, String imagePath) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: kMutedTextColor, fontSize: 12)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(imagePath, height: 50),
          )
        ],
      ),
    );
  }
}

class _TrackingDetailColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _TrackingDetailColumn({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: kMutedTextColor, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}