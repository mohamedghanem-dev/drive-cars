import 'package:shared_preferences/shared_preferences.dart';

/// Handles persisting the user's login session and basic profile
/// overrides locally, so closing and reopening the app doesn't sign
/// the user out.
class AuthService {
  static const _kLoggedInKey = 'drivedeal.isLoggedIn';
  static const _kNameKey = 'drivedeal.profile.name';
  static const _kEmailKey = 'drivedeal.profile.email';
  static const _kPhoneKey = 'drivedeal.profile.phone';
  static const _kAvatarPathKey = 'drivedeal.profile.avatarPath';

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedInKey, value);
  }

  /// Clears the session flag. Saved profile edits are intentionally kept
  /// so the user's info is still there next time they log back in.
  static Future<void> logout() async {
    await setLoggedIn(false);
  }

  static Future<void> saveProfileOverrides({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null && name.isNotEmpty) await prefs.setString(_kNameKey, name);
    if (email != null && email.isNotEmpty) await prefs.setString(_kEmailKey, email);
    if (phone != null && phone.isNotEmpty) await prefs.setString(_kPhoneKey, phone);
    if (avatarPath != null && avatarPath.isNotEmpty) await prefs.setString(_kAvatarPathKey, avatarPath);
  }

  /// Returns a map of any saved profile overrides (only the keys that
  /// were previously saved will be present).
  static Future<Map<String, String>> loadProfileOverrides() async {
    final prefs = await SharedPreferences.getInstance();
    final result = <String, String>{};
    final name = prefs.getString(_kNameKey);
    final email = prefs.getString(_kEmailKey);
    final phone = prefs.getString(_kPhoneKey);
    final avatarPath = prefs.getString(_kAvatarPathKey);
    if (name != null) result['name'] = name;
    if (email != null) result['email'] = email;
    if (phone != null) result['phone'] = phone;
    if (avatarPath != null) result['avatarPath'] = avatarPath;
    return result;
  }
}
