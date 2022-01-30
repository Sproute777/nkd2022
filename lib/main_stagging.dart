import 'dart:async';
import 'dart:developer';

import 'package:bloc_app/complex/models/item.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/app/app_bloc_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'auth/repository/auth_repository.dart';
import 'complex/repository/complex_repository.dart';

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

  var complexRepo = ComplexRepository();
  var authRepository = AuthRepository();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(
        App(complexRepository: complexRepo, authRepository: authRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
