import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';

abstract class ICashFlowRepository {
  Stream<List<CashFlowModel>> getCashFlow(String userName);
}
