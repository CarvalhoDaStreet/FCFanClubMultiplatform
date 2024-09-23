import 'package:fc_fan_club/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<bool> isSignedIn();
  Future<User?> signInWithEmail(String email, String password);
  Future<User?> signInWithGoogle();
  Future<User?> signInWithApple();
  Future<User?> signUp(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}
