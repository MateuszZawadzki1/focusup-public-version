import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';

class PlayerAudioHandler extends BaseAudioHandler {
  final MusicCubit musicCubit;

  PlayerAudioHandler({required this.musicCubit}) {
    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.idle,
        controls: [MediaControl.play, MediaControl.stop],
        androidCompactActionIndices: [0, 1],
      ),
    );
  }

  @override
  Future<void> play() async {
    log('UadioHandler: play() called');
    for (var player in musicCubit.state.players) {
      player.play();
    }
    playbackState.add(
      playbackState.value.copyWith(
        playing: true,
        processingState: AudioProcessingState.ready,
        controls: [MediaControl.pause, MediaControl.stop],
        androidCompactActionIndices: [0, 1],
      ),
    );
    log("AudioHandler: playbackState emitted with playing=true");
  }

  @override
  Future<void> pause() async {
    for (var player in musicCubit.state.players) {
      player.pause();
    }
    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.ready,
      ),
    );
  }

  @override
  Future<void> stop() async {
    for (var player in musicCubit.state.players) {
      player.stop();
    }
    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.idle,
      ),
    );
    await super.stop();
  }
}

Future<AudioHandler> initAudioService(MusicCubit musicCubit) async {
  return await AudioService.init(
    builder: () => PlayerAudioHandler(musicCubit: musicCubit),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.example.focus_up.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}
