import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authRepositoryProvider = Provider<AuthInterface>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

abstract class AuthInterface {
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });

  Future<UserCredential> logIn({
    required String email,
    required String password,
  });

  Future<User?> checkUser();

  Future<void> logOut();
}

class AuthRepository implements AuthInterface {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) throw Exception('User creation failed');
      print("회원가입 성공");
      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential> logIn({
    required String email,
    required String password,
  }) async {
    try {
      print("로그인 실행");
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) throw Exception('User creation failed');
      print("로그인 성공");
      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User?> checkUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user == null) throw Exception('User not found');
    return user;
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
