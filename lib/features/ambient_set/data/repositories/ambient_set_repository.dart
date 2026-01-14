import 'package:dart_either/dart_either.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/data/models/set_image.dart';

abstract class AmbientSetRepository {
  Future<Either<String, List<AmbientSet>>> fetchAmbientSets();

  Future<Either<String, void>> addAmbientSet(AmbientSet ambientSet);

  Future<Either<String, List<AmbientSet>>> fetchFavAmbientSets();

  Future<Either<String, void>> updateSetName(String id, String name);

  Future<Either<String, void>> updateSetTimestamp(String id);

  Future<Either<String, List<SetImage>>> fetchSetImages();

  Future<Either<String, void>> updatePlayCounter(String id);
}
