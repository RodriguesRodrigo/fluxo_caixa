import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/repositories/cash_flow_repository_interface.dart';

class CashFlowRepository implements ICashFlowRepository {

  final FirebaseFirestore firebase;
  
  CashFlowRepository(this.firebase);

  @override
  Stream<List<CashFlowModel>> getCashFlow() {
    return firebase.collection('cash_flux').snapshots().map((query) {
      return query.docs.map((doc) {
        return CashFlowModel.fromDocument(doc);
      }).toList();
    });
  }
}
