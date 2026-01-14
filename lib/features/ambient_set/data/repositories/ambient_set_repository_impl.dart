import 'dart:developer';

import 'package:dart_either/src/dart_either.dart';
import 'package:focus_up/features/ambient_set/data/data_source/ambient_set_service.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/data/models/set_image.dart';
import 'package:focus_up/features/ambient_set/data/repositories/ambient_set_repository.dart';

class AmbientSetRepositoryImpl implements AmbientSetRepository {
  final AmbientSetService ambientSetService;

  AmbientSetRepositoryImpl({required this.ambientSetService});

  @override
  Future<Either<String, void>> addAmbientSet(AmbientSet ambientSet) async {
    try {
      await ambientSetService.addAmbientSets(ambientSet);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AmbientSet>>> fetchAmbientSets() async {
    try {
      final ambientsSets = await ambientSetService.fetchAmbientSets();
      return Right(ambientsSets);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AmbientSet>>> fetchFavAmbientSets() async {
    try {
      final ambientFavSets = await ambientSetService.fetchFavAmbientSets();
      return Right(ambientFavSets);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateSetName(String id, String name) async {
    try {
      await ambientSetService.updateSetName(id, name);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateSetTimestamp(String id) async {
    try {
      await ambientSetService.updateSetTimestamp(id);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SetImage>>> fetchSetImages() async {
    try {
      final setImages = await ambientSetService.fetchSetImages();
      log('SetImages: $setImages');
      return Right(setImages);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updatePlayCounter(String id) async {
    try {
      await ambientSetService.updatePlayCounter(id);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
