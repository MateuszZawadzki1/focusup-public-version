import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<String, UserCredential>> loginUserWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<String, void>> signOut();

  Future<Either<String, User?>> getCurrentUser();
}
