Food Ordering App
A Flutter app for ordering food from local restaurants, built for an internship assignment. Uses BloC architecture, SOLID principles, and includes error handling and unit tests.
Progress

Step 1 (Complete): Project setup with Flutter environment, dependencies (flutter_bloc, equatable, google_fonts, cached_network_image), and folder structure (core/, data/, domain/, presentation/). Added theme and error handling utilities.
Step 2 (Complete): Implemented data layer:
Models: Restaurant, MenuItem, CartItem, Order with equatable for immutability.
Mock repositories: RestaurantRepository, MenuRepository, OrderRepository with simulated network delays (1-2s) and random errors (10% failure rate).


Step 3 (Complete): Implemented BloC state management:
RestaurantsBloc: Loads list of restaurants with loading/error states.
MenuBloc: Loads menu items for a selected restaurant.
OrderBloc: Manages cart (add/remove items) and order placement.
Updated main.dart with MultiBlocProvider for dependency injection.


Step 4 (Complete): Implemented UI:
Screens: HomeScreen, MenuScreen, CartScreen, OrderConfirmationScreen.
Widgets: RestaurantCard, MenuItemTile, CartItemTile for consistent design.
Added Hero animations and AnimatedSwitcher for polish.


Next: Add unit tests and take screenshots for submission.

Workflow Plan

Browse restaurants (list with name, cuisine, rating, image).
View menu and add items to cart.
Review cart with subtotal and fees.
Place order with mock confirmation.
Error handling: Network failures, empty cart validation, retry options.

Setup Instructions

Clone the repo: git clone [<repo-url>](https://github.com/Amitkumarkoli/food_ordering_app.git)
Run flutter pub get
Run flutter run on an emulator or device

Screenshots
(To be added after final testing)

https://github.com/Amitkumarkoli/food_ordering_app.git