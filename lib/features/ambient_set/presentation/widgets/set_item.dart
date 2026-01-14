import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';

class SetItem extends StatelessWidget {
  const SetItem({super.key, required this.set, required this.onTap});

  final AmbientSet set;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(set.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 1),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(set.name, style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
