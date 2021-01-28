import 'package:flutter_teste/app/modules/home/home_controller.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teste/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
      Bind((i) => AppController()),
      Bind((i) => HomeController()),

      
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: AppModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
