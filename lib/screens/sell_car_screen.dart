import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/car.dart';
import '../models/dealer.dart';
import '../theme/app_theme.dart';

class SellCarScreen extends StatefulWidget {
  final Function(Car) onCarPublished;
  final VoidCallback onCancel;

  const SellCarScreen({
    super.key,
    required this.onCarPublished,
    required this.onCancel,
  });

  @override
  State<SellCarScreen> createState() => _SellCarScreenState();
}

class _SellCarScreenState extends State<SellCarScreen> {
  int _currentStep = 1;

  // Step 1: Basic Info
  String _make = 'Toyota';
  final TextEditingController _modelController = TextEditingController(text: 'Camry');
  int _year = 2021;
  String _bodyType = 'Sedan';
  final TextEditingController _variantController = TextEditingController(text: 'SE Sport');

  // Step 2: Specs & Condition
  final TextEditingController _mileageController = TextEditingController(text: '35000');
  String _transmission = 'Automatic';
  String _fuelType = 'Petrol';
  String _engineSize = '2.5L 4-Cylinder';
  String _condition = 'Excellent';
  final TextEditingController _locationController = TextEditingController(text: 'Dubai Marina, UAE');

  // Step 3: Pricing & Details
  final TextEditingController _priceController = TextEditingController(text: '22500');
  final TextEditingController _rentPriceController = TextEditingController(text: '50');
  bool _allowRent = true;
  final TextEditingController _descriptionController = TextEditingController(
    text: 'Immaculate condition car with low mileage and agency warranty remaining.',
  );
  final List<String> _selectedFeatures = ['Sunroof', 'Reverse Camera', 'Apple CarPlay'];

  // Step 4: Photos
  final List<String> _photos = [
    'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1590362891991-f776e747a588?auto=format&fit=crop&w=1200&q=80',
  ];

  @override
  void dispose() {
    _modelController.dispose();
    _variantController.dispose();
    _mileageController.dispose();
    _priceController.dispose();
    _rentPriceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _publishCar() {
    final price = int.tryParse(_priceController.text) ?? 20000;
    final mileage = int.tryParse(_mileageController.text) ?? 30000;
    final rentPrice = _allowRent ? int.tryParse(_rentPriceController.text) : null;

    final newCar = Car(
      id: 'car-${DateTime.now().millisecondsSinceEpoch}',
      make: _make,
      model: _modelController.text.isNotEmpty ? _modelController.text : 'Model',
      year: _year,
      variant: _variantController.text.isNotEmpty ? _variantController.text : 'Standard',
      price: price,
      rentPriceDaily: rentPrice,
      mileage: mileage,
      transmission: _transmission,
      fuelType: _fuelType,
      engineSize: _engineSize,
      bodyType: _bodyType,
      condition: _condition,
      location: _locationController.text.isNotEmpty ? _locationController.text : 'Dubai, UAE',
      images: _photos.isNotEmpty
          ? _photos
          : [
              'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1200&q=80'
            ],
      description: _descriptionController.text,
      features: _selectedFeatures,
      views: 0,
      status: 'Active',
      dealer: const Dealer(
        id: 'user-me',
        name: 'Omar Farooq (Owner)',
        type: 'Private Seller',
        rating: 5.0,
        reviewsCount: 1,
        avatar:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=256&q=80',
        phone: '+971 50 888 9900',
        responseTime: 'within 5 mins',
        isVerified: true,
      ),
    );

    widget.onCarPublished(newCar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        title: const Text('Sell / List Your Car'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onCancel,
        ),
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Step $_currentStep of 4',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    Text(
                      _getStepTitle(_currentStep),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _currentStep / 4,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),

          // Step Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: _buildCurrentStepContent(),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: const Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                if (_currentStep > 1)
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 1) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 4) {
                        setState(() => _currentStep++);
                      } else {
                        _publishCar();
                      }
                    },
                    child: Text(_currentStep == 4 ? 'Publish Listing Now' : 'Continue to Next Step'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 1:
        return 'Vehicle Basics';
      case 2:
        return 'Specifications';
      case 3:
        return 'Pricing & Features';
      case 4:
        return 'Photos & Review';
      default:
        return '';
    }
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildStep1Basics();
      case 2:
        return _buildStep2Specs();
      case 3:
        return _buildStep3Pricing();
      case 4:
        return _buildStep4Review();
      default:
        return const SizedBox();
    }
  }

  Widget _buildStep1Basics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Vehicle Brand (Make)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _make,
          decoration: const InputDecoration(),
          items: ['Toyota', 'BMW', 'Mercedes-Benz', 'Land Rover', 'Audi', 'Hyundai', 'Honda', 'Porsche']
              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
              .toList(),
          onChanged: (v) => setState(() => _make = v ?? 'Toyota'),
        ),
        const SizedBox(height: 16),
        const Text('Model Name', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(controller: _modelController, decoration: const InputDecoration(hintText: 'e.g. Camry, 3 Series')),
        const SizedBox(height: 16),
        const Text('Model Year', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: _year,
          decoration: const InputDecoration(),
          items: List.generate(15, (i) => 2025 - i)
              .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
              .toList(),
          onChanged: (v) => setState(() => _year = v ?? 2021),
        ),
        const SizedBox(height: 16),
        const Text('Body Type', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _bodyType,
          decoration: const InputDecoration(),
          items: ['Sedan', 'SUV', 'Coupe', 'Hatchback', 'Convertible']
              .map((b) => DropdownMenuItem(value: b, child: Text(b)))
              .toList(),
          onChanged: (v) => setState(() => _bodyType = v ?? 'Sedan'),
        ),
        const SizedBox(height: 16),
        const Text('Trim / Variant (Optional)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(controller: _variantController, decoration: const InputDecoration(hintText: 'e.g. XLE V6 Premium')),
      ],
    );
  }

  Widget _buildStep2Specs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mileage (km)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _mileageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 45000'),
        ),
        const SizedBox(height: 16),
        const Text('Transmission', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _transmission,
          decoration: const InputDecoration(),
          items: ['Automatic', 'Manual', 'Dual-Clutch']
              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              .toList(),
          onChanged: (v) => setState(() => _transmission = v ?? 'Automatic'),
        ),
        const SizedBox(height: 16),
        const Text('Fuel Type', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _fuelType,
          decoration: const InputDecoration(),
          items: ['Petrol', 'Hybrid', 'Electric', 'Diesel']
              .map((f) => DropdownMenuItem(value: f, child: Text(f)))
              .toList(),
          onChanged: (v) => setState(() => _fuelType = v ?? 'Petrol'),
        ),
        const SizedBox(height: 16),
        const Text('Overall Condition', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _condition,
          decoration: const InputDecoration(),
          items: ['Brand New', 'Excellent', 'Very Good', 'Good']
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (v) => setState(() => _condition = v ?? 'Excellent'),
        ),
        const SizedBox(height: 16),
        const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(controller: _locationController, decoration: const InputDecoration(hintText: 'e.g. Dubai Marina, UAE')),
      ],
    );
  }

  Widget _buildStep3Pricing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selling Cash Price (USD)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(prefixText: '\$ ', hintText: '25000'),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Also Offer for Daily Rent?'),
          subtitle: const Text('Allow verified users to book daily rentals'),
          value: _allowRent,
          activeColor: AppTheme.primaryBlue,
          onChanged: (val) => setState(() => _allowRent = val),
        ),
        if (_allowRent) ...[
          const SizedBox(height: 8),
          const Text('Daily Rent Rate (USD / day)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _rentPriceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(prefixText: '\$ ', hintText: '50'),
          ),
        ],
        const SizedBox(height: 16),
        const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Describe vehicle condition, service history...'),
        ),
      ],
    );
  }

  Widget _buildStep4Review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: _photos.first,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(height: 160, color: const Color(0xFFE2E8F0)),
                  errorWidget: (context, url, error) => Container(height: 160, color: const Color(0xFFE2E8F0)),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '$_make ${_modelController.text} $_year',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Price: \$${_priceController.text} • ${_mileageController.text} km',
                style: const TextStyle(fontSize: 14, color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _descriptionController.text,
                style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFA7F3D0)),
          ),
          child: Row(
            children: const [
              Icon(Icons.check_circle, color: AppTheme.successGreen),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your listing will be instantly certified and published to thousands of verified buyers in the UAE.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF065F46), fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
