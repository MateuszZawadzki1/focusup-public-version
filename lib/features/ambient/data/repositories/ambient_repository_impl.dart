import 'package:dart_either/dart_either.dart';
import 'package:focus_up/features/ambient/data/data_source/ambient_service.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';
import 'package:focus_up/features/ambient/data/repositories/ambient_repository.dart';

class AmbientRepositoryImpl implements AmbientRepository {
  final AmbientService ambientService;

  AmbientRepositoryImpl({required this.ambientService});

  @override
  Future<Either<String, List<Ambient>>> fetchAmbients() async {
    try {
      final ambients = await ambientService.fetchAmbients();
      return Right(ambients);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
