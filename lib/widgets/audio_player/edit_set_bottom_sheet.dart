import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/cubits/ambient_cubit/cubit/ambient_cubit.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/music_cubit/cubit/music_cubit.dart';
import 'package:focus_up/models/custom_audio_player.dart';

/* 
  Klasa przedstawiająca edycje dla dolnego paska, pobiera liste obiektów typu
  Ambient za pomocą Cubit i prównuje je z Ambientami umieszczonymi w liscie
  audioPlayers, ktory jest parametrem konstruktora. 
*/
class EditSetBottomSheet extends StatefulWidget {
  final String name;
  final String id;
  List<CustomAudioPlayer> audioPlayers;
  EditSetBottomSheet({
    super.key,
    required this.name,
    required this.id,
    required this.audioPlayers,
  });

  @override
  State<EditSetBottomSheet> createState() => _EditSetBottomSheetState();
}

class _EditSetBottomSheetState extends State<EditSetBottomSheet> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                context.read<MusicCubit>().state.image,
                height: 150,
                width: 150,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      //controller: nameController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: widget.name,
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          log('DZIALA ONFIELDSUBMItteD');
                          log(widget.id);

                          context.read<AmbientSetCubit>().updateSetName(
                            widget.id,
                            value,
                          );
                          context.read<MusicCubit>().changeName(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            width: 200,
            child: ListView.builder(
              itemCount: widget.audioPlayers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<AmbientCubit, AmbientState>(
                        builder: (context, state) {
                          if (state is AmbientLoading) {
                            return CircularProgressIndicator();
                          } else if (state is AmbientError) {
                            return Text('Error: //${state.message}');
                          } else if (state is AmbientLoaded) {
                            final ambient = state.ambients.firstWhere(
                              (ambient) =>
                                  ambient.url == widget.audioPlayers[index].url,
                            );
                            return Image.network(ambient.image);
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.audioPlayers[index].volumeDown();
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      widget.audioPlayers[index].audioPlayer.volume
                          .toStringAsFixed(2),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.audioPlayers[index].volumeUp();
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
