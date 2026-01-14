import 'package:just_audio/just_audio.dart';

class CustomAudioPlayer {
  final AudioPlayer audioPlayer;
  final String url;

  CustomAudioPlayer._(this.audioPlayer, this.url);

  factory CustomAudioPlayer(String url) {
    final player = AudioPlayer();
    player.setUrl(url);
    player.setLoopMode(LoopMode.one);
    return CustomAudioPlayer._(player, url);
  }

  Future<void> play() => audioPlayer.play();
  Future<void> pause() => audioPlayer.pause();
  Future<void> stop() => audioPlayer.stop();
  Future<void> volumeUp() => audioPlayer.setVolume(audioPlayer.volume + 0.1);
  Future<void> volumeDown() => audioPlayer.setVolume(audioPlayer.volume - 0.1);
}
