import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/listening_history_cubit/cubit/listening_history_cubit.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/stats/data/models/listening_history_model.dart';
import 'package:focus_up/models/custom_audio_player.dart';

import 'package:focus_up/style/color.dart';
import 'package:focus_up/features/ambient_set/presentation/widgets/sets_list.dart';

class SetsScreen extends StatefulWidget {
  const SetsScreen({super.key});

  @override
  State<SetsScreen> createState() => _SetsScreenState();
}

class _SetsScreenState extends State<SetsScreen> {
  bool isPlayer = false;
  List<String> urls = [];
  List<CustomAudioPlayer> players = [];

  void _handleItemTap(AmbientSet ambientSet, BuildContext context) {
    log('handleitem ${ambientSet.image}');

    context.read<AmbientSetCubit>().updateSetTimestamp(ambientSet.id!);
    context.read<AmbientSetCubit>().updatePlayCounter(ambientSet.id!);
    context.read<ListeningHistoryCubit>().addListeningHistory(
      ListeningHistoryModel(
        ambientSetId: ambientSet.id!,
        tags: ambientSet.tags,
      ),
    );
    setState(() {
      if (isPlayer == true) {
        log('isPlayer true, czyszcze cubit');
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
      log(ambientSet.id!);
      context.read<MusicCubit>().setPlayers(
        players,
        ambientSet.name,
        ambientSet.id!,
        ambientSet.image,
      );
      log('Zmieniam isPLayer na true');
      isPlayer = true;

      // Clearing, last update without check
      urls = [];
      players = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Image.asset('assets/Logo.png', scale: 1.5),
            Expanded(
              child: BlocBuilder<AmbientSetCubit, AmbientSetState>(
                builder: (context, state) {
                  if (state is AmbientSetLoaded) {
                    final ambientsSets = state.ambientSets;
                    log(ambientsSets.toString());
                    return SetsList(
                      sets: ambientsSets,
                      onItemTap:
                          (ambientSet) => _handleItemTap(ambientSet, context),
                    );
                  } else if (state is AmbientSetError) {
                    return Center(child: Text(state.message));
                  } else if (state is AmbientSetLoading) {
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
