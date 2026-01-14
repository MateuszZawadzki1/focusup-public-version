import 'package:flutter/material.dart';
import 'package:focus_up/screens/policies_screen.dart';

class PoliciesView extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => PoliciesView());
  const PoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return PoliciesScreen();
  }
}
