import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_up/features/focus/data/repositories/focus_repository.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';
import 'package:meta/meta.dart';

part 'focus_state.dart';

class FocusCubit extends Cubit<FocusState> {
  final FocusRepository focusRepository;
  FocusCubit({required this.focusRepository}) : super(FocusInitial());

  Future<void> fetchFocusMethods() async {
    emit(FocusLoading());

    final foci = await focusRepository.fetchFocusMethods();

    foci.fold(
      ifLeft: (fail) => emit(FocusError(message: fail)),
      ifRight: (foci) => emit(FocusLoaded(foci: foci)),
    );
  }
}
