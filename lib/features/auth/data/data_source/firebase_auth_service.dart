import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthService({required this.firebaseAuth});

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final createUser = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return createUser;
  }

  Future<UserCredential> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final loginUser = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return loginUser;
  }

  Future<void> singOut() async {
    await firebaseAuth.signOut();
  }

  User? get currentUser => firebaseAuth.currentUser;
}
