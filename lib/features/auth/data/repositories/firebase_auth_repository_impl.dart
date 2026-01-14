import 'package:dart_either/src/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_up/features/auth/data/data_source/firebase_auth_service.dart';
import 'package:focus_up/features/auth/data/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthService firebaseAuthService;

  FirebaseAuthRepositoryImpl({required this.firebaseAuthService});

  @override
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final createUser = await firebaseAuthService
          .createUserWithEmailAndPassword(email, password);
      return Right(createUser);
    } on FirebaseAuthException catch (errorAuth) {
      return Left(errorAuth.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  //TODO: Zrobic switch-case do AuthException
  @override
  Future<Either<String, UserCredential>> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final loginUser = await firebaseAuthService.loginUserWithEmailAndPassword(
        email,
        password,
      );
      return Right(loginUser);
    } on FirebaseAuthException catch (errorAuth) {
      return Left(errorAuth.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await firebaseAuthService.singOut();
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, User?>> getCurrentUser() async {
    try {
      final currentUser = firebaseAuthService.currentUser;
      return Right(currentUser);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
