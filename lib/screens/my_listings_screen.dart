import 'package:flutter/material.dart';
import '../models/car.dart';
import '../theme/app_theme.dart';
import '../widgets/car_card.dart';

class MyListingsScreen extends StatelessWidget {
  final List<Car> cars;
  final Function(Car) onCarSelected;
  final Function(Car) onToggleSaveCar;
  final Function(Car) onDeleteCar;
  final VoidCallback onAddNewListing;

  const MyListingsScreen({
    super.key,
    required this.cars,
    required this.onCarSelected,
    required this.onToggleSaveCar,
    required this.onDeleteCar,
    required this.onAddNewListing,
  });

  @override
  Widget build(BuildContext context) {
    // Filter to user-owned cars
    final myListings = cars.where((c) => c.dealer.id == 'user-me' || c.id == 'car-1').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        title: const Text('My Garage & Listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppTheme.primaryBlue),
            onPressed: onAddNewListing,
          ),
        ],
      ),
      body: myListings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.garage_outlined, size: 64, color: AppTheme.textMuted),
                  const SizedBox(height: 16),
                  const Text(
                    'No active listings yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'List your car for sale or rent in 2 minutes',
                    style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: onAddNewListing,
                    icon: const Icon(Icons.add),
                    label: const Text('Post New Listing'),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Quick Stats Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Total Listings', '${myListings.length}', AppTheme.primaryBlue),
                      Container(height: 40, width: 1, color: const Color(0xFFE2E8F0)),
                      _buildStatColumn('Total Views', '462', AppTheme.successGreen),
                      Container(height: 40, width: 1, color: const Color(0xFFE2E8F0)),
                      _buildStatColumn('Offers Recv', '5', AppTheme.warningOrange),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Active Listings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 12),
                ...myListings.map((car) {
                  return Stack(
                    children: [
                      CarCard(
                        car: car,
                        onTap: () => onCarSelected(car),
                        onToggleSave: () => onToggleSaveCar(car),
                      ),
                      Positioned(
                        top: 12,
                        right: 54,
                        child: Material(
                          color: Colors.white.withOpacity(0.9),
                          shape: const CircleBorder(),
                          child: IconButton(
                            icon: const Icon(Icons.delete_outline, color: AppTheme.dangerRed, size: 20),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Listing?'),
                                  content: Text('Are you sure you want to delete ${car.title}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        onDeleteCar(car);
                                      },
                                      child: const Text('Delete', style: TextStyle(color: AppTheme.dangerRed)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
