import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Android / iOS status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const DriveDealApp());
}

class DriveDealApp extends StatelessWidget {
  const DriveDealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveDeal - Buy & Rent Cars',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppFlowGate(),
    );
  }
}

enum _AppStage { checking, welcome, login, main }

/// Controls the app-level flow: Welcome (splash) -> Login -> Main App.
/// On startup it checks whether a session was already saved locally, so
/// the user isn't asked to log in again every time they reopen the app.
class AppFlowGate extends StatefulWidget {
  const AppFlowGate({super.key});

  @override
  State<AppFlowGate> createState() => _AppFlowGateState();
}

class _AppFlowGateState extends State<AppFlowGate> {
  _AppStage _stage = _AppStage.checking;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (!mounted) return;
    setState(() => _stage = loggedIn ? _AppStage.main : _AppStage.welcome);
  }

  Future<void> _handleLogout() async {
    await AuthService.logout();
    if (!mounted) return;
    setState(() => _stage = _AppStage.welcome);
  }

  @override
  Widget build(BuildContext context) {
    switch (_stage) {
      case _AppStage.checking:
        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator(color: AppTheme.accentBlue)),
        );
      case _AppStage.welcome:
        return WelcomeScreen(
          onGetStarted: () => setState(() => _stage = _AppStage.login),
          onLogin: () => setState(() => _stage = _AppStage.login),
        );
      case _AppStage.login:
        return LoginScreen(
          onAuthenticated: () => setState(() => _stage = _AppStage.main),
          onBack: () => setState(() => _stage = _AppStage.welcome),
        );
      case _AppStage.main:
        return MainNavigationScreen(onLogout: _handleLogout);
    }
  }
}
