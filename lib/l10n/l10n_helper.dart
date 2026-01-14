import 'package:flutter/material.dart';
import 'package:focus_up/l10n/app_localizations.dart';

extension L10nHelper on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
