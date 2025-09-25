Food Ordering App
A Flutter app for ordering food from local restaurants, built for an internship assignment. Uses BloC architecture, SOLID principles, and includes error handling and unit tests.
Progress

Step 1 (Complete): Project setup with Flutter environment, dependencies (flutter_bloc, equatable, google_fonts), and folder structure (core/, data/, domain/, presentation/).
Step 2 (In Progress): Implemented data models (Restaurant, MenuItem, CartItem, Order) and mock repositories with simulated delays and errors (10% failure rate).

Workflow Plan

Browse restaurants (list with name, cuisine, rating, image).
View menu and add items to cart.
Review cart with subtotal and fees.
Place order with mock confirmation.
Error handling: Network failures, empty cart validation, retry options.

Next Steps

Implement Blocs for state management.
Build UI with Material 3 and animations.

Setup Instructions

Clone the repo: git clone <repo-url>
Run flutter pub get
Run flutter run on an emulator or device
