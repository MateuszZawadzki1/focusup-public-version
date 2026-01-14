part of 'ambient_set_cubit.dart';

@immutable
sealed class AmbientSetState extends Equatable {
  const AmbientSetState();

  @override
  List<Object?> get props => [];
}

final class AmbientSetInitial extends AmbientSetState {}

final class AmbientSetLoading extends AmbientSetState {}

final class AmbientSetLoaded extends AmbientSetState {
  final List<AmbientSet> ambientSets;

  const AmbientSetLoaded(this.ambientSets);

  @override
  List<Object?> get props => [ambientSets];
}

final class AmbientImagesLoaded extends AmbientSetState {
  final List<SetImage> setImages;

  const AmbientImagesLoaded(this.setImages);

  @override
  List<Object?> get props => [setImages];
}

final class AmbientSetError extends AmbientSetState {
  final String message;

  const AmbientSetError(this.message);

  @override
  List<Object?> get props => [message];
}
