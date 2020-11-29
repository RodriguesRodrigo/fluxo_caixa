import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';

abstract class IFirestoreRepository {
  Stream<List<CashFlowModel>> getCashFlow(AuthController auth);
  Stream<List<MoneyTransactionModel>> getMoney(AuthController auth);
}
