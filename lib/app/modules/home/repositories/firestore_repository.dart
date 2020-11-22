import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';
import 'package:fluxo_caixa/app/modules/home/repositories/firestore_repository_interface.dart';

class CashFlowRepository implements IFirestoreRepository {

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

  @override
  Stream<List<MoneyTransactionModel>> getMoney(String username) {
    return firestore.collection('money_transaction')
      .where('userName', isEqualTo: username)
      .snapshots().map((query) {
      return query.docs.map((doc) {
        return MoneyTransactionModel.fromDocument(doc);
      }).toList();
    });
  }
}
