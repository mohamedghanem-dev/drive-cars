import 'dealer.dart';

class Car {
  final String id;
  final String make;
  final String model;
  final int year;
  final String variant;
  final int price;
  final int? rentPriceDaily;
  final int mileage;
  final String transmission;
  final String fuelType;
  final String engineSize;
  final String bodyType;
  final String condition;
  final String location;
  final List<String> images;
  final String description;
  final List<String> features;
  final Dealer dealer;
  final int views;
  final String status; // 'Active', 'Sold', 'Draft'
  bool isSaved;
  final bool isFeatured;

  Car({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.variant,
    required this.price,
    this.rentPriceDaily,
    required this.mileage,
    required this.transmission,
    required this.fuelType,
    required this.engineSize,
    required this.bodyType,
    required this.condition,
    required this.location,
    required this.images,
    required this.description,
    required this.features,
    required this.dealer,
    this.views = 120,
    this.status = 'Active',
    this.isSaved = false,
    this.isFeatured = false,
  });

  String get title => '$make $model';
  String get fullTitle => '$make $model $year';

  Car copyWith({
    String? id,
    String? make,
    String? model,
    int? year,
    String? variant,
    int? price,
    int? rentPriceDaily,
    int? mileage,
    String? transmission,
    String? fuelType,
    String? engineSize,
    String? bodyType,
    String? condition,
    String? location,
    List<String>? images,
    String? description,
    List<String>? features,
    Dealer? dealer,
    int? views,
    String? status,
    bool? isSaved,
    bool? isFeatured,
  }) {
    return Car(
      id: id ?? this.id,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      variant: variant ?? this.variant,
      price: price ?? this.price,
      rentPriceDaily: rentPriceDaily ?? this.rentPriceDaily,
      mileage: mileage ?? this.mileage,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      engineSize: engineSize ?? this.engineSize,
      bodyType: bodyType ?? this.bodyType,
      condition: condition ?? this.condition,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      features: features ?? this.features,
      dealer: dealer ?? this.dealer,
      views: views ?? this.views,
      status: status ?? this.status,
      isSaved: isSaved ?? this.isSaved,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
