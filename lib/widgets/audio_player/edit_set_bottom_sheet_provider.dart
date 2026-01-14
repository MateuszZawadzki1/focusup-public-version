import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_cubit/cubit/ambient_cubit.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/models/custom_audio_player.dart';
import 'package:focus_up/widgets/audio_player/edit_set_bottom_sheet.dart';

class EditSetBottomSheetProvider extends StatelessWidget {
  final String name;
  final String id;
  List<CustomAudioPlayer> audioPlayers;
  EditSetBottomSheetProvider({
    super.key,
    required this.name,
    required this.id,
    required this.audioPlayers,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AmbientCubit>()..fetchAmbients(),
        ),
        BlocProvider(create: (context) => getIt<AmbientSetCubit>()),
      ],
      child: EditSetBottomSheet(name: name, id: id, audioPlayers: audioPlayers),
    );
  }
}
