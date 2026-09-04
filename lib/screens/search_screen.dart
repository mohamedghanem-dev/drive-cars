import 'package:flutter/material.dart';
import '../models/car.dart';
import '../theme/app_theme.dart';
import '../widgets/car_card.dart';

class SearchScreen extends StatefulWidget {
  final List<Car> cars;
  final Function(Car) onCarSelected;
  final Function(Car) onToggleSaveCar;

  const SearchScreen({
    super.key,
    required this.cars,
    required this.onCarSelected,
    required this.onToggleSaveCar,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSort = 'recommended'; // 'price_asc', 'price_desc', 'mileage', 'year'
  RangeValues _priceRange = const RangeValues(10000, 100000);
  String _selectedTransmission = 'All';
  String _selectedFuel = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Car> get _filteredCars {
    final list = widget.cars.where((car) {
      // Search text filter
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = car.make.toLowerCase().contains(q) ||
            car.model.toLowerCase().contains(q) ||
            car.variant.toLowerCase().contains(q) ||
            car.year.toString().contains(q);
        if (!match) return false;
      }

      // Price filter
      if (car.price < _priceRange.start || car.price > _priceRange.end) {
        return false;
      }

      // Transmission
      if (_selectedTransmission != 'All' && car.transmission != _selectedTransmission) {
        return false;
      }

      // Fuel
      if (_selectedFuel != 'All' && car.fuelType != _selectedFuel) {
        return false;
      }

      return true;
    }).toList();

    // Sort
    if (_selectedSort == 'price_asc') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (_selectedSort == 'price_desc') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (_selectedSort == 'mileage') {
      list.sort((a, b) => a.mileage.compareTo(b.mileage));
    } else if (_selectedSort == 'year') {
      list.sort((a, b) => b.year.compareTo(a.year));
    }

    return list;
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Cars',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _priceRange = const RangeValues(10000, 100000);
                            _selectedTransmission = 'All';
                            _selectedFuel = 'All';
                          });
                          setState(() {});
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price Range: \$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 10000,
                    max: 100000,
                    divisions: 18,
                    activeColor: AppTheme.primaryBlue,
                    onChanged: (values) {
                      setModalState(() => _priceRange = values);
                      setState(() => _priceRange = values);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Transmission', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['All', 'Automatic', 'Manual'].map((trans) {
                      final isSel = _selectedTransmission == trans;
                      return ChoiceChip(
                        label: Text(trans),
                        selected: isSel,
                        selectedColor: AppTheme.primaryBlue.withOpacity(0.15),
                        onSelected: (val) {
                          setModalState(() => _selectedTransmission = trans);
                          setState(() => _selectedTransmission = trans);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Fuel Type', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['All', 'Petrol', 'Hybrid', 'Electric', 'Diesel'].map((fuel) {
                      final isSel = _selectedFuel == fuel;
                      return ChoiceChip(
                        label: Text(fuel),
                        selected: isSel,
                        selectedColor: AppTheme.primaryBlue.withOpacity(0.15),
                        onSelected: (val) {
                          setModalState(() => _selectedFuel = fuel);
                          setState(() => _selectedFuel = fuel);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredCars;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        title: const Text('Explore & Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                hintText: 'Search by make, model, year (e.g. Camry, BMW)...',
              ),
            ),
          ),

          // Sort selector bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${results.length} Cars Found',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedSort,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down, color: AppTheme.primaryBlue),
                  style: const TextStyle(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'recommended', child: Text('Recommended')),
                    DropdownMenuItem(value: 'price_asc', child: Text('Price: Low to High')),
                    DropdownMenuItem(value: 'price_desc', child: Text('Price: High to Low')),
                    DropdownMenuItem(value: 'mileage', child: Text('Lowest Mileage')),
                    DropdownMenuItem(value: 'year', child: Text('Newest Year')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedSort = val);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Results list
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64, color: AppTheme.textMuted),
                        const SizedBox(height: 16),
                        const Text(
                          'No vehicles match your search',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _priceRange = const RangeValues(10000, 100000);
                              _selectedTransmission = 'All';
                              _selectedFuel = 'All';
                            });
                          },
                          child: const Text('Clear All Filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final car = results[index];
                      return CarCard(
                        car: car,
                        onTap: () => widget.onCarSelected(car),
                        onToggleSave: () => widget.onToggleSaveCar(car),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
