import 'package:dart_either/src/dart_either.dart';
import 'package:focus_up/features/stats/data/data_source/listen_history_service.dart';
import 'package:focus_up/features/stats/data/models/listening_history_model.dart';
import 'package:focus_up/features/stats/data/repositories/listen_history_repository.dart';
import 'package:focus_up/features/stats/domain/models/listening_history.dart';

class ListeningHistoryRepositoryImpl implements ListeningHistoryRepository {
  final ListeningHistoryService listeningHistoryService;

  ListeningHistoryRepositoryImpl({required this.listeningHistoryService});

  @override
  Future<Either<String, void>> addListeningHistory(
    ListeningHistoryModel listeningHistory,
  ) async {
    try {
      await listeningHistoryService.addListeningHistory(listeningHistory);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ListeningHistory>>> fetchListeningHistory() async {
    try {
      final data = await listeningHistoryService.fetchListeningHistory();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
