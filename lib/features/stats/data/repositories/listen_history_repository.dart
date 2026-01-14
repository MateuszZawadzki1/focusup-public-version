import 'package:dart_either/dart_either.dart';
import 'package:focus_up/features/stats/data/data_source/listen_history_service.dart';
import 'package:focus_up/features/stats/data/models/listening_history_model.dart';
import 'package:focus_up/features/stats/domain/models/listening_history.dart';

abstract class ListeningHistoryRepository {
  Future<Either<String, List<ListeningHistory>>> fetchListeningHistory();

  Future<Either<String, void>> addListeningHistory(
    ListeningHistoryModel listeningHistory,
  );
}
