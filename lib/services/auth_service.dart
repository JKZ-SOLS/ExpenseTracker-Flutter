import 'package:shared_preferences/shared_preferences.dart';

enum UserRole {
  basic,
  premium,
  admin
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserRole _userRole = UserRole.basic;
  String? _userId;
  bool _isAuthenticated = false;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _isAuthenticated = _userId != null;
    _userRole = _getUserRole(prefs.getString('userRole'));
  }


  UserRole _getUserRole(String? role) {
    switch(role) {
      case 'premium': return UserRole.premium;
      case 'admin': return UserRole.admin;
      default: return UserRole.basic;
    }
  }

  bool get isAuthenticated => _isAuthenticated;
  UserRole get userRole => _userRole;

  Future<void> login(String userId, String userRole) async {
    _isAuthenticated = true;
    _userId = userId;
    _userRole = _getUserRole(userRole);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('userRole', userRole);

  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userId = null;
    _userRole = UserRole.basic;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userRole');
  }

  void setRole(UserRole role) {
    _userRole = role;
  }
}