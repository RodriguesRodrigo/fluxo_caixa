import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluxo_caixa/app/modules/home/repositories/firestore_repository.dart';
import 'package:fluxo_caixa/app/modules/home/repositories/firestore_repository_interface.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
        Bind<IFirestoreRepository>((i) => FirestoreRepository(FirebaseFirestore.instance)),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
