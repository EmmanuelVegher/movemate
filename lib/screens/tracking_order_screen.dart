import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:movemate/screens/parcel_ready_screen.dart';
import 'package:movemate/utils/colors.dart';

// IMPORTANT: Replace with your actual Google Maps API Key
const String googleApiKey = "AIzaSyDZfXKWtLVdhiWjy_t7HLajo2k5X9UHITY";


class TrackingOrderScreen extends StatefulWidget {
  const TrackingOrderScreen({super.key});

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  bool _isLiveTracking = false;

  // --- Add a Timer variable ---
  Timer? _navigationTimer;

  static const LatLng sourceLocation = LatLng(33.7490, -84.3880); // Atlanta
  static const LatLng destinationLocation = LatLng(41.8781, -87.6298); // Chicago

  List<LatLng> polylineCoordinates = [];
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getPolylinePoints();
    _setMarkers();
  }

  // --- Dispose the timer to prevent memory leaks ---

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  // --- Method to start the navigation timer ---
  void _startNavigationTimer() {
    // Cancel any existing timer
    _navigationTimer?.cancel();

    _navigationTimer = Timer(const Duration(seconds: 6), () {
      // Ensure the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ParcelReadyScreen()),
        );
      }
    });
  }

  // --- Method to cancel the timer ---
  void _cancelNavigationTimer() {
    _navigationTimer?.cancel();
  }



  void _getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    // The request object no longer contains the API key.
    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      destination: PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      mode: TravelMode.driving,
    );

    // The API key is passed as a separate, named argument to the method.
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleApiKey, // Note the parameter name is 'googleApiKey'
      request: request,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      if(mounted) setState(() {});
    }
  }
  // --- END OF CORRECTION ---

  void _setMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId('source'),
        position: sourceLocation,
        infoWindow: const InfoWindow(title: 'Departure'),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: destinationLocation,
        infoWindow: const InfoWindow(title: 'Arrival'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
    if(mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: sourceLocation,
              zoom: 5,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: {
              Polyline(
                polylineId: const PolylineId('route'),
                points: polylineCoordinates,
                color: kPrimaryColor,
                width: 6,
              ),
            },
            markers: markers,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _isLiveTracking
                ? _buildLiveTrackingPanel(context)
                : _buildInitialDetailsPanel(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialDetailsPanel(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      key: const ValueKey('initialPanel'),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildDetailsGrid(),
            const SizedBox(height: 20),
            _buildDriverInfo(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // MODIFIED: Start the timer when this button is pressed
                onPressed: () {
                  setState(() => _isLiveTracking = true);
                  _startNavigationTimer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Live Tracking', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildLiveTrackingPanel(BuildContext context) {
    return Stack(
      key: const ValueKey('liveTrackingPanel'),
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: kTextColor),
              onPressed: () {
                _cancelNavigationTimer();
                setState(() => _isLiveTracking = false);
              },
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: _buildTimelinePanelContent(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipment Number', style: TextStyle(color: kMutedTextColor)),
            Text('NEJ2008934122231', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Image.asset('assets/images/forklift_icon.png', height: 40),
      ],
    );
  }

  Widget _buildDetailsGrid() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DetailItem(icon: Icons.unarchive_outlined, title: 'Departure', value: 'Atlanta, 5243'),
            _DetailItem(icon: Icons.archive_outlined, title: 'Arrival', value: 'Chicago, 6342'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DetailItem(title: 'Customer', value: 'Jahid Hasan'),
            _DetailItem(title: 'Weight', value: '3.24 kg'),
            _DetailItem(title: 'Price', value: '\$1400 USD'),
          ],
        ),
      ],
    );
  }

  Widget _buildDriverInfo({bool isLiveTracking = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/user_avatar.png')),
      title: const Text('Eve Young', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Text('Driver'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Conditional styling for the buttons based on the view
          Container(
            decoration: BoxDecoration(
              color: isLiveTracking ? kPrimaryColor.withOpacity(0.1) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryColor.withOpacity(0.2)),
            ),
            child: IconButton(icon: const Icon(Icons.message_outlined, color: kPrimaryColor), onPressed: () {}),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(
              color: kAccentColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(icon: const Icon(Icons.phone, color: Colors.white), onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelinePanelContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The grey drag handle
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Parcel Destination section
          const Row(
            children: [
              Icon(Icons.location_on, color: kAccentColor),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Parcel Destination', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('4 Meyappa Chettiar Rd', style: TextStyle(color: kMutedTextColor)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),

          // Estimated Time section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estimated Time', style: TextStyle(color: kMutedTextColor)),
                  Text('09:50 PM', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.timelapse, color: kPrimaryColor, size: 16),
                    SizedBox(width: 5),
                    Text('5 mins', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),

          // Timeline Section
          _TimelineTile(
            imagePath: 'assets/images/truck_icon_sm.png', // Replace with your asset
            title: 'Arriving today!',
            subtitle: 'Your delivery, #NEJ2008934122231 from Atlanta, is arriving today!',
            time: 'Feb 23 at 9:50pm',
            isFirst: true,
            isCompleted: true,
          ),
          _TimelineTile(
            imagePath: 'assets/images/shipped_icon_sm.png', // Replace with your asset
            title: 'Has been Shipped',
            subtitle: 'The parcel is waiting for collection',
            time: 'Feb 20',
            isCompleted: true,
          ),
          _TimelineTile(
            imagePath: 'assets/images/box_icon_sm.png', // Replace with your asset
            title: 'Has been sent',
            subtitle: 'The parcel is waiting for collection',
            time: 'Feb 17',
            isLast: true,
            isCompleted: true,
          ),
          const SizedBox(height: 20),

          // Driver Info Section
          _buildDriverInfo(isLiveTracking: true), // Pass a flag to change button styles
        ],
      ),
    );
  }


}

class _DetailItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const _DetailItem({required this.title, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          CircleAvatar(backgroundColor: Colors.grey.shade100, child: Icon(icon, color: kTextColor, size: 20)),
          const SizedBox(width: 8),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: kMutedTextColor)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

// ADD this new helper widget at the bottom of your file, outside the State class.
class _TimelineTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String time;
  final bool isFirst;
  final bool isLast;
  final bool isCompleted;

  const _TimelineTile({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isFirst = false,
    this.isLast = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The icon and the vertical line
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!isFirst)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? kPrimaryColor : Colors.grey.shade300,
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted ? kPrimaryColor.withOpacity(0.1) : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(imagePath, height: 24, color: isCompleted ? kPrimaryColor : kMutedTextColor),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // The text content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isCompleted ? kTextColor : kMutedTextColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: kMutedTextColor),
                  ),
                ],
              ),
            ),
          ),
          // The time
          Text(time, style: const TextStyle(color: kMutedTextColor, fontSize: 12)),
        ],
      ),
    );
  }
}
