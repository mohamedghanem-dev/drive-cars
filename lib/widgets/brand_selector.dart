import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BrandSelector extends StatelessWidget {
  final List<String> brands;
  final String selectedBrand;
  final ValueChanged<String> onSelect;

  const BrandSelector({
    super.key,
    required this.brands,
    required this.selectedBrand,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: brands.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = brand == selectedBrand;
          return InkWell(
            onTap: () => onSelect(brand),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryBlue : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryBlue : const Color(0xFFE2E8F0),
                ),
              ),
              child: Center(
                child: Text(
                  brand,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
