import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluxo_caixa/app/modules/create_user/models/user_model.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'create_user_controller.g.dart';

@Injectable()
class CreateUserController = _CreateUserControllerBase
    with _$CreateUserController;

abstract class _CreateUserControllerBase with Store {

  AuthController auth = Modular.get();

  @action
  Future loginWithFirebase(email, password) async {
    try {
      await auth.loginEmailPassword(email, password);
      Modular.to.pushReplacementNamed('/createMoney');
    }
    on FirebaseAuthException catch(e) {
      print(e.code);
    }
    catch(e) {
      print(e.code); 
    }
  }
}
