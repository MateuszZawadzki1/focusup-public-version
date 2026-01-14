part of 'music_cubit.dart';

class MusicState extends Equatable {
  final List<CustomAudioPlayer> players;
  final bool isVisible;
  final String setName;
  final String id;
  final String image;

  const MusicState({
    this.players = const [],
    this.isVisible = false,
    this.setName = '',
    this.id = '',
    this.image = '',
  });

  MusicState copyWith({
    List<CustomAudioPlayer>? players,
    bool? isVisible,
    String? setName,
    String? id,
    String? image,
  }) {
    return MusicState(
      players: players ?? this.players,
      isVisible: isVisible ?? this.isVisible,
      setName: setName ?? this.setName,
      id: id ?? this.id,
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props => [players, isVisible, setName];
}
