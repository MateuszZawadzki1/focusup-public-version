import 'package:dart_either/src/dart_either.dart';
import 'package:focus_up/features/focus/data/data_source/focus_service.dart';
import 'package:focus_up/features/focus/data/repositories/focus_repository.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';

class FocusRepositoryImpl implements FocusRepository {
  final FocusService focusService;

  FocusRepositoryImpl({required this.focusService});

  @override
  Future<Either<String, List<FocusModel>>> fetchFocusMethods() async {
    try {
      final focusMethods = await focusService.fetchFocusMethods();
      return Right(focusMethods);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
