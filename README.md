# Fashion Store - Flutter E-commerce App

A modern, feature-rich e-commerce mobile application built with Flutter and Firebase, offering a complete shopping experience with elegant UI, smooth user interactions, and secure backend integration.

## Overview

Fashion Store is a full-stack e-commerce solution combining a beautiful Flutter frontend with a robust Firebase backend. The app includes complete user authentication, product management, shopping cart, wishlist functionality, and order management capabilities.

## Features

### Core Functionality
- **Product Browsing**: Browse through a catalog of products with grid and list views
- **Product Details**: View detailed product information, images, and descriptions
- **Shopping Cart**: Add items to cart, manage quantities, and review items before checkout
- **Wishlist**: Save favorite products for later viewing
- **Search & Filter**: Search products and filter by categories
- **User Authentication**: Sign in, sign up, and password recovery with Firebase Auth
- **User Profile**: View and edit profile information
- **Order Management**: View order history and track orders
- **Checkout Process**: Complete purchases with address and payment information
- **Notifications**: Receive updates about orders and promotions

### Additional Features
- **Theme Support**: Switch between light and dark modes
- **Onboarding**: Welcome screens for first-time users
- **Help Center**: FAQ and customer support resources
- **Settings**: Customize app preferences and account settings
- **Privacy Policy & Terms of Service**: Legal information pages
- **Shipping Address Management**: Save and manage multiple delivery addresses

## Tech Stack

### Frontend
- **Framework**: Flutter
- **State Management**: GetX (Get)
- **Local Storage**: GetStorage
- **Navigation**: GetX Navigation
- **UI Components**: Custom widgets with Material Design
- **Fonts**: Google Fonts

### Backend & Services
- **Backend**: Firebase Cloud Firestore
- **Authentication**: Firebase Authentication
- **Database**: Cloud Firestore (NoSQL)
- **Storage**: Firebase Cloud Storage
- **Deployment**: Firebase Hosting

### Architecture
- **Pattern**: MVC (Model-View-Controller) with GetX
- **Controllers**: Business logic and state management
- **Models**: Data models for products, orders, addresses, etc.
- **Services**: Firebase integration layers for data operations
- **Views**: UI screens and reusable widgets

## Project Structure

```
lib/
├── controllers/              # State management & business logic
│   ├── auth_controller.dart          # Authentication logic
│   ├── cart_controller.dart          # Shopping cart state
│   ├── category_controller.dart      # Product categories
│   ├── navigation_controller.dart    # App navigation
│   ├── product_controller.dart       # Product data management
│   ├── theme_controller.dart         # Theme switching
│   └── wishlist_controller.dart      # Wishlist state
│
├── services/                 # Firebase integration & API calls
│   ├── firebase_auth_service.dart        # Firebase Auth
│   ├── firestore_service.dart            # General Firestore operations
│   ├── product_firebase_service.dart     # Product data
│   ├── cart_firestore_service.dart       # Cart operations
│   ├── category_firestore_service.dart   # Category data
│   ├── wishlist_firestore_service.dart   # Wishlist operations
│   └── firestore_data_seeder.dart        # Sample data seeding
│
├── models/                   # Data models
│   ├── product.dart              # Product data model
│   ├── cart_item.dart            # Cart item model
│   ├── category.dart             # Category model
│   └── wishlist_item.dart        # Wishlist item model
│
├── view/                     # UI screens and widgets
│   ├── splash_screen.dart              # Splash/Loading screen
│   ├── onboarding_screen.dart          # Onboarding flow
│   ├── signin_screen.dart              # Login screen
│   ├── signup_screen.dart              # Registration screen
│   ├── forgot_password_screen.dart     # Password recovery
│   ├── main_screen.dart                # Main app container
│   ├── home_screen.dart                # Home/Featured products
│   ├── shopping_screen.dart            # Product browse
│   ├── all_products_screen.dart        # All products view
│   ├── product_details_screen.dart     # Product details
│   ├── search_results_screen.dart      # Search results
│   ├── cart_screen.dart                # Shopping cart
│   ├── wishlist_screen.dart            # Saved items
│   ├── account_screen.dart             # User account
│   ├── settings_screen.dart            # App settings
│   ├── filter_bottom_sheet.dart        # Filter UI
│   │
│   ├── checkout/                       # Checkout flow
│   │   ├── screens/
│   │   │   └── checkout_screen.dart
│   │   └── widgets/
│   │       ├── address_card.dart
│   │       ├── checkout_bottom_bar.dart
│   │       ├── order_summary_card.dart
│   │       └── payment_method_card.dart
│   │
│   ├── my orders/                      # Order history
│   │   ├── model/
│   │   │   └── order.dart
│   │   ├── repository/
│   │   │   └── order_repository.dart
│   │   └── view/
│   │       ├── screens/
│   │       │   └── my_orders_screen.dart
│   │       └── widgets/
│   │           └── order_card.dart
│   │
│   ├── shipping address/               # Delivery address management
│   │   ├── models/
│   │   │   └── address.dart
│   │   ├── repositories/
│   │   │   └── address_repository.dart
│   │   ├── shipping_address_screen.dart
│   │   └── widgets/
│   │       └── address_card.dart
│   │
│   ├── notifications/                  # Notifications system
│   │   ├── models/
│   │   │   └── notification_type.dart
│   │   ├── repositories/
│   │   │   └── notification_repository.dart
│   │   ├── utils/
│   │   │   └── notification_utils.dart
│   │   └── notifications_screen.dart
│   │
│   ├── edit profile/                   # Profile management
│   │   └── views/
│   │       ├── screens/
│   │       │   └── edit_profile_screen.dart
│   │       └── widgets/
│   │           ├── profile_form.dart
│   │           └── profile_image.dart
│   │
│   ├── order confirmation/             # Order confirmation page
│   │   └── screens/
│   │       └── order_confirmation_screen.dart
│   │
│   ├── help center/                    # Customer support
│   │   └── views/
│   │       ├── screens/
│   │       │   └── help_center_screen.dart
│   │       └── widgets/
│   │           ├── category_card.dart
│   │           ├── contact_support_section.dart
│   │           ├── help_categories_section.dart
│   │           ├── popular_questions_section.dart
│   │           └── question_card.dart
│   │
│   ├── privacy policy/                 # Legal pages
│   │   └── views/
│   │       ├── screens/
│   │       │   └── privacy_policy_screen.dart
│   │       └── widgets/
│   │           └── info_section.dart
│   │
│   ├── terms of service/
│   │   └── view/
│   │       └── screens/
│   │           └── terms_of_service_screen.dart
│   │
│   └── widgets/                        # Reusable UI components
│       ├── category_chips.dart
│       ├── custom_bottom_navbar.dart
│       ├── custom_search_bar.dart
│       ├── custom_textfield.dart
│       ├── product_card.dart
│       ├── product_grid.dart
│       ├── sale_banner.dart
│       └── size_selector.dart
│
├── utils/                    # Utilities and configurations
│   ├── app_textstyles.dart        # Typography
│   ├── app_themes.dart            # Light/Dark themes
│   └── firestore_data_seeder.dart # Sample data
│
├── firebase_options.dart     # Firebase configuration
└── main.dart                 # Application entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Firebase project with Firestore database
- An emulator or physical device for testing

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/Rimi-03/e-commerce-application
cd e-commerce-application
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Configure Firebase**:
    - Create a Firebase project at [firebase.google.com](https://firebase.google.com)
    - Download your Firebase configuration files
    - Place them in the appropriate platform directories:
        - Android: `android/app/google-services.json`
        - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Initialize Firebase** (one-time setup):
```bash
flutterfire configure
```

5. **Run the app**:
```bash
flutter run
```

## Firebase Setup

### Firestore Database Structure

The app uses Cloud Firestore with the following collections:

- **users**: User profiles and authentication data
- **products**: Product catalog with details, images, and pricing
- **categories**: Product categories
- **carts**: User shopping carts
- **orders**: Order history and details
- **wishlist**: User saved items
- **addresses**: Shipping addresses
- **notifications**: App notifications

### Authentication

Firebase Authentication is configured for:
- Email/Password authentication
- Password reset functionality
- User session management

## Key Components & Architecture

### Controllers (State Management)

Each controller manages specific app state using GetX:

- **AuthController**: Handles user authentication, login, registration, and session
- **ProductController**: Manages product data fetching and filtering
- **CartController**: Handles shopping cart state and operations
- **CategoryController**: Manages product categories
- **WishlistController**: Manages wishlist items
- **NavigationController**: Controls app navigation between screens
- **ThemeController**: Handles light/dark theme switching

### Services (Backend Integration)

Services handle all Firebase operations:

- **FirebaseAuthService**: User authentication operations
- **FirestoreService**: General Firestore CRUD operations
- **ProductFirebaseService**: Product data operations
- **CartFirestoreService**: Cart management
- **WishlistFirestoreService**: Wishlist operations
- **CategoryFirestoreService**: Category management
- **FirestoreDataSeeder**: Populates sample data for testing

### Data Models

Type-safe data models for all entities:
- Product
- CartItem
- Category
- WishlistItem
- Order
- Address
- Notification

## Theme Support

The app includes comprehensive theme support:

### Light Theme
- Clean, bright color scheme
- High contrast for readability
- Professional appearance

### Dark Theme
- Dark background with light text
- Reduced eye strain in low-light environments
- Material Design dark theme compliance

Theme switching is persistent using GetStorage.

## Code Quality

### Best Practices Implemented
- **MVC Architecture**: Clear separation of concerns
- **GetX State Management**: Efficient reactive programming
- **Reusable Components**: DRY principle with custom widgets
- **Type Safety**: Dart null safety enabled
- **Error Handling**: Comprehensive try-catch blocks
- **Documentation**: Code comments for complex logic
- **Firebase Security Rules**: RLS for data protection (configured in Firestore)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.


## Dependencies

Key packages used in the project:

- `get`: State management and routing
- `get_storage`: Local data persistence
- `firebase_core`: Firebase core functionality
- `firebase_auth`: User authentication
- `cloud_firestore`: Cloud database
- `firebase_storage`: File storage
- `google_fonts`: Custom typography
- `flutter`: Core Flutter framework

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for robust backend services
- GetX for powerful state management
- All contributors and testers
- Material Design for design guidelines
- Google Fonts for typography

