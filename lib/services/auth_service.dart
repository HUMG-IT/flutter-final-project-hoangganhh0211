import 'package:flutter_project/models/user.dart';
import 'package:localstore/localstore.dart';

class AuthService {
  final _db = Localstore.instance;
  final String _userKey = 'current_user';

  Future<void> saveUser(User user) async {
    await _db.collection('users').doc(_userKey).set(user.toJson());
  }

  Future<User?> getCurrentUser() async {
    final data = await _db.collection('users').doc(_userKey).get();
    if (data == null) return null;
    return User.fromJson(data);
  }

  Future<void> logout() async {
    await _db.collection('users').doc(_userKey).delete();
  }

  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  Future<void> updateUser(User user) async {
    final updatedUser = user.copyWith(updatedAt: DateTime.now());
    await _db.collection('users').doc(_userKey).set(updatedUser.toJson());
  }
}
