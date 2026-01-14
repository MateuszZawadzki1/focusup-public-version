import 'package:flutter/material.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';

class FavSetItem extends StatelessWidget {
  const FavSetItem({super.key, required this.set, required this.onTap});

  final AmbientSet set;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(set.image),
              fit: BoxFit.cover,
            ),
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              set.name,
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
