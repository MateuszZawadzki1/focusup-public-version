import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';

class ChooseSetImageBS extends StatelessWidget {
  const ChooseSetImageBS({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AmbientSetCubit>()..fetchSetImages(),
      child: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AmbientSetCubit, AmbientSetState>(
              builder: (context, state) {
                log('state z BS: ${state.toString()}');
                if (state is AmbientSetLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AmbientImagesLoaded) {
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children:
                          state.setImages
                              .map(
                                (e) => GestureDetector(
                                  onTap:
                                      () => Navigator.of(
                                        context,
                                      ).pop(e.originalUrl),
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.network(e.thumbUrl),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  );
                } else if (state is AmbientSetError) {
                  return Text('Error: ${state.message}');
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
