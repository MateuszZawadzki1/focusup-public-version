import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/data/models/set_image.dart';
import 'package:focus_up/features/ambient_set/data/repositories/ambient_set_repository.dart';
import 'package:meta/meta.dart';

part 'ambient_set_state.dart';

class AmbientSetCubit extends Cubit<AmbientSetState> {
  final AmbientSetRepository ambientSetRepository;
  AmbientSetCubit({required this.ambientSetRepository})
    : super(AmbientSetInitial());

  Future<void> fetchAmbientSets() async {
    emit(AmbientSetLoading());

    final ambientSets = await ambientSetRepository.fetchAmbientSets();

    ambientSets.fold(
      ifLeft: (fail) => emit(AmbientSetError(fail)),
      ifRight: (ambientSets) => emit(AmbientSetLoaded(ambientSets)),
    );
  }

  Future<void> addAmbientSet(AmbientSet ambientSet) async {
    emit(AmbientSetLoading());

    final result = await ambientSetRepository.addAmbientSet(ambientSet);

    result.fold(
      ifLeft: (fail) => emit(AmbientSetError(fail)),
      ifRight: (_) async {
        fetchAmbientSets();
      },
    );
  }

  Future<void> fetchFavAmbientSets() async {
    emit(AmbientSetLoading());

    final favAmbientSets = await ambientSetRepository.fetchFavAmbientSets();

    favAmbientSets.fold(
      ifLeft: (fail) => emit(AmbientSetError(fail)),
      ifRight: (ambientFavSets) => emit(AmbientSetLoaded(ambientFavSets)),
    );
  }

  Future<void> updateSetName(String id, String name) async {
    emit(AmbientSetLoading());

    final newName = await ambientSetRepository.updateSetName(id, name);

    newName.fold(
      ifLeft: (fail) => emit(AmbientSetError(fail)),
      ifRight: (_) {
        fetchAmbientSets();
      },
    );
  }

  Future<void> updateSetTimestamp(String id) async {
    emit(AmbientSetLoading());

    final newTimestamp = await ambientSetRepository.updateSetTimestamp(id);

    newTimestamp.fold(
      ifLeft: (fail) => emit(AmbientSetError(fail)),
      ifRight: (_) {
        fetchAmbientSets();
      },
    );
  }

  Future<void> fetchSetImages() async {
    emit(AmbientSetLoading());

    final images = await ambientSetRepository.fetchSetImages();
    images.fold(
      ifLeft: (fail) {
        log('Ambient Images Error: $fail');
        emit(AmbientSetError(fail));
      },
      ifRight: (images) => emit(AmbientImagesLoaded(images)),
    );
  }

  Future<void> updatePlayCounter(String id) async {
    emit(AmbientSetLoading());

    final count = await ambientSetRepository.updatePlayCounter(id);
    count.fold(
      ifLeft: (fail) => emit(AmbientSetError(fail)),
      ifRight: (_) {
        fetchAmbientSets();
      },
    );
  }
}
