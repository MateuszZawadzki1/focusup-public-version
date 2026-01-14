import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/cubits/post_cubit/cubit/post_cubit.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/models/custom_audio_player.dart';
import 'package:focus_up/screens/settings_view.dart';

import 'package:focus_up/style/color.dart';
import 'package:focus_up/features/ambient_set/presentation/widgets/favorite_sets_list.dart';
import 'package:focus_up/features/post/presentation/widgets/posts_list.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  bool isPlayer = false;
  List<String> urls = [];
  List<CustomAudioPlayer> players = [];

  void _handleItemTap(AmbientSet ambientSet, BuildContext context) {
    log('handleitem ${ambientSet.image}');
    context.read<AmbientSetCubit>().updateSetTimestamp(ambientSet.id!);
    context.read<AmbientSetCubit>().updatePlayCounter(ambientSet.id!);
    setState(() {
      if (isPlayer == true) {
        context.read<MusicCubit>().clear();
      }
      for (var ambient in ambientSet.ambients!) {
        urls.add(ambient['url']);
      }
      log('Url list from handleitem: $urls');
      for (var url in urls) {
        players.add(CustomAudioPlayer(url));
      }
      log('Player list from handleitem: $players');
      context.read<MusicCubit>().setPlayers(
        players,
        ambientSet.name,
        ambientSet.id!,
        ambientSet.image,
      );
      isPlayer = true;

      urls = [];
      players = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, SettingsView.route());
                    },
                    icon: Icon(Icons.settings, color: primaryColor),
                  ),
                ],
              ),
              Image.asset('assets/Logo.png'),
              Text(
                'FOCUSUP',
                style: GoogleFonts.jua(
                  fontSize: 46,
                  color: primaryColor,
                  letterSpacing: 10,
                ),
              ),
              Text(
                'RELAX, STUDY, SLEEP',
                style: TextStyle(
                  color: primaryColor,
                  wordSpacing: 10,
                  letterSpacing: 5,
                ),
              ),
              BlocBuilder<AmbientSetCubit, AmbientSetState>(
                builder: (context, state) {
                  if (state is AmbientSetLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AmbientSetLoaded) {
                    final favSets = state.ambientSets;
                    return SizedBox(
                      height: 150,
                      child: FavoriteSetsList(
                        sets: favSets,
                        onItemTap:
                            (ambientSet) => _handleItemTap(ambientSet, context),
                      ),
                    );
                  } else if (state is AmbientSetError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PostLoaded) {
                    final postsList = state.posts;
                    return Expanded(child: PostsList(posts: postsList));
                  } else if (state is PostError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
