import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/repositories/cash_flow_repository_interface.dart';

class CashFlowRepository implements ICashFlowRepository {

  final FirebaseFirestore firestore;

  CashFlowRepository(this.firestore);

  @override
  Stream<List<CashFlowModel>> getCashFlow(String userName) {
    return firestore.collection('cash_flux')
      .where('userName', isEqualTo: userName)
      .orderBy('paymentDate', descending: true)
      .snapshots().map((query) {
      return query.docs.map((doc) {
        return CashFlowModel.fromDocument(doc);
      }).toList();
    });
  }
}
