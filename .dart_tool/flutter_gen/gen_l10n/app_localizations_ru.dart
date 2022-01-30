


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

  @override
  String get errorRequestCancelled => 'Ошибка запрос сброшен';

  @override
  String get errorConnectionTimeout => 'Ошибка время ожидания вышло';

  @override
  String get errorReceiveTimeout => 'Ошибка время получения вышло';

  @override
  String get errorSendTimeout => 'Ошибка время оптравки вышло ';

  @override
  String get errorInternetConnection => 'Ошибка интренет подключения';

  @override
  String get errorBadRequest => 'Ошибка плохой запрос ';

  @override
  String get errorRequestNotFound => 'Ошибка запрос не найден';

  @override
  String get errorIntenalServer => 'Ошибка интернет сервера';

  @override
  String get errorSomethingWentWrong => 'Ошибка что-то пошло не так ';
}
