import 'package:flutter/material.dart';
import 'package:focus_up/l10n/l10n_helper.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.legalAndPolicies)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [Text(context.l10n.privacyPolicyContent)]),
      ),
    );
  }
}
