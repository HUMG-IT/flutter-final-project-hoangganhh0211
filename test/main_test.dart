import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/user.dart';

void main() {
  group('User Model', () {
    test('toJson and fromJson should be consistent', () {
      final user = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        passwordHash: 'hash',
        createdAt: DateTime.parse('2025-12-12T00:00:00.000'),
        updatedAt: DateTime.parse('2025-12-12T00:00:00.000'),
        avatarUrl: 'http://example.com/avatar.png',
      );
      final json = user.toJson();
      final fromJson = User.fromJson(json);
      expect(fromJson.id, user.id);
      expect(fromJson.name, user.name);
      expect(fromJson.email, user.email);
      expect(fromJson.passwordHash, user.passwordHash);
      expect(fromJson.createdAt, user.createdAt);
      expect(fromJson.updatedAt, user.updatedAt);
      expect(fromJson.avatarUrl, user.avatarUrl);
    });

    test('copyWith should override fields', () {
      final user = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        passwordHash: 'hash',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final updated = user.copyWith(name: 'New Name', email: 'new@example.com');
      expect(updated.name, 'New Name');
      expect(updated.email, 'new@example.com');
      expect(updated.id, user.id);
    });
  });
}
