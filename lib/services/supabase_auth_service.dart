import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_project/models/user.dart' as app_models;

class SupabaseAuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<app_models.User?> getCurrentUser() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) return null;

    final response = await _supabase
        .from('users')
        .select()
        .eq('id', authUser.id)
        .maybeSingle();

    if (response == null) return null;

    return app_models.User.fromJson({
      ...response,
      'id': authUser.id,
    });
  }

  Future<app_models.User?> register(
      String name, String email, String password) async {
    final authRes = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (authRes.user == null) {
      throw Exception('Email đã được sử dụng');
    }

    final uid = authRes.user!.id;

    final newUser = app_models.User(
      id: uid,
      name: name,
      email: email,
      passwordHash: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _supabase.from('users').insert(newUser.toJson());

    return newUser;
  }

  Future<app_models.User?> login(String email, String password) async {
    final authRes = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final supaUser = authRes.user;
    if (supaUser == null) throw Exception('Email hoặc mật khẩu không đúng');

    final response = await _supabase
        .from('users')
        .select()
        .eq('id', supaUser.id)
        .maybeSingle();

    if (response == null) return null;

    return app_models.User.fromJson({
      ...response,
      'id': supaUser.id,
    });
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  Future<void> updateUser(app_models.User user) async {
    await _supabase
        .from('users')
        .update(user.toJson())
        .eq('id', user.id);
  }

  Future changePassword(String oldPassword, String newPassword) async {}
}
