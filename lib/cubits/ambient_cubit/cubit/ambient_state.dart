part of 'ambient_cubit.dart';

@immutable
sealed class AmbientState extends Equatable {
  const AmbientState();

  @override
  List<Object?> get props => [];
}

final class AmbientInitial extends AmbientState {}

final class AmbientLoading extends AmbientState {}

final class AmbientLoaded extends AmbientState {
  final List<Ambient> ambients;

  const AmbientLoaded(this.ambients);

  @override
  List<Object?> get props => [ambients];
}

final class AmbientError extends AmbientState {
  final String message;

  const AmbientError(this.message);

  @override
  List<Object?> get props => [message];
}
