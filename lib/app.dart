import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:focus_up/cubits/bottom_nav_cubit/bottom_nav_cubit_cubit.dart';
import 'package:focus_up/features/auth/presentation/pages/login_view.dart';
import 'package:focus_up/features/auth/presentation/pages/singup_view.dart';

import 'package:focus_up/l10n/app_localizations.dart';
import 'package:focus_up/widgets/main_wrapper.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      debugShowCheckedModeBanner: false,
      routerConfig: _buildRouter(context),
    );
  }

  GoRouter _buildRouter(BuildContext context) {
    // Obserwacja stanu zalogowania uzytkownika
    final notifier = ValueNotifier<User?>(null);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifier.value = user;
    });
    return GoRouter(
      refreshListenable: notifier,
      redirect: (context, state) async {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null &&
            state.fullPath != '/login' &&
            state.fullPath != '/signup') {
          return '/login';
        }

        if (user != null) {
          log('Przejscie do main/home');
          return '/main';
        }
        log('fullPath: ${state.fullPath}');
        log('user: $user');
        log('Wybranie nulla');
        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginView()),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SingupView(),
        ),
        GoRoute(
          path: '/main',
          builder:
              (context, state) => BlocProvider(
                create: (context) => BottomNavCubit(),
                child: const MainWrapper(),
              ),
        ),
      ],
    );
  }
}
