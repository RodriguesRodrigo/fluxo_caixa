import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';
import 'package:fluxo_caixa/app/modules/home/repositories/firestore_repository_interface.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';

class FirestoreRepository implements IFirestoreRepository {

  final FirebaseFirestore firestore;

  FirestoreRepository(this.firestore);

  @override
  Stream<List<CashFlowModel>> getCashFlow(AuthController auth) {
    return firestore.collection('cash_flux')
      .where('userUid', isEqualTo: auth.user.uid)
      .orderBy('paymentDate', descending: true)
      .snapshots().map((query) {
      return query.docs.map((doc) {
        return CashFlowModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Stream<List<MoneyTransactionModel>> getMoney(AuthController auth) {
    return firestore.collection('money_transaction')
      .where('userUid', isEqualTo: auth.user.uid)
      .snapshots().map((query) {
      return query.docs.map((doc) {
        return MoneyTransactionModel.fromDocument(doc);
      }).toList();
    });
  }
}
