


import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get onHold => 'На расмотрении';

  @override
  String get inProgress => 'В процессе';

  @override
  String get needsReview => 'Необходим пересмотр';

  @override
  String get approved => 'Одобренно';
}
