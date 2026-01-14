import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:focus_up/screens/settings_screen.dart';

class SettingsView extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => SettingsView());
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScreen();
  }
}
