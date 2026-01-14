import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/models/custom_audio_player.dart';
import 'package:focus_up/style/color.dart';
import 'package:focus_up/widgets/audio_player/edit_set_bottom_sheet_provider.dart';
import 'package:just_audio/just_audio.dart';

class MusicBarList extends StatelessWidget {
  const MusicBarList({
    super.key,
    required this.audioPlayers,
    required this.setName,
    required this.setId,
  });

  final List<CustomAudioPlayer> audioPlayers;
  final String setName;
  final String setId;

  Stream<int> getSecondsFromCurrentMinute() async* {
    final now = DateTime.now();
    final seconds = now.second;
    yield seconds;
    await Future.delayed(Duration(seconds: 1 - seconds));
    yield* getSecondsFromCurrentMinute();
  }

  @override
  Widget build(BuildContext context) {
    final audioHandler = getIt<AudioHandler>();

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return EditSetBottomSheetProvider(
              name: setName,
              audioPlayers: audioPlayers,
              id: setId,
            );
          },
        );
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: FractionallySizedBox(
          heightFactor: .15,
          widthFactor: 0.95,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            //color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      context.read<MusicCubit>().state.image,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<MusicCubit, MusicState>(
                        builder: (context, state) {
                          return Text(
                            state.setName,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: primaryColor),
                          );
                        },
                      ),
                      // Text(
                      //   "Unknown artist",
                      //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      //     color: Colors.grey.withValues(alpha: 0.6),
                      //   ),
                      // ),
                    ],
                  ),

                  // Padding between first 2 columns and Icons
                  Expanded(child: SizedBox.expand()),

                  StreamBuilder<PlaybackState>(
                    stream: audioHandler.playbackState,
                    builder: (context, snapshot) {
                      final isPlaying = snapshot.data?.playing ?? false;
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 8,
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: IconButton(
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: primaryColor,
                                    size: 36,
                                  ),
                                  onPressed: () {
                                    if (isPlaying) {
                                      audioHandler.pause();
                                    } else {
                                      audioHandler.play();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
