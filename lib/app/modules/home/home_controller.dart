import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'repositories/firestore_repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IFirestoreRepository firestoreRepository;

  @observable
  ObservableStream<List<CashFlowModel>> cashFlowList;
 
  @observable
  ObservableStream<List<MoneyTransactionModel>> moneyTransactionList;
 
  _HomeControllerBase(IFirestoreRepository this.firestoreRepository) {
    getList();
  }

  @action
  getList() {
    cashFlowList = firestoreRepository.getCashFlow(Modular.get<AuthController>()).asObservable();
    moneyTransactionList = firestoreRepository.getMoney(Modular.get<AuthController>()).asObservable();
  }

  @action
  logoff() async {
    await Modular.get<AuthController>().logOut();
    Modular.to.pushReplacementNamed('/login');
  }

  createCashFlow(CashFlowModel modelCashFlow, MoneyTransactionModel modelMoney) async {
    int money = 0;
    int account = int.parse(modelMoney.value);
    int price = int.parse(modelCashFlow.value);

    money = modelCashFlow.type.toLowerCase() == 'entrada' ?
        account + price : account - price;

    modelMoney.value = money.toString();
    modelMoney.save();

    modelCashFlow.save();
  }

  updateCashFlow(CashFlowModel modelCashFlow, MoneyTransactionModel modelMoney) async {
    int money = 0;
    int account = int.parse(modelMoney.value);
    int price = int.parse(modelCashFlow.value);
    int oldPrice = int.parse(modelCashFlow.valueCached);

    account = modelCashFlow.type.toLowerCase() == 'entrada' ?
      account - oldPrice : account + oldPrice;

    money = modelCashFlow.type.toLowerCase() == 'entrada' ?
        account + price : account - price;

    modelMoney.value = money.toString();
    modelMoney.save();

    modelCashFlow.save();
  }

  deleteCashFlow(CashFlowModel modelCashFlow, MoneyTransactionModel modelMoney) async {
    int money = 0;
    int account = int.parse(modelMoney.value);
    int price = int.parse(modelCashFlow.value);

    money = modelCashFlow.type.toLowerCase() == 'entrada' ?
        account - price : account + price;

    modelMoney.value = money.toString();
    modelMoney.save();

    modelCashFlow.save();
  }
}
