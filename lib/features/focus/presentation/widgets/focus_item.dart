import 'package:flutter/material.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';
import 'package:focus_up/style/color.dart';

class FocusItem extends StatelessWidget {
  const FocusItem({super.key, required this.focus, required this.onTap});

  final FocusModel focus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 150,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: primaryColor,
        ),
        child: Row(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(255, 157, 168, 188),
                image: DecorationImage(image: AssetImage(focus.image)),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  focus.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
