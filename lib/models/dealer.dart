class Dealer {
  final String id;
  final String name;
  final String type;
  final double rating;
  final int reviewsCount;
  final String avatar;
  final String phone;
  final String responseTime;
  final bool isVerified;

  const Dealer({
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    required this.reviewsCount,
    required this.avatar,
    required this.phone,
    required this.responseTime,
    this.isVerified = true,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      avatar: json['avatar'] as String,
      phone: json['phone'] as String,
      responseTime: json['responseTime'] as String,
      isVerified: json['isVerified'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'avatar': avatar,
      'phone': phone,
      'responseTime': responseTime,
      'isVerified': isVerified,
    };
  }
}
