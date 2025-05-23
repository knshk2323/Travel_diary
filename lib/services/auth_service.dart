import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  final _controller = StreamController<UserModel?>.broadcast();
  UserModel? _currentUser;
  bool _initialized = false;

  Stream<UserModel?> get authStateChanges => _controller.stream;
  UserModel? get currentUser => _currentUser;

  AuthService() {
    init();
  }

  Future<void> init() async {
    if (_initialized) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      if (userId != null) {
        _currentUser = UserModel(
          uid: userId,
          email: prefs.getString('userEmail') ?? '',
          displayName: prefs.getString('userDisplayName'),
          isGuest: prefs.getBool('isGuest') ?? false,
        );
      }
      
      _initialized = true;
      _controller.add(_currentUser);
    } catch (e) {
      print('Error initializing auth service: $e');
      _initialized = true;
      _controller.add(null);
    }
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail');
    final savedPassword = prefs.getString('userPassword');
    
    if (savedEmail == email && savedPassword == password) {
      _currentUser = UserModel(
        uid: prefs.getString('userId') ?? DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        displayName: prefs.getString('userDisplayName'),
        isGuest: false,
      );
    } else {
      throw Exception('Invalid email or password');
    }
    
    _controller.add(_currentUser);
    return _currentUser!;
  }

  Future<UserModel> registerWithEmailAndPassword(String email, String password, String displayName) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail');
    
    if (savedEmail == email) {
      throw Exception('Email already registered');
    }
    
    final user = UserModel(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      displayName: displayName,
      isGuest: false,
    );
    
    await _saveUserToPrefs(user, password);
    return user;
  }

  Future<UserModel> signInAsGuest() async {
    final user = UserModel(
      uid: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      email: 'guest@example.com',
      displayName: 'Guest',
      isGuest: true,
    );
    
    await _saveUserToPrefs(user, null);
    return user;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _currentUser = null;
    _controller.add(null);
  }

  Future<void> _saveUserToPrefs(UserModel user, String? password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.uid);
    await prefs.setString('userEmail', user.email);
    if (user.displayName != null) {
      await prefs.setString('userDisplayName', user.displayName!);
    }
    await prefs.setBool('isGuest', user.isGuest);
    if (password != null) {
      await prefs.setString('userPassword', password);
    }
    
    _currentUser = user;
    _controller.add(user);
  }

  void dispose() {
    _controller.close();
  }

  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    if (_currentUser == null) throw Exception('No user signed in');
    
    final updatedUser = UserModel(
      uid: _currentUser!.uid,
      email: _currentUser!.email,
      displayName: displayName ?? _currentUser!.displayName,
      photoUrl: photoUrl ?? _currentUser!.photoUrl,
      isGuest: _currentUser!.isGuest,
    );
    
    await _saveUserToPrefs(updatedUser, null);
  }
} 