import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/focus_cubit/cubit/focus_cubit.dart';
import 'package:focus_up/cubits/post_cubit/cubit/post_cubit.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';
import 'package:focus_up/l10n/l10n_helper.dart';

import 'package:focus_up/style/color.dart';
import 'package:focus_up/features/focus/presentation/widgets/focus_list.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() {
    return _FocusScreen();
  }
}

class _FocusScreen extends State<FocusScreen> {
  @override
  Widget build(BuildContext context) {
    void _handleItemTap(FocusModel focusModel) {
      _dialogBuilder(context, focusModel.title, focusModel.description);
    }

    return BlocProvider(
      create: (context) => getIt<FocusCubit>()..fetchFocusMethods(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Text(
                  context.l10n.timeToWork,
                  style: TextStyle(color: primaryColor, fontSize: 24),
                ),
                SizedBox(height: 5),
                Text(
                  context.l10n.chooseOneOfCons,
                  style: TextStyle(color: primaryColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: BlocBuilder<FocusCubit, FocusState>(
                      builder: (context, state) {
                        if (state is PostLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FocusLoaded) {
                          final focusList = state.foci;
                          return FocusList(
                            focusList: focusList,
                            onItemTap: _handleItemTap,
                          );
                        } else if (state is FocusError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
    BuildContext context,
    String title,
    String description,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(dialogContext).size.width * 0.95,
            height: MediaQuery.of(dialogContext).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(title, style: TextStyle(fontSize: 34)),
                Text(description),
              ],
            ),
          ),
        );
      },
    );
  }
}
