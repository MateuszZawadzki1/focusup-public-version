import 'package:dart_either/dart_either.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';

abstract class AmbientRepository {
  Future<Either<String, List<Ambient>>> fetchAmbients();
}
