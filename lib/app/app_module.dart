import 'package:fluxo_caixa/app/modules/create_user/create_user_module.dart';
import 'package:fluxo_caixa/app/modules/login/login_module.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';
import 'package:fluxo_caixa/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:fluxo_caixa/app/shared/auth/repositories/auth_repository.dart';
import 'package:fluxo_caixa/app/splash/splash_page.dart';
import 'package:fluxo_caixa/app/start/start_page.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:fluxo_caixa/app/app_widget.dart';
import 'package:fluxo_caixa/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        // $AppController,
        Bind((i) => AppController),
        Bind<IAuthRepository>((i) => AuthRepository()),        
        Bind((i) => AuthController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => SplashPage()),
        ModularRouter('/start', child: (_, args) => StartPage()),
        ModularRouter(
          '/login',
          module: LoginModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter('/createUser', module: CreateUserModule()),
        ModularRouter('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
