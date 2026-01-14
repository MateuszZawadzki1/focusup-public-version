import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/post_cubit/cubit/post_cubit.dart';
import 'package:focus_up/screens/screens.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AmbientSetCubit>()..fetchFavAmbientSets(),
        ),
        BlocProvider(create: (context) => getIt<PostCubit>()..fetchPosts()),
      ],
      child: HomeScreen(),
    );
  }
}
