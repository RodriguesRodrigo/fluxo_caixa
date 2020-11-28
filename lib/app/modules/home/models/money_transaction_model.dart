import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';

class MoneyTransactionModel {

  AuthController auth = Modular.get();

  String userUid;
  String value;
  DocumentReference reference;

  MoneyTransactionModel({
    this.userUid = '',
    this.value = '',
    this.reference
  });

  factory MoneyTransactionModel.fromDocument(DocumentSnapshot doc) {
    return MoneyTransactionModel(
      userUid: doc['userUid'],
      value: doc['value'],
      reference: doc.reference
    );
  }

  Future save() async {
    userUid = auth.user.uid.toString();

    if (reference == null) {
      reference = await FirebaseFirestore.instance
        .collection('money_transaction')
        .add({
          'userUid': userUid,
          'value': value,
        });
    }
    else {
      reference.update({
        'userUid': userUid,
        'value': value,
      });
    }
  }

  Future delete() {
    return reference.delete();
  }
}
