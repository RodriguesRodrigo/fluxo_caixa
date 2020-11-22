import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';

abstract class IFirestoreRepository {
  Stream<List<CashFlowModel>> getCashFlow(String userName);
  Stream<List<MoneyTransactionModel>> getMoney(String userName);
}
