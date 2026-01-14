import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_up/features/auth/data/repositories/firebase_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthRepository firebaseAuthRepository;
  AuthCubit({required this.firebaseAuthRepository}) : super(AuthInitial());

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLoading());

    final createUser = await firebaseAuthRepository
        .createUserWithEmailAndPassword(email, password);

    createUser.fold(
      ifLeft: (fail) {
        if (!isClosed) emit(AuthError(message: fail));
      },
      ifRight: (credential) {
        if (!isClosed) emit(AuthLoaded(user: credential.user!));
      },
    );
  }

  Future<void> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLoading());

    final loginUser = await firebaseAuthRepository
        .loginUserWithEmailAndPassword(email, password);

    loginUser.fold(
      ifLeft: (fail) {
        if (!isClosed) emit(AuthError(message: fail));
      },
      ifRight: (credential) {
        if (!isClosed) emit(AuthLoaded(user: credential.user!));
      },
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    final logout = await firebaseAuthRepository.signOut();
    logout.fold(
      ifLeft: (fail) => emit(AuthError(message: fail)),
      ifRight: (_) => emit(AuthLogout()),
    );
  }

  Future<void> checkAuthStatus() async {
    final user = await firebaseAuthRepository.getCurrentUser();

    user.fold(
      ifLeft: (fail) => emit(AuthError(message: fail)),
      ifRight: (user) {
        if (user != null) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }
}
