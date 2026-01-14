import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_cubit/cubit/ambient_cubit.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/presentation/widgets/choose_set_image_bs.dart';
import 'package:focus_up/l10n/l10n_helper.dart';
import 'package:focus_up/models/custom_audio_player.dart';

import 'package:focus_up/style/color.dart';
import 'package:focus_up/features/ambient/presentation/widgets/ambient_grid.dart';
import 'package:focus_up/widgets/scaffold_with_music_bar.dart';
import 'package:just_audio/just_audio.dart';

class SetScreen extends StatefulWidget {
  const SetScreen({super.key});

  @override
  State<SetScreen> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  String? newSetImage;
  bool makedSet = false;
  final List<Ambient> ambients = []; // List for ambient set contructor
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Ambient> selectedAmbients = [];
  final List<String> urls = [];
  final List<CustomAudioPlayer> players = [];

  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _handleItemTap(Ambient ambient) {
    setState(() {
      if (!selectedAmbients.contains(ambient)) {
        selectedAmbients.add(ambient);
        log('Selected Ambients: ${selectedAmbients.toString()}');
      }
    });
  }

  void _makeSet(List<Ambient> selectedAmbients) {
    setState(() {
      log('SelectedAmbients w makeset: $selectedAmbients');

      for (var ambient in selectedAmbients) {
        urls.add(ambient.url);
      }

      for (var url in urls) {
        players.add(CustomAudioPlayer(url));
      }

      log('url $urls');
      log('players $players');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithMusicBar(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final selectedImage = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ChooseSetImageBS();
                          },
                        );
                        if (selectedImage != null) {
                          setState(() {
                            newSetImage = selectedImage;
                          });
                        }
                      },
                      //TODO: Wywalic force
                      child: Image(
                        image:
                            newSetImage == null
                                ? AssetImage('assets/placeholder300x300.png')
                                    as ImageProvider
                                : NetworkImage(newSetImage!),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: context.l10n.name,
                            ),
                          ),
                          //Text('Name'),
                          Text(context.l10n.nameYourSet),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: dividerColor,
                  height: 50,
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),

                BlocBuilder<AmbientCubit, AmbientState>(
                  builder: (context, state) {
                    if (state is AmbientLoading) {
                      return Center(child: const CircularProgressIndicator());
                    } else if (state is AmbientLoaded) {
                      final ambientsList = state.ambients;
                      log(ambientsList.toString());
                      return Expanded(
                        //height: 150,
                        child: AmbientGrid(
                          ambientsList: ambientsList,
                          onItemTap: _handleItemTap,
                        ),
                      );
                    } else if (state is AmbientError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    _makeSet(selectedAmbients);
                    final ambientSet = AmbientSet.database(
                      name: nameController.text,
                      ambients:
                          selectedAmbients.map((e) => e.toFirestore()).toList(),
                      image: newSetImage.toString(),

                      timestamp: Timestamp.fromDate(DateTime.now()),
                      tags:
                          selectedAmbients
                              .map((e) => e.category)
                              .toSet() // Delete duplicates (expect unique list)
                              .toList(),
                    );
                    context.read<AmbientSetCubit>().addAmbientSet(ambientSet);
                    setState(() {
                      makedSet = true;
                      log('urls: //  |||  players: ');
                    });
                  },
                  child: Text(
                    context.l10n.makeSet,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
