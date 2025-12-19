# Fashion Store - Flutter E-commerce App

A modern, feature-rich e-commerce mobile application built with Flutter, offering a complete shopping experience with elegant UI and smooth user interactions.

## Features

### Core Functionality
- **Product Browsing**: Browse through a catalog of products with grid and list views
- **Product Details**: View detailed product information, images, and descriptions
- **Shopping Cart**: Add items to cart and manage quantities
- **Wishlist**: Save favorite products for later
- **Search & Filter**: Search products and filter by categories
- **User Authentication**: Sign in, sign up, and password recovery
- **User Profile**: View and edit profile information
- **Order Management**: View order history and track orders
- **Checkout Process**: Complete purchases with address and payment information
- **Notifications**: Receive updates about orders and promotions

### Additional Features
- **Theme Support**: Switch between light and dark modes
- **Onboarding**: Welcome screens for first-time users
- **Help Center**: FAQ and support resources
- **Settings**: Customize app preferences
- **Privacy Policy & Terms of Service**: Legal information pages
- **Shipping Address Management**: Save and manage multiple addresses

## Tech Stack

- **Framework**: Flutter
- **State Management**: GetX (Get)
- **Local Storage**: GetStorage
- **Navigation**: GetX Navigation
- **UI Components**: Custom widgets with Material Design

## Project Structure

```
lib/
├── controllers/           # State management controllers
│   ├── auth_controller.dart
│   ├── navigation_controller.dart
│   └── theme_controller.dart
├── models/               # Data models
│   └── product.dart
├── utils/                # Utilities and themes
│   ├── app_textstyles.dart
│   └── app_themes.dart
├── view/                 # UI screens and widgets
│   ├── account_screen.dart
│   ├── all_products_screen.dart
│   ├── cart_screen.dart
│   ├── checkout/
│   ├── edit profile/
│   ├── help center/
│   ├── home_screen.dart
│   ├── my orders/
│   ├── notifications/
│   ├── onboarding_screen.dart
│   ├── order confirmation/
│   ├── privacy policy/
│   ├── product_details_screen.dart
│   ├── settings_screen.dart
│   ├── shipping address/
│   ├── shopping_screen.dart
│   ├── signin_screen.dart
│   ├── signup_screen.dart
│   ├── splash_screen.dart
│   ├── terms of service/
│   ├── wishlist_screen.dart
│   └── widgets/          # Reusable UI components
└── main.dart            # Application entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device for testing

### Installation

1. Clone the repository:
```bash
git clone <https://github.com/Rimi-03/e-commerce-application> #(without the angle brackets)
cd fashion-store
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

The app uses the following main packages:
- `get`: State management and navigation
- `get_storage`: Local data persistence
- Custom UI components and widgets

## Screens Overview

### Authentication Flow
- **Splash Screen**: App initialization and branding
- **Onboarding**: First-time user introduction
- **Sign In / Sign Up**: User authentication
- **Forgot Password**: Password recovery

### Main Screens
- **Home**: Featured products, categories, and promotions
- **Shopping**: Browse all available products
- **Cart**: Review items and proceed to checkout
- **Wishlist**: View saved favorite products
- **Account**: User profile and app settings

### Supporting Screens
- **Product Details**: Detailed product information
- **Checkout**: Complete purchase flow
- **My Orders**: Order history and tracking
- **Notifications**: App notifications and updates
- **Help Center**: Customer support and FAQs
- **Settings**: App preferences
- **Edit Profile**: Update user information
- **Shipping Address**: Manage delivery addresses

## Key Components

### Custom Widgets
- `CustomSearchBar`: Search functionality
- `CustomTextField`: Styled text inputs
- `ProductCard`: Product display card
- `ProductGrid`: Grid layout for products
- `CategoryChips`: Category filter chips
- `SaleBanner`: Promotional banner
- `CustomBottomNavbar`: Bottom navigation
- `SizeSelector`: Product size selection

### Controllers
- **AuthController**: Manages authentication state
- **ThemeController**: Handles theme switching
- **NavigationController**: Controls app navigation

## Theme Support

The app includes both light and dark themes with custom styling:
- Dynamic theme switching
- Consistent color schemes
- Custom typography
- Material Design principles

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

- Flutter team for the amazing framework
- GetX for powerful state management
- All contributors and testers

