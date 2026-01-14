import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';
import 'package:focus_up/features/ambient/data/repositories/ambient_repository.dart';
import 'package:meta/meta.dart';

part 'ambient_state.dart';

class AmbientCubit extends Cubit<AmbientState> {
  final AmbientRepository ambientRepository;
  AmbientCubit({required this.ambientRepository}) : super(AmbientInitial());

  Future<void> fetchAmbients() async {
    emit(AmbientLoading());

    final ambients = await ambientRepository.fetchAmbients();

    ambients.fold(
      ifLeft: (fail) => emit(AmbientError(fail.toString())),
      ifRight: (ambients) => emit(AmbientLoaded(ambients)),
    );
  }
}
