


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onHold => 'Oon hold';

  @override
  String get inProgress => 'In progress';

  @override
  String get needsReview => 'Needs review';

  @override
  String get approved => 'Approved';

  @override
  String get errorRequestCancelled => 'Error request cancelled';

  @override
  String get errorConnectionTimeout => 'Error connection timout';

  @override
  String get errorReceiveTimeout => 'Error receive timeout';

  @override
  String get errorSendTimeout => 'Error send timeout ';

  @override
  String get errorInternetConnection => 'Error internet connection';

  @override
  String get errorBadRequest => 'Error bad request ';

  @override
  String get errorRequestNotFound => 'Error request not found';

  @override
  String get errorIntenalServer => 'Error interanal server';

  @override
  String get errorSomethingWentWrong => 'Error something went wrong ';
}
