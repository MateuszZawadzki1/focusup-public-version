import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioPlayer.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = audioPlayer.duration ?? Duration.zero;
        return Slider(
          min: 0,
          max: duration.inMilliseconds.toDouble(),
          value:
              position.inMilliseconds
                  .clamp(0, duration.inMilliseconds)
                  .toDouble(),
          onChanged: (value) {
            audioPlayer.seek(Duration(milliseconds: value.round()));
          },
        );
      },
    );
  }
}
