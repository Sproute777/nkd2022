import 'dart:async';
import 'dart:developer';

import 'package:bloc_app/data/repository/auth_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'data/repository/complex_repository.dart';
import 'models/item/item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  Hive
    ..registerAdapter(ItemRowAdapter())
    ..registerAdapter(ItemAdapter());
  await Hive.openBox('api_box');
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final complexRepo = ComplexRepository();
  final authRepository = AuthRepository();

  runZonedGuarded(
    () => runApp(
        App(complexRepository: complexRepo, authRepository: authRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );

  // BlocOverrides.runZoned(
  // () => runApp(
  //       App(
  //         complexRepository: ComplexRepository(),
  //         authRepository: AuthRepository(),
  //       ),
  //     ),
  // blocObserver: AppBlocObserver());
}
