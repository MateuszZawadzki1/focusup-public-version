import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/listening_history_cubit/cubit/listening_history_cubit.dart';
import 'package:focus_up/screens/screens.dart';

class SetsView extends StatelessWidget {
  const SetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AmbientSetCubit>()..fetchAmbientSets(),
        ),
        BlocProvider(create: (context) => getIt<ListeningHistoryCubit>()),
      ],
      child: SetsScreen(),
    );
  }
}
