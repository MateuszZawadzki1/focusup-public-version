import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_cubit_state.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  changeSelectedIndex(newIndex) => emit(newIndex);
}
