import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';

class AmbientItem extends StatelessWidget {
  const AmbientItem({super.key, required this.ambient, required this.onTap});

  final Ambient ambient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(ambient.image)),
          ),
          child: Column(children: [Text(ambient.artist), Text(ambient.title)]),
        ),
      ),
    );
  }
}
