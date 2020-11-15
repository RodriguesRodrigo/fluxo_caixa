import 'create_user_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'create_user_page.dart';

class CreateUserModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CreateUserController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => CreateUserPage()),
      ];

  static Inject get to => Inject<CreateUserModule>.of();
}
