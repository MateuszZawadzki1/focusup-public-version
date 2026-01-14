import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_up/models/custom_audio_player.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(const MusicState());

  void setPlayers(
    List<CustomAudioPlayer> players,
    String setName,
    String id,
    String image,
  ) {
    emit(
      state.copyWith(
        players: players,
        isVisible: true,
        setName: setName,
        id: id,
        image: image,
      ),
    );
  }

  void changeName(String name) {
    emit(state.copyWith(setName: name));
  }

  void hide() {
    emit(state.copyWith(isVisible: false));
  }

  void clear() {
    for (var player in state.players) {
      player.stop();
    }
    emit(const MusicState());
  }
}
