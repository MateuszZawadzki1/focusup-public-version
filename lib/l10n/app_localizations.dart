import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Focus Up'**
  String get appTitle;

  /// No description provided for @loginButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginButtonLabel;

  /// No description provided for @signupButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupButtonLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @singUp.
  ///
  /// In en, this message translates to:
  /// **'Sing Up'**
  String get singUp;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an Account? '**
  String get alreadyHaveAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @sets.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get sets;

  /// No description provided for @focus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focus;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @timeToWork.
  ///
  /// In en, this message translates to:
  /// **'Time To Work'**
  String get timeToWork;

  /// No description provided for @chooseOneOfCons.
  ///
  /// In en, this message translates to:
  /// **'Choose one of the concetration methods and see how much easier it is to work'**
  String get chooseOneOfCons;

  /// No description provided for @methodBoxBreathing.
  ///
  /// In en, this message translates to:
  /// **'Method of box breathing'**
  String get methodBoxBreathing;

  /// No description provided for @methodOrange.
  ///
  /// In en, this message translates to:
  /// **'Method of oragne'**
  String get methodOrange;

  /// No description provided for @method478.
  ///
  /// In en, this message translates to:
  /// **'Method of 4-7-8'**
  String get method478;

  /// No description provided for @yourFavoriteSet.
  ///
  /// In en, this message translates to:
  /// **'Your favorite set'**
  String get yourFavoriteSet;

  /// No description provided for @played.
  ///
  /// In en, this message translates to:
  /// **'Played'**
  String get played;

  /// No description provided for @mostPopularSet.
  ///
  /// In en, this message translates to:
  /// **'Your the most popular sets'**
  String get mostPopularSet;

  /// No description provided for @youMightLike.
  ///
  /// In en, this message translates to:
  /// **'You might like...'**
  String get youMightLike;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @nameYourSet.
  ///
  /// In en, this message translates to:
  /// **'Name your set'**
  String get nameYourSet;

  /// No description provided for @makeSet.
  ///
  /// In en, this message translates to:
  /// **'Make set'**
  String get makeSet;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @legalAndPolicies.
  ///
  /// In en, this message translates to:
  /// **'Legal and policies'**
  String get legalAndPolicies;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy of the Ambient Focus app\n\nThis privacy policy describes how personal data is processed in the \"Ambient Focus\" app. The app was created as an engineering thesis project and is not publicly available in app stores.\n\n1. Data controller\nThe data controller is Mateusz Zawadzki. Contact: matizawadzki@interia.pl.\n\n2. Scope of processed data\nThe app processes the email address, encrypted password, and data about how many times sounds or sets were played.\n\n3. Purpose of processing\nData is processed to create and maintain the user account, enable login, display listening statistics, and improve the app as part of the engineering project.\n\n4. User rights\nThe user has the right to access, correct, and delete their data. To exercise these rights, please contact the controller via email.\n\n5. Data security\nPasswords are stored in hashed/encrypted form. Only the app author has access to the data.\n\n6. Changes to this policy\nThis policy may be updated. The current version is always available in the \"Privacy Policy\" section of the app.'**
  String get privacyPolicyContent;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
