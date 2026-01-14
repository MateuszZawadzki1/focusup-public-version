import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/widgets/audio_player/music_bar_list.dart';

class ScaffoldWithMusicBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithMusicBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child), // Zamiast Expanded()
        BlocBuilder<MusicCubit, MusicState>(
          builder: (context, state) {
            if (!state.isVisible || state.players.isEmpty) {
              return const SizedBox.shrink();
            }
            return Positioned(
              left: 0,
              right: 0,
              bottom: -52,
              child: MusicBarList(
                audioPlayers: state.players,
                setName: state.setName,
                setId: state.id,
              ),
            );
          },
        ),
      ],
    );
  }
}
