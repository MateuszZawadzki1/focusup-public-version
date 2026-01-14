import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_up/features/stats/data/models/listening_history_model.dart';
import 'package:focus_up/features/stats/data/repositories/listen_history_repository.dart';
import 'package:focus_up/features/stats/domain/models/listening_history.dart';

part 'listening_history_state.dart';

class ListeningHistoryCubit extends Cubit<ListeningHistoryState> {
  final ListeningHistoryRepository listeningHistoryRepository;
  ListeningHistoryCubit({required this.listeningHistoryRepository})
    : super(ListeningHistoryInitial());

  Future<void> addListeningHistory(
    ListeningHistoryModel listeningHistory,
  ) async {
    emit(ListeningHistoryLoading());

    final result = await listeningHistoryRepository.addListeningHistory(
      listeningHistory,
    );

    result.fold(
      ifLeft: (fail) => emit(ListeningHistoryError(fail)),
      ifRight: (_) async {
        fetchListeningHistory;
      },
    );
  }

  Future<void> fetchListeningHistory() async {
    emit(ListeningHistoryLoading());

    final result = await listeningHistoryRepository.fetchListeningHistory();

    result.fold(
      ifLeft: (fail) => emit(ListeningHistoryError(fail)),
      ifRight: (result) => emit(ListeningHistoryLoaded(result)),
    );
  }
}
