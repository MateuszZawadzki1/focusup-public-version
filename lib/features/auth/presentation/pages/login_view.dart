import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:focus_up/features/auth/presentation/pages/login_screen.dart';

class LoginView extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
