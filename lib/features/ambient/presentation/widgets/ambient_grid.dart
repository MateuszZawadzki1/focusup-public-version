import 'package:flutter/material.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';
import 'package:focus_up/style/color.dart';
import 'package:focus_up/features/ambient/presentation/widgets/ambient_item.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';

class AmbientGrid extends StatelessWidget {
  const AmbientGrid({
    super.key,
    required this.ambientsList,
    required this.onItemTap,
  });
  final List<Ambient> ambientsList;
  final Function(Ambient) onItemTap;

  @override
  Widget build(BuildContext context) {
    return GroupedScrollView.grid(
      data: ambientsList,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      groupedOptions: GroupedScrollViewOptions(
        stickyHeaderBuilder:
            (BuildContext context, String category, int groupedIndex) =>
                Container(
                  color: const Color.fromARGB(255, 128, 142, 164),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints.tightFor(height: 35),
                  child: Text(
                    category.isNotEmpty
                        ? '${category[0].toUpperCase()}${category.substring(1)}'
                        : category,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
        itemGrouper: (Ambient ambient) {
          return ambient.category;
        },
      ),
      itemBuilder:
          (context, Ambient item) =>
              AmbientItem(ambient: item, onTap: () => onItemTap(item)),
    );
  }
}
