import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'repositories/cash_flow_repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ICashFlowRepository repository;
  AuthController auth = Modular.get();

  @observable
  ObservableStream<List<CashFlowModel>> cashFlowList;
 
  _HomeControllerBase(ICashFlowRepository this.repository) {
    getList();
  }

  @action
  getList() {
    cashFlowList = repository.getCashFlow(auth.user.email).asObservable();
  }

  @action
  logoff() async {
    await Modular.get<AuthController>().logOut();
    Modular.to.pushReplacementNamed('/login');
  }
}
