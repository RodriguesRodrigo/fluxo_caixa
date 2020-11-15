import 'package:fluxo_caixa/app/modules/create_user/models/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'create_user_controller.g.dart';

@Injectable()
class CreateUserController = _CreateUserControllerBase
    with _$CreateUserController;

abstract class _CreateUserControllerBase with Store {
}
