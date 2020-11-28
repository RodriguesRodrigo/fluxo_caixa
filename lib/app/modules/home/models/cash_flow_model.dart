import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';

class CashFlowModel {

  AuthController auth = Modular.get();
  FirebaseFirestore instanceMoney = FirebaseFirestore.instance;

  String userUid;
  String description;
  String observation;
  String type;
  String paymentType;
  String value;
  String valueCached;
  String paymentDate;
  Timestamp createdAt;
  DocumentReference reference;

  CashFlowModel({
    this.userUid = '',
    this.description = '',
    this.observation = '',
    this.type = 'Entrada',
    this.paymentType = 'Credito',
    this.value = '',
    this.valueCached = '',
    this.paymentDate = '',
    this.createdAt,
    this.reference
  });

  factory CashFlowModel.fromDocument(DocumentSnapshot doc) {
    return CashFlowModel(
      userUid: doc['userUid'],
      description: doc['description'],
      observation: doc['observation'],
      type: doc['type'],
      paymentType: doc['paymentType'],
      value: doc['value'],
      valueCached: doc['valueCached'],
      createdAt: doc['createdAt'],
      paymentDate: doc['paymentDate'],
      reference: doc.reference
    );
  }

  Future save() async {
    userUid = auth.user.uid;

    if (reference == null) {
      createdAt = new Timestamp.now() ?? createdAt == null;

      reference = await FirebaseFirestore.instance
        .collection('cash_flux')
        .add({
          'description': description,
          'observation': observation,
          'value': value,
          'valueCached': value,
          'type': type,
          'paymentType': paymentType,
          'createdAt': createdAt,
          'paymentDate': paymentDate,
          'userUid': userUid,
        });
    }
    else {
      reference.update({
        'description': description,
        'observation': observation,
        'value': value,
        'valueCached': value,
        'type': type,
        'paymentType': paymentType,
        'createdAt': createdAt,
        'paymentDate': paymentDate,
        'userUid': userUid,
      });
    }
  }

  Future delete(MoneyTransactionModel moneyModel) {
    return reference.delete();
  }
}