MoveMate - Logistics & Shipment Tracking App
MoveMate is a high-fidelity Flutter application providing a seamless user experience for shipping and tracking parcels. It is a complete mobile translation of a popular Dribbble design, showcasing Flutter’s power in creating beautiful, animated, and functional user interfaces.

The app covers the entire user journey, from browsing shipment history and calculating costs to creating shipments, live tracking on a map, and rating deliveries.

✨ Features
✅ High-Fidelity UI/UX
Pixel-perfect implementation with clean layouts, brand-consistent colors, and intuitive flows.

✅ Fluid Animations
Smooth page transitions, staggered list animations, and micro-interactions enhancing user experience.

✅ Shipment History
View and filter shipments by status (All, In Progress, Completed, etc.).

✅ Shipment Calculator
Estimate shipping costs based on destination, weight, and package type.

✅ Complete Shipment Creation Flow

Live Map Address Selection: Interactive map for sender/receiver selection.

Detailed Forms: Product details, packaging, and delivery type.

Pricing & Payment: Clear breakdown with payment selection.

✅ Live Order Tracking

Live route on Google Maps.

Real-time timeline of shipment statuses.

Draggable bottom sheet with detailed tracking info.

✅ User Profile Management
View/edit user details, manage notifications, payment methods, help center, and app info.

✅ Location Services Integration
Auto-detects and displays current location using geocoding for addresses.

✅ Post-Delivery Rating System
User-friendly interface for rating deliveries.

✅ Authentication Flow
Basic login/logout for session management.

📸 Screenshots & App Flow
Home Screen & Live Location

Shipment History (with Filters)

Shipment Creation Flow

Live Tracking & Details

Profile & Settings

Rating System

🛠 Tech Stack & Packages
Framework: Flutter

Language: Dart

State Management: StatefulWidget / setState

Key Packages:

google_fonts - Beautiful, consistent typography.

flutter_staggered_animations - Elegant list animations.

geolocator - GPS coordinates.

geocoding - Coordinate to address conversion.

google_maps_flutter - Interactive maps.

flutter_polyline_points - Drawing routes on maps.

lottie - Vector animations (e.g., success checkmark).

🚀 Getting Started
Follow these instructions to set up the project on your local machine for development and testing.

Prerequisites
✅ Flutter installed (Install Flutter)
✅ IDE (VS Code or Android Studio) with Flutter plugin
✅ Google Maps API Key

⚙️ Setup and Installation
1️⃣ Get a Google Maps API Key
Enable the following APIs on your Google Cloud project:

Maps SDK for Android

Maps SDK for iOS

Directions API

Follow the Google guide to create your API key.

2️⃣ Clone the Repository

git clone https://github.com/EmmanuelVegher/movemate.git
cd movemate

3️⃣ Install Dependencies
flutter pub get

4️⃣ Configure API Keys
✅ For Android:

Open android/app/src/main/AndroidManifest.xml.

Inside the <application> tag, add:

xml

<meta-data
android:name="com.google.android.geo.API_KEY"
android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
✅ For iOS:

Open ios/Runner/AppDelegate.swift.

Add at the top:

swift

import GoogleMaps
Inside the application function:

swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
✅ In the App Code:

Open lib/screens/tracking_order_screen.dart.

Replace the placeholder googleApiKey with your actual API key.

5️⃣ Run the Application
Connect a device or start an emulator:
flutter run


📂 Project Structure

lib/
├── main.dart                  # Entry point, theme config
├── screens/                   # All app screens
│   ├── login_screen.dart
│   ├── main_screen.dart       # Main screen with bottom navigation
│   ├── home_screen.dart
│   ├── calculate_screen.dart
│   ├── shipment_history_screen.dart
│   ├── profile_screen.dart
│   ├── tracking_order_screen.dart
│   ├── address_details_screen.dart
│   ├── delivery_details_screen.dart
│   └── ... (other screens)
├── utils/                     # Utility files
│   ├── colors.dart            # Color constants
│   └── custom_page_route.dart # Page transition animations
└── assets/
├── images/                # All PNG, JPG assets
└── animations/            # Lottie JSON animations
👤 Author
[Your Name]
[Your Portfolio or LinkedIn]
[GitHub Profile Link]

📬 Contact
If you have any questions, feel free to reach out via vegher.emmanuel@gmail.com.

⭐️ License
This project is licensed under the MIT License.

