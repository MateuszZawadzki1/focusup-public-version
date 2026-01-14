import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_up/cubits/ambient_cubit/cubit/ambient_cubit.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:focus_up/cubits/focus_cubit/cubit/focus_cubit.dart';
import 'package:focus_up/cubits/listening_history_cubit/cubit/listening_history_cubit.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/cubits/post_cubit/cubit/post_cubit.dart';
import 'package:focus_up/features/ambient/data/data_source/ambient_service.dart';
import 'package:focus_up/features/ambient/data/repositories/ambient_repository.dart';
import 'package:focus_up/features/ambient/data/repositories/ambient_repository_impl.dart';
import 'package:focus_up/features/ambient_set/data/data_source/ambient_set_service.dart';
import 'package:focus_up/features/ambient_set/data/repositories/ambient_set_repository.dart';
import 'package:focus_up/features/ambient_set/data/repositories/ambient_set_repository_impl.dart';
import 'package:focus_up/features/auth/data/data_source/firebase_auth_service.dart';
import 'package:focus_up/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:focus_up/features/auth/data/repositories/firebase_auth_repository_impl.dart';
import 'package:focus_up/features/focus/data/data_source/focus_service.dart';
import 'package:focus_up/features/focus/data/repositories/focus_repository.dart';
import 'package:focus_up/features/focus/data/repositories/focus_repository_impl.dart';
import 'package:focus_up/features/post/data/data_source/post_service.dart';
import 'package:focus_up/features/post/data/repositories/post_repository.dart';
import 'package:focus_up/features/post/data/repositories/post_repository_impl.dart';
import 'package:focus_up/features/stats/data/data_source/listen_history_service.dart';
import 'package:focus_up/features/stats/data/repositories/listen_history_repository.dart';
import 'package:focus_up/features/stats/data/repositories/listening_history_repository_impl.dart';
import 'package:focus_up/widgets/audio_player/player_audio_handler.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  registerFirebaseModule();
  registerAmbientModule();
  registerAmbientSetModule();
  registerPostModule();
  registerFocusModule();
  registerAuthModule();
  //registerMusicModule();
  registerListeningHistoryModule();
}

void registerFirebaseModule() {
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}

void registerAmbientModule() {
  getIt.registerLazySingleton<AmbientService>(
    () => AmbientService(firebase: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AmbientRepository>(
    () => AmbientRepositoryImpl(ambientService: getIt<AmbientService>()),
  );
  getIt.registerFactory<AmbientCubit>(
    () => AmbientCubit(ambientRepository: getIt<AmbientRepository>()),
  );
}

void registerAmbientSetModule() {
  getIt.registerLazySingleton<AmbientSetService>(
    () => AmbientSetService(firebase: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AmbientSetRepository>(
    () =>
        AmbientSetRepositoryImpl(ambientSetService: getIt<AmbientSetService>()),
  );
  getIt.registerFactory<AmbientSetCubit>(
    () => AmbientSetCubit(ambientSetRepository: getIt<AmbientSetRepository>()),
  );
}

void registerPostModule() {
  getIt.registerLazySingleton<PostService>(
    () => PostService(firebase: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(postService: getIt<PostService>()),
  );
  getIt.registerFactory<PostCubit>(
    () => PostCubit(postRepository: getIt<PostRepository>()),
  );
}

void registerFocusModule() {
  getIt.registerLazySingleton<FocusService>(
    () => FocusService(firebase: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<FocusRepository>(
    () => FocusRepositoryImpl(focusService: getIt<FocusService>()),
  );
  getIt.registerFactory<FocusCubit>(
    () => FocusCubit(focusRepository: getIt<FocusRepository>()),
  );
}

void registerAuthModule() {
  getIt.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(firebaseAuth: getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<FirebaseAuthRepository>(
    () => FirebaseAuthRepositoryImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
    ),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(firebaseAuthRepository: getIt<FirebaseAuthRepository>()),
  );
}

Future<void> registerMusicModule() async {
  getIt.registerLazySingleton<MusicCubit>(() => MusicCubit());
  getIt.registerSingleton<AudioHandler>(
    await initAudioService(getIt<MusicCubit>()),
  );
}

void registerListeningHistoryModule() {
  getIt.registerLazySingleton<ListeningHistoryService>(
    () => ListeningHistoryService(firebase: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ListeningHistoryRepository>(
    () => ListeningHistoryRepositoryImpl(
      listeningHistoryService: getIt<ListeningHistoryService>(),
    ),
  );
  getIt.registerFactory<ListeningHistoryCubit>(
    () => ListeningHistoryCubit(
      listeningHistoryRepository: getIt<ListeningHistoryRepository>(),
    ),
  );
}
