import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/app.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:focus_up/cubits/bottom_nav_cubit/bottom_nav_cubit_cubit.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/firebase_options.dart';
import 'package:focus_up/widgets/audio_player/player_audio_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await registerMusicModule();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MusicCubit>()),
        BlocProvider(create: (_) => getIt<AuthCubit>()..checkAuthStatus()),
        //BlocProvider(create: (_) => BottomNavCubit()),
      ],
      child: MyApp(),
    ),
  );
}
