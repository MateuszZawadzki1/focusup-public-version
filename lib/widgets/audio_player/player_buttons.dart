import 'package:flutter/material.dart';
import 'package:focus_up/style/color.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<bool>(
          stream: audioPlayer.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            return _shuffleButton(context, snapshot.data ?? false);
          },
        ),
        StreamBuilder<SequenceState>(
          stream: audioPlayer.sequenceStateStream,
          builder: (_, __) {
            return _previousButton();
          },
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (_, snapshot) {
            final playerState = snapshot.data;
            return _playPauseButton(playerState!);
          },
        ),
        StreamBuilder<SequenceState>(
          stream: audioPlayer.sequenceStateStream,
          builder: (_, __) {
            return _nextButton();
          },
        ),
        StreamBuilder<LoopMode>(
          stream: audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            return _repeatButton(context, snapshot.data ?? LoopMode.off);
          },
        ),
      ],
    );
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await audioPlayer.shuffle();
        }
        await audioPlayer.setShuffleModeEnabled(enable);
      },
      icon:
          isEnabled
              ? Icon(Icons.shuffle, color: secondaryColor)
              : Icon(Icons.shuffle),
    );
  }

  Widget _previousButton() {
    return IconButton(
      onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
      icon: Icon(Icons.skip_previous),
    );
  }

  Widget _nextButton() {
    return IconButton(
      onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
      icon: Icon(Icons.skip_next),
    );
  }

  Widget _playPauseButton(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8),
        width: 64,
        height: 64,
        child: CircularProgressIndicator(),
      );
    } else if (audioPlayer.playing != true) {
      return IconButton(
        onPressed: audioPlayer.play,
        icon: Icon(Icons.play_arrow),
        iconSize: 64,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        onPressed: audioPlayer.pause,
        icon: Icon(Icons.pause),
        iconSize: 64,
      );
    } else {
      return IconButton(
        onPressed:
            () => audioPlayer.seek(
              Duration.zero,
              index: audioPlayer.effectiveIndices.first,
            ),
        icon: Icon(Icons.replay),
        iconSize: 64,
      );
    }
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      Icon(Icons.repeat),
      Icon(Icons.repeat, color: secondaryColor),
      Icon(Icons.repeat_one, color: secondaryColor),
    ];
    const cycleModes = [LoopMode.off, LoopMode.all, LoopMode.one];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      onPressed: () {
        audioPlayer.setLoopMode(
          cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length],
        );
      },
      icon: icons[index],
    );
  }
}
