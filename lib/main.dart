import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'auth/repository/auth_repository.dart';
import 'app.dart';
import 'complex/complex.dart';

void main() async {
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
  runApp(App(
    complexRepository: ComplexRepository(),
    authRepository: AuthRepository(),
  ));
}
