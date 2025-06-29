MoveMate - Logistics & Shipment Tracking App
MoveMate is a high-fidelity Flutter application that provides a comprehensive user experience for shipping and tracking parcels. This project is a complete mobile translation of a popular Dribbble design, showcasing Flutter's power in creating beautiful, animated, and functional user interfaces.
The app covers the entire user journey, from browsing shipment history and calculating costs to creating a new shipment, live tracking on a map, and rating the service post-delivery.
Features
High-Fidelity UI/UX: A pixel-perfect implementation of the original design, focusing on clean layouts, brand-consistent colors, and intuitive user flows.
Fluid Animations: Smooth page transitions, staggered list animations, and subtle micro-interactions that enhance the user experience.
Shipment History: View a list of all shipments, filterable by status (All, In Progress, Completed, etc.).
Shipment Calculator: An easy-to-use form to get an estimated shipping cost based on destination, weight, and package type.
Complete Shipment Creation Flow:
Live Map Address Selection: An interactive map to pick sender/receiver locations.
Detailed Forms: Specify product details, packaging options, and delivery type (Express/Normal).
Pricing & Payment: A clear breakdown of costs and payment method selection.
Live Order Tracking:
View an order's route on a live Google Map.
See a real-time timeline of shipment statuses (Sent, Shipped, Arriving).
An interactive, draggable bottom sheet with detailed tracking information.
User Profile Management:
View and edit user profile information.
Manage notifications and payment methods.
Access help center and app information.
Location Services Integration:
Automatically detects and displays the user's current location.
Uses geocoding to convert map coordinates into human-readable addresses.
Post-Delivery Rating System: A user-friendly interface to rate the delivery service after completion.
Authentication Flow: A basic login/logout flow to demonstrate session management.
Screenshots & App Flow
Home Screen & Live Location	Shipment History (with Filter)
Shipment Creation Flow	Live Tracking & Details
Profile & Settings	Rating System
Tech Stack & Packages
Framework: Flutter
Language: Dart
State Management: StatefulWidget / setState (suitable for this project's scale)
Key Packages:
google_fonts: For beautiful, consistent typography.
flutter_staggered_animations: For elegant list animations.
geolocator: To get the device's current GPS coordinates.
geocoding: To convert coordinates into addresses.
google_maps_flutter: For displaying interactive maps.
flutter_polyline_points: To draw routes on the map.
lottie: For high-quality, complex vector animations (e.g., success checkmark).
Getting Started
Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.
Prerequisites
You must have Flutter installed on your system. For instructions, see the official Flutter documentation.
An IDE like VS Code or Android Studio with the Flutter plugin.
A Google Maps API Key.
Setup and Installation
1. Get a Google Maps API Key:
   This project uses Google Maps for live tracking and address selection. You need to enable the following APIs in your Google Cloud Console project:
   Maps SDK for Android
   Maps SDK for iOS
   Directions API
   Follow the official guides to create an API key and enable these services: Get an API Key.
2. Clone the Repository:
   Generated bash
   git clone https://github.com/your-username/movemate.git
   cd movemate
   Use code with caution.
   Bash
3. Install Dependencies:
   Generated bash
   flutter pub get
   Use code with caution.
   Bash
4. Configure API Keys:
   For Android:
   Open the file android/app/src/main/AndroidManifest.xml.
   Find the line <!-- THIS IS THE LINE YOU MUST ADD/EDIT -->.
   Inside the <application> tag, replace "YOUR_GOOGLE_MAPS_API_KEY" with your actual API key:
   Generated xml
   <meta-data android:name="com.google.android.geo.API_KEY"
   android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
   Use code with caution.
   Xml
   For iOS:
   Open the file ios/Runner/AppDelegate.swift.
   Add import GoogleMaps at the top.
   Inside the application function, add the following line, replacing the placeholder with your key:
   Generated swift
   GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY_HERE")
   Use code with caution.
   Swift
   In the App Code:
   Open the file lib/screens/tracking_order_screen.dart.
   Find the constant googleApiKey and replace the placeholder value with your key.
5. Run the Application:
   Connect a device or start an emulator and run the app:
   Generated bash
   flutter run
   Use code with caution.
   Bash
   Project Structure
   The project follows a standard feature-based structure to keep the code organized and scalable.
   Generated code
   lib/
   ├── main.dart             # App entry point and theme configuration
   ├── screens/              # All the individual screens of the app
   │   ├── login_screen.dart
   │   ├── main_screen.dart      # The main screen with bottom navigation
   │   ├── home_screen.dart
   │   ├── calculate_screen.dart
   │   ├── shipment_history_screen.dart
   │   ├── profile_screen.dart
   │   ├── tracking_order_screen.dart
   │   ├── address_details_screen.dart
   │   ├── delivery_details_screen.dart
   │   └── ... (and all other screens)
   ├── utils/                # Utility files
   │   ├── colors.dart         # App-wide color constants
   │   └── custom_page_route.dart # Custom page transition animations
   └── assets/               # Static assets
   ├── images/             # All PNG, JPG assets
   └── animations/         # Lottie JSON animation files
   Use code with caution.
   Author
   [Your Name] - [Your Portfolio/GitHub Link]