import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';

class CashFlowModel {

  AuthController auth = Modular.get();

  String userName;
  String description;
  String observation;
  String type;
  String paymentType;
  String value;
  String paymentDate;
  Timestamp createdAt;
  DocumentReference reference;

  CashFlowModel({
    this.userName = '',
    this.description = '',
    this.observation = '',
    this.type = '',
    this.paymentType = '',
    this.value = '',
    this.paymentDate = '',
    this.createdAt,
    this.reference
  });

  factory CashFlowModel.fromDocument(DocumentSnapshot doc) {
    return CashFlowModel(
      userName: doc['userName'],
      description: doc['description'],
      observation: doc['observation'],
      type: doc['type'],
      paymentType: doc['paymentType'],
      value: doc['value'],
      createdAt: doc['createdAt'],
      paymentDate: doc['paymentDate'],
      reference: doc.reference
    );
  }

  Future save() async {
    userName = auth.user.email;

    if (reference == null) {

      createdAt = new Timestamp.now() ?? createdAt == null;

      reference = await FirebaseFirestore.instance
        .collection('cash_flux')
        .add({
          'description': description,
          'observation': observation,
          'value': value,
          'type': type,
          'paymentType': paymentType,
          'createdAt': createdAt,
          'paymentDate': paymentDate,
          'userName': userName,
        });
    }
    else {
      reference.update({
        'description': description,
        'observation': observation,
        'value': value,
        'type': type,
        'paymentType': paymentType,
        'createdAt': createdAt,
        'paymentDate': paymentDate,
        'userName': userName,
      });
    }
  }

  Future delete() {
    return reference.delete();
  }
}