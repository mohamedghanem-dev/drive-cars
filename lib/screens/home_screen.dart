import 'package:flutter/material.dart';
import '../models/car.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_selector.dart';
import '../widgets/car_card.dart';
import '../widgets/category_chips.dart';

class HomeScreen extends StatefulWidget {
  final List<Car> cars;
  final UserProfile user;
  final int unreadNotificationsCount;
  final Function(Car) onCarSelected;
  final Function(Car) onToggleSaveCar;
  final VoidCallback onOpenNotifications;
  final VoidCallback onOpenSearch;
  final VoidCallback onOpenSellWizard;

  const HomeScreen({
    super.key,
    required this.cars,
    required this.user,
    required this.unreadNotificationsCount,
    required this.onCarSelected,
    required this.onToggleSaveCar,
    required this.onOpenNotifications,
    required this.onOpenSearch,
    required this.onOpenSellWizard,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMode = 'buy'; // 'buy' or 'rent'
  String _selectedCategory = 'All';
  String _selectedBrand = 'All';

  List<Car> get _filteredCars {
    return widget.cars.where((car) {
      if (_selectedMode == 'rent' && car.rentPriceDaily == null) {
        return false;
      }
      if (_selectedBrand != 'All' && car.make.toLowerCase() != _selectedBrand.toLowerCase()) {
        return false;
      }
      if (_selectedCategory != 'All') {
        final cat = _selectedCategory.toLowerCase();
        final match = car.bodyType.toLowerCase() == cat ||
            (cat == 'luxury' && car.price > 40000) ||
            (cat == 'sports' && car.variant.toLowerCase().contains('sport'));
        if (!match) return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final featuredCars = widget.cars.where((c) => c.isFeatured).toList();
    final recentCars = _filteredCars;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFFE2E8F0),
                      backgroundImage: widget.user.avatarImageProvider(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.location_on, size: 14, color: AppTheme.primaryBlue),
                              SizedBox(width: 4),
                              Text(
                                'Dubai, United Arab Emirates',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Welcome, ${widget.user.name.split(' ').first}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Notification Button with Badge
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none_outlined, size: 26),
                          color: AppTheme.textPrimary,
                          onPressed: widget.onOpenNotifications,
                        ),
                        if (widget.unreadNotificationsCount > 0)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppTheme.dangerRed,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${widget.unreadNotificationsCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search Bar Trigger
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: InkWell(
                  onTap: widget.onOpenSearch,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: AppTheme.textSecondary),
                        SizedBox(width: 12),
                        Text(
                          'Search make, model, or year...',
                          style: TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.tune, color: AppTheme.primaryBlue, size: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // Mode Tabs: Buy vs Rent
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _selectedMode = 'buy'),
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedMode == 'buy' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: _selectedMode == 'buy'
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                'Buy Cars',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: _selectedMode == 'buy'
                                      ? AppTheme.primaryBlue
                                      : AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _selectedMode = 'rent'),
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedMode == 'rent' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: _selectedMode == 'rent'
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                'Rent Cars',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: _selectedMode == 'rent'
                                      ? AppTheme.primaryBlue
                                      : AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories Chips
              const SizedBox(height: 8),
              CategoryChips(
                categories: const ['All', 'Sedan', 'SUV', 'Luxury', 'Sports', 'Electric'],
                selectedCategory: _selectedCategory,
                onSelect: (cat) => setState(() => _selectedCategory = cat),
              ),

              // Brands
              const SizedBox(height: 12),
              BrandSelector(
                brands: const [
                  'All',
                  'Toyota',
                  'BMW',
                  'Mercedes-Benz',
                  'Land Rover',
                  'Audi',
                  'Hyundai'
                ],
                selectedBrand: _selectedBrand,
                onSelect: (brand) => setState(() => _selectedBrand = brand),
              ),

              // Sell Banner Promo
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: InkWell(
                  onTap: widget.onOpenSellWizard,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'INSTANT CASH OFFERS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Want to Sell Your Car?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Get certified dealer valuation in 2 minutes',
                                style: TextStyle(
                                  color: Color(0xFFBFDBFE),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Featured Section
              if (featuredCars.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured Vehicles',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        '${featuredCars.length} Available',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: featuredCars.length,
                    itemBuilder: (context, index) {
                      final car = featuredCars[index];
                      return CarCard(
                        car: car,
                        isHorizontal: true,
                        onTap: () => widget.onCarSelected(car),
                        onToggleSave: () => widget.onToggleSaveCar(car),
                      );
                    },
                  ),
                ),
              ],

              // All / Filtered Listings
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedMode == 'buy' ? 'Cars for Sale' : 'Available for Rent',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      '${recentCars.length} results',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              if (recentCars.isEmpty)
                Container(
                  padding: const EdgeInsets.all(32),
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Icon(Icons.directions_car_outlined, size: 48, color: AppTheme.textMuted),
                      SizedBox(height: 12),
                      Text(
                        'No cars match this filter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recentCars.length,
                    itemBuilder: (context, index) {
                      final car = recentCars[index];
                      return CarCard(
                        car: car,
                        onTap: () => widget.onCarSelected(car),
                        onToggleSave: () => widget.onToggleSaveCar(car),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
