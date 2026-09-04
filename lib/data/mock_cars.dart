import '../models/car.dart';
import '../models/dealer.dart';
import '../models/message.dart';
import '../models/notification_item.dart';
import '../models/user_profile.dart';

class MockData {
  static final Dealer dealerAhmed = Dealer(
    id: 'dealer-1',
    name: 'Ahmed Motors',
    type: 'Authorized Dealer',
    rating: 4.9,
    reviewsCount: 128,
    avatar: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=256&q=80',
    phone: '+971 50 123 4567',
    responseTime: 'within 15 mins',
    isVerified: true,
  );

  static final Dealer dealerRoyal = Dealer(
    id: 'dealer-2',
    name: 'Royal Auto Spa & Sales',
    type: 'Luxury Showroom',
    rating: 4.8,
    reviewsCount: 94,
    avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=256&q=80',
    phone: '+971 52 987 6543',
    responseTime: 'within 5 mins',
    isVerified: true,
  );

  static final Dealer dealerEmirates = Dealer(
    id: 'dealer-3',
    name: 'Emirates Pre-Owned',
    type: 'Verified Seller',
    rating: 4.7,
    reviewsCount: 210,
    avatar: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=256&q=80',
    phone: '+971 55 456 7890',
    responseTime: 'within 30 mins',
    isVerified: true,
  );

  static List<Car> getInitialCars() {
    return [
      Car(
        id: 'car-1',
        make: 'Toyota',
        model: 'Camry',
        year: 2019,
        variant: 'XLE V6 Premium',
        price: 18500,
        rentPriceDaily: 45,
        mileage: 45000,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        engineSize: '2.5L 4-Cyl',
        bodyType: 'Sedan',
        condition: 'Excellent',
        location: 'Downtown, Dubai',
        isSaved: true,
        isFeatured: true,
        views: 342,
        status: 'Active',
        images: [
          'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1590362891991-f776e747a588?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1200&q=80',
        ],
        description:
            'Very clean car, single owner from new, accident-free guarantee with complete service history records at Al-Futtaim. Tinted ceramic windows, new Yokohama tires, and immaculate leather interior.',
        features: [
          'Sunroof',
          'Apple CarPlay / Android Auto',
          'Reverse Camera & 360 Sensors',
          'Keyless Push Start',
          'Adaptive Cruise Control',
          'Dual Zone Climate Control',
          'Lane Departure Warning',
          'Blind Spot Monitor',
        ],
        dealer: dealerAhmed,
      ),
      Car(
        id: 'car-2',
        make: 'BMW',
        model: '3 Series',
        year: 2021,
        variant: '330i M Sport',
        price: 34000,
        rentPriceDaily: 85,
        mileage: 28000,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        engineSize: '2.0L Turbo',
        bodyType: 'Sedan',
        condition: 'Excellent',
        location: 'Business Bay, Dubai',
        isSaved: false,
        isFeatured: true,
        views: 520,
        status: 'Active',
        images: [
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1580273916550-e323be2ae537?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1617814076367-b759c7d7e738?auto=format&fit=crop&w=1200&q=80',
        ],
        description:
            'Aggressive M-Sport aerodynamics package, Harman Kardon surround audio, full digital live cockpit, ambient interior illumination with 64 colors.',
        features: [
          'M Sport Package',
          'Harman Kardon Audio',
          'Head-Up Display',
          'Heated Sport Seats',
          'Wireless Phone Charger',
          'Parking Assistant Plus',
        ],
        dealer: dealerRoyal,
      ),
      Car(
        id: 'car-3',
        make: 'Mercedes-Benz',
        model: 'C-Class',
        year: 2022,
        variant: 'C200 AMG Line',
        price: 42500,
        rentPriceDaily: 95,
        mileage: 19500,
        transmission: 'Automatic',
        fuelType: 'Hybrid',
        engineSize: '1.5L Turbo Mild-Hybrid',
        bodyType: 'Sedan',
        condition: 'Excellent',
        location: 'Dubai Marina',
        isSaved: true,
        isFeatured: true,
        views: 410,
        status: 'Active',
        images: [
          'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1617788138017-80ad40651399?auto=format&fit=crop&w=1200&q=80',
        ],
        description:
            'Latest generation Mercedes C-Class with portrait high-res infotainment, Burmester 3D Sound, panoramic dual glass roof, and panoramic driver display.',
        features: [
          'AMG Aerodynamics',
          'Panoramic Sunroof',
          'Burmester 3D Sound',
          '360 Camera',
          'Ambient Lighting',
        ],
        dealer: dealerRoyal,
      ),
      Car(
        id: 'car-4',
        make: 'Land Rover',
        model: 'Defender',
        year: 2023,
        variant: '110 P400 SE',
        price: 78000,
        rentPriceDaily: 160,
        mileage: 12000,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        engineSize: '3.0L i6 Turbo MHEV',
        bodyType: 'SUV',
        condition: 'Excellent',
        location: 'Al Quoz, Dubai',
        isSaved: false,
        isFeatured: true,
        views: 680,
        status: 'Active',
        images: [
          'https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1609521263047-f8f205293f24?auto=format&fit=crop&w=1200&q=80',
        ],
        description:
            'Unstoppable off-road capability matched with executive luxury. Air suspension, 3D surround camera, Terrain Response 2 with Wade program.',
        features: [
          'Adaptive Air Suspension',
          'Terrain Response 2',
          'Meridian Surround Sound',
          'Tow Pack',
          'Cooled Front Seats',
        ],
        dealer: dealerEmirates,
      ),
      Car(
        id: 'car-5',
        make: 'Audi',
        model: 'A6',
        year: 2020,
        variant: '45 TFSI Quattro',
        price: 29500,
        rentPriceDaily: 70,
        mileage: 38000,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        engineSize: '2.0L TFSI',
        bodyType: 'Sedan',
        condition: 'Very Good',
        location: 'Jumeirah, Dubai',
        isSaved: false,
        isFeatured: false,
        views: 290,
        status: 'Active',
        images: [
          'https://images.unsplash.com/photo-1603584173870-7f23fdae1b7a?auto=format&fit=crop&w=1200&q=80',
        ],
        description:
            'Executive sedan with legendary Quattro all-wheel drive, dual touchscreen center stack, virtual cockpit display, and Matrix LED headlamps.',
        features: [
          'Quattro AWD',
          'Virtual Cockpit',
          'Matrix LED',
          'Valcona Leather',
        ],
        dealer: dealerAhmed,
      ),
      Car(
        id: 'car-6',
        make: 'Hyundai',
        model: 'Elantra',
        year: 2022,
        variant: 'Smart Plus 2.0',
        price: 15900,
        rentPriceDaily: 35,
        mileage: 31000,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        engineSize: '2.0L MPI',
        bodyType: 'Sedan',
        condition: 'Excellent',
        location: 'Deira, Dubai',
        isSaved: false,
        isFeatured: false,
        views: 195,
        status: 'Active',
        images: [
          'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1200&q=80',
        ],
        description:
            'Ultra economical, smooth daily commuter with modern paramatric exterior styling, great fuel economy, wireless charging and smart key entry.',
        features: [
          'Touchscreen Display',
          'Wireless Charger',
          'Eco & Sport Modes',
          'Rear AC Vents',
        ],
        dealer: dealerEmirates,
      ),
    ];
  }

  static List<String> getBrands() {
    return [
      'All',
      'Toyota',
      'BMW',
      'Mercedes-Benz',
      'Honda',
      'Hyundai',
      'Kia',
      'Land Rover',
      'Audi',
    ];
  }

  static List<String> getCategories() {
    return [
      'All',
      'Sedan',
      'SUV',
      'Luxury',
      'Sports',
      'Electric',
    ];
  }

  static List<Conversation> getInitialConversations() {
    return [
      Conversation(
        id: 'conv-1',
        participantId: 'dealer-1',
        participantName: 'Ahmed Motors',
        participantAvatar:
            'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=256&q=80',
        participantRole: 'Authorized Dealer • ⭐ 4.9',
        lastMessage: 'Sure, you are welcome to visit our showroom for a test drive at 4 PM!',
        lastMessageTime: '10:42 AM',
        unreadCount: 2,
        carId: 'car-1',
        carTitle: 'Toyota Camry 2019',
        carPrice: 18500,
        carImage:
            'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?auto=format&fit=crop&w=800&q=80',
        messages: [
          ChatMessage(
            id: 'm1',
            senderId: 'user-me',
            text: 'Hello Ahmed, is the Toyota Camry 2019 still available?',
            timestamp: '10:30 AM',
            isMe: true,
          ),
          ChatMessage(
            id: 'm2',
            senderId: 'dealer-1',
            text: 'Yes Omar! The Camry is available in pristine condition and full service history.',
            timestamp: '10:32 AM',
            isMe: false,
          ),
          ChatMessage(
            id: 'm3',
            senderId: 'user-me',
            text: 'Can I come by today afternoon for an inspection and test drive?',
            timestamp: '10:35 AM',
            isMe: true,
          ),
          ChatMessage(
            id: 'm4',
            senderId: 'dealer-1',
            text: 'Sure, you are welcome to visit our showroom for a test drive at 4 PM!',
            timestamp: '10:42 AM',
            isMe: false,
          ),
        ],
      ),
      Conversation(
        id: 'conv-2',
        participantId: 'dealer-2',
        participantName: 'Royal Auto Spa & Sales',
        participantAvatar:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=256&q=80',
        participantRole: 'Luxury Showroom • ⭐ 4.8',
        lastMessage: 'We received your offer of \$32,500. Let us discuss the final inspection.',
        lastMessageTime: 'Yesterday',
        unreadCount: 0,
        carId: 'car-2',
        carTitle: 'BMW 3 Series 2021',
        carPrice: 34000,
        carImage:
            'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=800&q=80',
        messages: [
          ChatMessage(
            id: 'm21',
            senderId: 'user-me',
            text: 'I made an offer for the BMW 330i M Sport.',
            timestamp: 'Yesterday 3:00 PM',
            isMe: true,
            offerAmount: 32500,
          ),
          ChatMessage(
            id: 'm22',
            senderId: 'dealer-2',
            text: 'We received your offer of \$32,500. Let us discuss the final inspection.',
            timestamp: 'Yesterday 3:15 PM',
            isMe: false,
          ),
        ],
      ),
    ];
  }

  static List<NotificationItem> getInitialNotifications() {
    return [
      NotificationItem(
        id: 'notif-1',
        title: 'Toyota Camry received 45 views today',
        message: 'Your listed Toyota Camry is trending in Dubai search results.',
        time: '10m ago',
        type: NotificationType.views,
        isRead: false,
        targetCarId: 'car-1',
      ),
      NotificationItem(
        id: 'notif-2',
        title: 'New message from Ahmed Motors',
        message: '“Sure, you are welcome to visit our showroom for a test drive at 4 PM!”',
        time: '35m ago',
        type: NotificationType.message,
        isRead: false,
      ),
      NotificationItem(
        id: 'notif-3',
        title: 'Your listing is now live!',
        message: 'Toyota Camry 2019 XLE is now visible to thousands of buyers.',
        time: '2h ago',
        type: NotificationType.published,
        isRead: true,
        targetCarId: 'car-1',
      ),
      NotificationItem(
        id: 'notif-4',
        title: 'Price Drop Alert',
        message: 'BMW 3 Series 2021 dropped by \$1,500 from \$35,500 to \$34,000.',
        time: '1d ago',
        type: NotificationType.priceDrop,
        isRead: true,
        targetCarId: 'car-2',
      ),
    ];
  }

  static UserProfile getInitialUser() {
    return UserProfile(
      id: 'user-me',
      name: 'Omar Farooq',
      email: 'omar.farooq@example.com',
      phone: '+971 50 888 9900',
      avatar:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=256&q=80',
      joinedDate: 'Member since Jan 2023',
      rating: 5.0,
    );
  }
}
