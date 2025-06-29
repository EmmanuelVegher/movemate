import 'dart:async';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:movemate/screens/delivery_details_screen.dart';
import 'package:movemate/utils/colors.dart';

// A default starting position in case location is denied
const LatLng _defaultLocation = LatLng(34.0522, -118.2437); // Los Angeles

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  late GoogleMapController _googleMapController;

  // State to hold the current camera position, which will be updated
  CameraPosition _cameraPosition = const CameraPosition(
    target: _defaultLocation,
    zoom: 14.0,
  );

  // State to hold the fetched address details for the form
  String _street = '';
  String _addressDetails = '';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  /// Determines the current position of the device.
  /// When a position is determined, it animates the map to that position.
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable them.')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location permissions are denied.')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    // Animate the map to the new position
    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
      ),
    );

    // Fetch the address from the coordinates
    _getAddressFromLatLng(LatLng(position.latitude, position.longitude));
  }

  /// Fetches a human-readable address from LatLng coordinates.
  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _street = place.street ?? '';
          _addressDetails = '${place.locality}, ${place.administrativeArea} ${place.postalCode}';
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _googleMapController = controller;
              _mapController.complete(controller);
            },
            // When the camera stops moving, fetch the new address
            onCameraIdle: () async {
              // Get the new center of the map
              LatLng center = await _googleMapController.getLatLng(
                ScreenCoordinate(
                  x: MediaQuery.of(context).size.width ~/ 2,
                  y: MediaQuery.of(context).size.height ~/ 2,
                ),
              );
              _getAddressFromLatLng(center);
            },
          ),

          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Icon(Icons.location_on, size: 50.0, color: kPrimaryColor),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5 + 20,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: _determinePosition, // Button now calls the location function
              child: const Icon(Icons.my_location, color: kTextColor),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  // Pass the fetched address details to the form
                  child: AddressDetailsForm(
                    street: _street,
                    addressDetails: _addressDetails,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


class AddressDetailsForm extends StatefulWidget {
  // Now accepts initial values for the text fields
  final String street;
  final String addressDetails;

  const AddressDetailsForm({
    super.key,
    required this.street,
    required this.addressDetails,
  });

  @override
  State<AddressDetailsForm> createState() => _AddressDetailsFormState();
}

class _AddressDetailsFormState extends State<AddressDetailsForm> {
  bool _saveAddress = false;

  // Controllers to manage text field state
  late final TextEditingController _streetController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant AddressDetailsForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the text field when the parent widget provides a new street name
    if (widget.street != oldWidget.street) {
      _streetController.text = widget.street;
    }
  }

  @override
  void dispose() {
    _streetController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 20),
          Text(widget.street, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(widget.addressDetails, style: const TextStyle(color: kMutedTextColor)),
          const SizedBox(height: 20),

          _buildTextField(controller: _streetController, icon: Icons.business_outlined, label: 'Floor or unit number'),
          const SizedBox(height: 15),
          _buildTextField(controller: _phoneController, icon: Icons.phone_outlined, label: 'Phone Number'),
          const SizedBox(height: 15),
          _buildTextField(controller: _nameController, icon: Icons.person_outline, label: 'Name'),
          const SizedBox(height: 15),

          Row(
            children: [
              Checkbox(value: _saveAddress, onChanged: (bool? value) => setState(() => _saveAddress = value ?? false), activeColor: kPrimaryColor),
              const Text('Save this address'),
            ],
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DeliveryDetailsScreen())),
              style: ElevatedButton.styleFrom(backgroundColor: kAccentColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              child: const Text('Confirm', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required IconData icon, required String label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: kMutedTextColor),
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}