# DriveDeal - Car Buying, Renting & Selling Flutter Application

A modern, high-fidelity Flutter & Dart mobile application designed for seamless car marketplace browsing, vehicle rental, instant dealer negotiation, and certified car listings with Material 3 design.

---

## 📱 Features

- **Material 3 Design System**: Premium Royal Blue theme (`#2563EB`), high contrast typography, curved responsive cards, and adaptive light theme.
- **Dual Mode Marketplace**: Switch seamlessly between **Buy Cars** and **Rent Cars** with live price rate calculations.
- **Advanced Search & Filtering**: Multi-parameter filtering by price range slider, transmission, fuel type, vehicle body type, and make/model search.
- **Detailed Vehicle Profiles**:
  - Full-width swipeable high-definition image gallery with pagination indicators.
  - Comprehensive 6-point technical specification grid (Mileage, Transmission, Fuel, Engine, Body Type, Year).
  - Certified dealer verification card with direct call and in-app messaging.
  - Interactive EMI / Auto Loan payment calculator with adjustable down payment and tenure sliders.
  - Expandable description and equipment badge lists.
- **Instant Offer Negotiation**: Interactive bottom sheet allowing buyers to submit custom price offers directly to authorized dealers.
- **Live In-App Messaging & Chat**: Real-time dealer chat with vehicle context banner, custom offer badge bubbles, and quick reply chips.
- **4-Step Sell Car Wizard**:
  - Step 1: Vehicle Basics (Make, Model, Year, Body Type, Trim)
  - Step 2: Specifications & Condition (Mileage, Transmission, Fuel, Condition, Location)
  - Step 3: Pricing & Rental Options (Cash price, daily rental rate toggle, detailed description)
  - Step 4: Photo review & instant marketplace certification and publishing
- **Saved Cars & Wishlist**: Real-time heart toggle with dedicated favorites screen.
- **Notifications Hub**: Interactive alerts for vehicle views, incoming dealer messages, listing activations, and price drop notifications.
- **User Garage / My Listings**: Listing management with views analytics, offers counter, and deletion controls.

---

## 🛠 Project Structure

```
├── lib/
│   ├── main.dart                      # Application entry point & MaterialApp configuration
│   ├── theme/
│   │   └── app_theme.dart             # Material 3 Theme & Color Palette
│   ├── models/
│   │   ├── car.dart                   # Vehicle data model
│   │   ├── dealer.dart                # Dealer / Seller profile model
│   │   ├── message.dart               # Chat message & Conversation model
│   │   ├── notification_item.dart     # Notifications model
│   │   └── user_profile.dart          # Authenticated user model
│   ├── data/
│   │   └── mock_cars.dart             # Rich curated dataset (Toyota, BMW, Mercedes, Land Rover, etc.)
│   ├── widgets/
│   │   ├── car_card.dart              # Responsive horizontal & vertical car cards
│   │   ├── spec_badge.dart            # Technical specification badges
│   │   ├── brand_selector.dart        # Horizontal brand filter chips
│   │   ├── category_chips.dart        # Vehicle category selectors
│   │   └── offer_bottom_sheet.dart    # Interactive negotiation sheet
│   └── screens/
│       ├── main_navigation_screen.dart# Root bottom navigation & view coordinator
│       ├── onboarding_screen.dart     # 3-step value proposition carousel
│       ├── home_screen.dart           # Primary explore & marketplace dashboard
│       ├── search_screen.dart         # Filter & search results view
│       ├── car_details_screen.dart    # Full vehicle detail & loan calculator
│       ├── sell_car_screen.dart       # 4-step car listing wizard
│       ├── my_listings_screen.dart    # User's active garage & stats
│       ├── messages_screen.dart       # Inbox conversations list
│       ├── chat_screen.dart           # Real-time chat with offer bubbles
│       ├── notifications_screen.dart  # Activity and price drop alerts
│       ├── saved_cars_screen.dart     # Saved vehicles wishlist
│       └── profile_screen.dart        # Account settings & verification
├── android/                           # Complete Android Gradle & Manifest configurations
└── pubspec.yaml                       # Flutter dependencies & asset declarations
```

---

## 🚀 Running the Project

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.0.0 or higher)
- Android Studio / VS Code with Flutter extension
- Android Emulator or physical device

### Commands
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run on connected Android device / emulator
flutter run

# 3. Build release APK
flutter build apk --release
```
