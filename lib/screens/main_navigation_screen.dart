import 'package:flutter/material.dart';
import '../data/mock_cars.dart';
import '../models/car.dart';
import '../models/dealer.dart';
import '../models/message.dart';
import '../models/notification_item.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'car_details_screen.dart';
import 'chat_screen.dart';
import 'edit_profile_screen.dart';
import 'home_screen.dart';
import 'messages_screen.dart';
import 'my_listings_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'saved_cars_screen.dart';
import 'search_screen.dart';
import 'sell_car_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const MainNavigationScreen({super.key, required this.onLogout});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentTabIndex = 0;

  // Active Sub-screens
  Car? _selectedCar;
  Conversation? _selectedConversation;
  bool _showSellWizard = false;
  bool _showNotifications = false;
  bool _showMyListings = false;
  bool _showSavedCars = false;
  bool _showEditProfile = false;

  // App Global State
  late List<Car> _cars;
  late List<Conversation> _conversations;
  late List<NotificationItem> _notifications;
  late UserProfile _user;

  @override
  void initState() {
    super.initState();
    _cars = MockData.getInitialCars();
    _conversations = MockData.getInitialConversations();
    _notifications = MockData.getInitialNotifications();
    _user = MockData.getInitialUser();
    _loadSavedProfile();
  }

  Future<void> _loadSavedProfile() async {
    final overrides = await AuthService.loadProfileOverrides();
    if (!mounted || overrides.isEmpty) return;
    setState(() {
      if (overrides['name'] != null) _user.name = overrides['name']!;
      if (overrides['email'] != null) _user.email = overrides['email']!;
      if (overrides['phone'] != null) _user.phone = overrides['phone']!;
      if (overrides['avatarPath'] != null) _user.avatar = overrides['avatarPath']!;
    });
  }

  void _toggleSaveCar(Car car) {
    setState(() {
      car.isSaved = !car.isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(car.isSaved ? '${car.title} added to saved cars' : '${car.title} removed from saved cars'),
      ),
    );
  }

  void _addNewCarListing(Car newCar) {
    setState(() {
      _cars.insert(0, newCar);
      _showSellWizard = false;
      _notifications.insert(
        0,
        NotificationItem(
          id: 'notif-${DateTime.now().millisecondsSinceEpoch}',
          title: 'Listing Published Successfully!',
          message: 'Your ${newCar.title} ${newCar.year} is now live and certified.',
          time: 'Just now',
          type: NotificationType.published,
          isRead: false,
          targetCarId: newCar.id,
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newCar.title} published to DriveDeal marketplace!'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _deleteCarListing(Car car) {
    setState(() {
      _cars.removeWhere((c) => c.id == car.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${car.title} listing deleted.')),
    );
  }

  void _submitOffer(Car car, int amount, String note) {
    // Find or create conversation with dealer
    final convIndex = _conversations.indexWhere((c) => c.participantId == car.dealer.id);
    final offerMsg = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      senderId: _user.id,
      text: note.isNotEmpty ? 'I made an offer: $note' : 'I made a formal offer of \$$amount',
      timestamp: 'Just now',
      isMe: true,
      offerAmount: amount,
    );

    setState(() {
      if (convIndex >= 0) {
        _conversations[convIndex].messages.add(offerMsg);
        _conversations[convIndex].lastMessage = 'Offer of \$$amount submitted';
        _conversations[convIndex].lastMessageTime = 'Just now';
      } else {
        _conversations.insert(
          0,
          Conversation(
            id: 'conv-${DateTime.now().millisecondsSinceEpoch}',
            participantId: car.dealer.id,
            participantName: car.dealer.name,
            participantAvatar: car.dealer.avatar,
            participantRole: car.dealer.type,
            lastMessage: 'Offer of \$$amount submitted',
            lastMessageTime: 'Just now',
            carId: car.id,
            carTitle: car.fullTitle,
            carPrice: car.price,
            carImage: car.images.first,
            messages: [offerMsg],
          ),
        );
      }

      _notifications.insert(
        0,
        NotificationItem(
          id: 'notif-${DateTime.now().millisecondsSinceEpoch}',
          title: 'Offer Sent: \$${amount}',
          message: 'Your offer for ${car.title} was delivered to ${car.dealer.name}.',
          time: 'Just now',
          type: NotificationType.offer,
          isRead: false,
        ),
      );
    });
  }

  void _openChatWithDealer(Car car) {
    final existingConv = _conversations.firstWhere(
      (c) => c.participantId == car.dealer.id,
      orElse: () {
        final newConv = Conversation(
          id: 'conv-${DateTime.now().millisecondsSinceEpoch}',
          participantId: car.dealer.id,
          participantName: car.dealer.name,
          participantAvatar: car.dealer.avatar,
          participantRole: car.dealer.type,
          lastMessage: 'Started conversation',
          lastMessageTime: 'Just now',
          carId: car.id,
          carTitle: car.fullTitle,
          carPrice: car.price,
          carImage: car.images.first,
          messages: [
            ChatMessage(
              id: 'init-1',
              senderId: _user.id,
              text: 'Hi ${car.dealer.name}, I am interested in your ${car.fullTitle}.',
              timestamp: 'Just now',
              isMe: true,
            ),
          ],
        );
        _conversations.insert(0, newConv);
        return newConv;
      },
    );

    setState(() {
      _selectedCar = null;
      _selectedConversation = existingConv;
    });
  }

  int get _unreadNotificationsCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    // Modal / Overlaid Screen Routing
    if (_selectedCar != null) {
      return CarDetailsScreen(
        car: _selectedCar!,
        onBack: () => setState(() => _selectedCar = null),
        onToggleSave: () => _toggleSaveCar(_selectedCar!),
        onSubmitOffer: _submitOffer,
        onChatWithDealer: _openChatWithDealer,
      );
    }

    if (_selectedConversation != null) {
      return ChatScreen(
        conversation: _selectedConversation!,
        onBack: () => setState(() => _selectedConversation = null),
        onSendMessage: (text, offerAmount) {
          final newMsg = ChatMessage(
            id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
            senderId: _user.id,
            text: text,
            timestamp: 'Just now',
            isMe: true,
            offerAmount: offerAmount,
          );
          setState(() {
            _selectedConversation!.messages.add(newMsg);
            _selectedConversation!.lastMessage = text;
            _selectedConversation!.lastMessageTime = 'Just now';
          });
        },
      );
    }

    if (_showSellWizard) {
      return SellCarScreen(
        onCarPublished: _addNewCarListing,
        onCancel: () => setState(() => _showSellWizard = false),
      );
    }

    if (_showNotifications) {
      return NotificationsScreen(
        notifications: _notifications,
        onBack: () => setState(() => _showNotifications = false),
        onMarkAllRead: () {
          setState(() {
            for (var n in _notifications) {
              n.isRead = true;
            }
          });
        },
        onNotificationTap: (notif) {
          setState(() {
            notif.isRead = true;
            if (notif.targetCarId != null) {
              _selectedCar = _cars.firstWhere((c) => c.id == notif.targetCarId, orElse: () => _cars.first);
              _showNotifications = false;
            }
          });
        },
      );
    }

    if (_showMyListings) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => _showMyListings = false),
          ),
          title: const Text('My Garage & Listings'),
        ),
        body: MyListingsScreen(
          cars: _cars,
          onCarSelected: (car) => setState(() => _selectedCar = car),
          onToggleSaveCar: _toggleSaveCar,
          onDeleteCar: _deleteCarListing,
          onAddNewListing: () => setState(() => _showSellWizard = true),
        ),
      );
    }

    if (_showEditProfile) {
      return EditProfileScreen(
        user: _user,
        onBack: () => setState(() => _showEditProfile = false),
        onSaved: (updatedUser) {
          setState(() {
            _user = updatedUser;
            _showEditProfile = false;
          });
        },
      );
    }

    if (_showSavedCars) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => _showSavedCars = false),
          ),
          title: const Text('Saved Cars'),
        ),
        body: SavedCarsScreen(
          cars: _cars,
          onCarSelected: (car) => setState(() => _selectedCar = car),
          onToggleSaveCar: _toggleSaveCar,
          onExploreCars: () => setState(() {
            _showSavedCars = false;
            _currentTabIndex = 0;
          }),
        ),
      );
    }

    // 5 Main Tabs
    final screens = [
      HomeScreen(
        cars: _cars,
        user: _user,
        unreadNotificationsCount: _unreadNotificationsCount,
        onCarSelected: (car) => setState(() => _selectedCar = car),
        onToggleSaveCar: _toggleSaveCar,
        onOpenNotifications: () => setState(() => _showNotifications = true),
        onOpenSearch: () => setState(() => _currentTabIndex = 1),
        onOpenSellWizard: () => setState(() => _showSellWizard = true),
      ),
      SearchScreen(
        cars: _cars,
        onCarSelected: (car) => setState(() => _selectedCar = car),
        onToggleSaveCar: _toggleSaveCar,
      ),
      const SizedBox(), // Tab 2 placeholder for center "Sell" action
      MessagesScreen(
        conversations: _conversations,
        onSelectConversation: (conv) => setState(() => _selectedConversation = conv),
      ),
      ProfileScreen(
        user: _user,
        savedCarsCount: _cars.where((c) => c.isSaved).length,
        myListingsCount: _cars.where((c) => c.dealer.id == 'user-me' || c.id == 'car-1').length,
        onOpenMyListings: () => setState(() => _showMyListings = true),
        onOpenSavedCars: () => setState(() => _showSavedCars = true),
        onOpenNotifications: () => setState(() => _showNotifications = true),
        onEditProfile: () => setState(() => _showEditProfile = true),
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex == 2 ? 0 : _currentTabIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: const Color(0xFFF1F5F9))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            if (index == 2) {
              setState(() => _showSellWizard = true);
            } else {
              setState(() => _currentTabIndex = index);
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primaryBlue,
          unselectedItemColor: AppTheme.textMuted,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search, size: 26),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
              label: 'Sell',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Inbox',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
