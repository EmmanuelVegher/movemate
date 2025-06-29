MoveMate - A Flutter Logistics App
MoveMate is a feature-rich logistics and shipment tracking application built with Flutter. This project serves as a high-fidelity mobile translation of a popular Dribbble design, demonstrating how to build complex, beautiful, and animated user interfaces that are ready for real-world use.
The application covers a complete user journey, from tracking past shipments and calculating costs to creating new ones with live map integration, and finally rating the delivery service.
<p align="center">
<img src="https://i.ibb.co/L5w2t3Y/movemate-promo.png" alt="MoveMate App Showcase" width="800"/>
</p>
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
Tech Stack & Key Packages
Framework: Flutter 3.x.x
Language: Dart 3.x.x
State Management: StatefulWidget & setState
Packages:
google_fonts: For beautiful, consistent typography.
flutter_staggered_animations: For elegant list animations.
geolocator: To get the device's current GPS coordinates.
geocoding: To convert coordinates into addresses.
google_maps_flutter: For displaying interactive maps.
flutter_polyline_points: To draw routes on the map.
lottie: For high-quality, complex vector animations.
Getting Started
This project is a starting point for a Flutter application. To get a copy of the project up and running on your local machine, follow the setup instructions below.
Prerequisites
You must have the Flutter SDK installed on your system.
An IDE like VS Code or Android Studio with the Flutter & Dart plugins.
A Google Maps API Key.
Installation & Setup
1. Clone the Repository:
Generated bash
git clone https://github.com/your-username/movemate.git
cd movemate
Use code with caution.
Bash
2. Install Dependencies:
Run the following command from the root of the project directory:
Generated bash
flutter pub get
Use code with caution.
Bash
3. Configure Google Maps API Key:
This project uses Google Maps for live tracking and address selection. You need to enable the following APIs in your Google Cloud Console project:
Maps SDK for Android
Maps SDK for iOS
Directions API
Follow the official guides to create an API key: Get an API Key.
Once you have your key:
For Android:
Open the file android/app/src/main/AndroidManifest.xml.
Inside the <application> tag, replace the placeholder with your actual API key:
Generated xml
<meta-data android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
Use code with caution.
Xml
For iOS:
Open the file ios/Runner/AppDelegate.swift.
Add import GoogleMaps at the top.
Inside the application function, add the following line, replacing the placeholder:
Generated swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY_HERE")
Use code with caution.
Swift
In the App Code:
Open the files that use the API key (e.g., lib/screens/tracking_order_screen.dart).
Find the constant googleApiKey and replace the placeholder value with your key.
4. Run the Application:
Make sure a device is connected or an emulator is running, then execute:
Generated bash
flutter run
Use code with caution.
Bash
A few resources to get you started if this is your first Flutter project:
Lab: Write your first Flutter app
Cookbook: Useful Flutter samples
For help getting started with Flutter development, view the
online documentation, which offers tutorials,
samples, guidance on mobile development, and a full API reference.