import 'package:flutter/material.dart';
import '../models/car.dart';
import '../theme/app_theme.dart';
import '../widgets/car_card.dart';

class SavedCarsScreen extends StatelessWidget {
  final List<Car> cars;
  final Function(Car) onCarSelected;
  final Function(Car) onToggleSaveCar;
  final VoidCallback onExploreCars;

  const SavedCarsScreen({
    super.key,
    required this.cars,
    required this.onCarSelected,
    required this.onToggleSaveCar,
    required this.onExploreCars,
  });

  @override
  Widget build(BuildContext context) {
    final savedCars = cars.where((c) => c.isSaved).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        title: const Text('Saved Cars & Wishlist'),
      ),
      body: savedCars.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 64, color: AppTheme.textMuted),
                  const SizedBox(height: 16),
                  const Text(
                    'No saved vehicles yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the heart icon on any car to track price drops',
                    style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onExploreCars,
                    child: const Text('Explore Cars'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: savedCars.length,
              itemBuilder: (context, index) {
                final car = savedCars[index];
                return CarCard(
                  car: car,
                  onTap: () => onCarSelected(car),
                  onToggleSave: () => onToggleSaveCar(car),
                );
              },
            ),
    );
  }
}
