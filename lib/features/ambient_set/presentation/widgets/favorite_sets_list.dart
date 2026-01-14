import 'package:flutter/material.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/presentation/widgets/fav_set_item.dart';

class FavoriteSetsList extends StatelessWidget {
  const FavoriteSetsList({
    super.key,
    required this.sets,
    required this.onItemTap,
  });

  final List<AmbientSet> sets;
  final void Function(AmbientSet) onItemTap;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.all(8),
        itemCount: sets.length,

        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return FavSetItem(
            set: sets[index],
            onTap: () => onItemTap(sets[index]),
          );
        },
      ),
    );
  }
}
