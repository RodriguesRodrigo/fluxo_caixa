import '../models/cash_flow_model.dart';

abstract class ICashFlowRepository {
  Stream<List<CashFlowModel>> getCashFlow();
}
