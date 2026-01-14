import 'package:dart_either/dart_either.dart';
import 'package:focus_up/features/focus/data/data_source/focus_service.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';

abstract class FocusRepository {
  Future<Either<String, List<FocusModel>>> fetchFocusMethods();
}
