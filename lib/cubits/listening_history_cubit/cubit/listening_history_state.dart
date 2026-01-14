part of 'listening_history_cubit.dart';

sealed class ListeningHistoryState extends Equatable {
  const ListeningHistoryState();

  @override
  List<Object?> get props => [];
}

final class ListeningHistoryInitial extends ListeningHistoryState {}

final class ListeningHistoryLoading extends ListeningHistoryState {}

final class ListeningHistoryLoaded extends ListeningHistoryState {
  final List<ListeningHistory> listeningHistory;
  const ListeningHistoryLoaded(this.listeningHistory);

  @override
  List<Object?> get props => [listeningHistory];
}

final class ListeningHistoryError extends ListeningHistoryState {
  final String message;
  const ListeningHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
