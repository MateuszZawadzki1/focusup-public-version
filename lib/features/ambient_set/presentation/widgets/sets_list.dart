import 'package:flutter/material.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/presentation/widgets/set_item.dart';

class SetsList extends StatelessWidget {
  const SetsList({super.key, required this.sets, required this.onItemTap});

  final List<AmbientSet> sets;
  final Function(AmbientSet) onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: sets.length,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          //alignment: Alignment.center,
          child: SetItem(set: sets[index], onTap: () => onItemTap(sets[index])),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
