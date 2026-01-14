import 'package:flutter/material.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';
import 'package:focus_up/features/focus/presentation/widgets/focus_item.dart';

class FocusList extends StatelessWidget {
  const FocusList({
    super.key,
    required this.focusList,
    required this.onItemTap,
  });
  final List<FocusModel> focusList;
  final Function(FocusModel) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: focusList.length,
      itemBuilder:
          (context, index) => FocusItem(
            focus: focusList[index],
            onTap: () => onItemTap(focusList[index]),
          ),
    );
  }
}
