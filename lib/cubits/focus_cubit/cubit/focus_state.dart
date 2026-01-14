part of 'focus_cubit.dart';

@immutable
sealed class FocusState extends Equatable {
  const FocusState();

  @override
  List<Object?> get props => [];
}

final class FocusInitial extends FocusState {}

final class FocusLoading extends FocusState {}

final class FocusLoaded extends FocusState {
  final List<FocusModel> foci;
  const FocusLoaded({required this.foci});

  @override
  List<Object?> get props => [foci];
}

final class FocusError extends FocusState {
  final String message;

  const FocusError({required this.message});

  @override
  List<Object?> get props => [message];
}
