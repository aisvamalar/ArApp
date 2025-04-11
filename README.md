AR Shopping App

A Flutter-based mobile application that enables users to visualize products in augmented reality before making purchase decisions.

Project Overview:
This AR Shopping App (E-Sparks) allows users to browse through a catalog of furniture and other items, and then view them in AR within their own environment. This helps customers make more informed buying decisions by seeing how products would look and fit in their space.

Features:
Product Catalog: Browse through various furniture and decor items with images and pricing
Categories: Filter products by different categories
AR Visualization: View products in augmented reality in your physical space
Interactive AR: Move, rotate, and resize 3D models in AR view
Product Purchase: Add viewed products to cart
Screenshot Capture: Take photos of products in your environment

Technologies Used

Flutter: UI framework for cross-platform mobile development
AR Flutter Plugin: For implementing augmented reality features
Supabase: For storing 3D models and images
Vector Math: For 3D transformations and interactions

Prerequisites:

Flutter SDK (latest version)
Dart SDK (latest version)
Android Studio / Xcode

Required Permissions:
The app requires the following permissions
Camera access (for AR functionality)
Storage access (for saving screenshots)

Project Structure:
lib/main.dart - Entry point of the application
lib/home_screen.dart - Main screen with product catalog
lib/arview_for_3d_objects.dart - AR view implementation for 3D objects

Usage:
Open the app and browse through available products
Select a product and tap on "AR View"
Point your camera at a flat surface
Tap on the detected surface to place the 3D model

Use gestures to interact with the model:
Drag to move
Pinch to resize
Two-finger rotate to change orientation


Use the bottom buttons to::
Reset the placement
Take a screenshot
Add the product to your cart

Contact
Project Owner: AISVA MALAR A
Email: aishuarou656@gmail.com

Acknowledgements
AR Flutter Plugin for providing the augmented reality capabilities
Flutter team for the amazing framework



All contributors who have helped to build and improve this project
A physical device with AR capabilities
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
