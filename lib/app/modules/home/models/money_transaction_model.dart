import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';

class MoneyTransactionModel {

  AuthController auth = Modular.get();

  String userName;
  String value;
  DocumentReference reference;

  MoneyTransactionModel({
    this.userName = '',
    this.value = '',
    this.reference
  });

  factory MoneyTransactionModel.fromDocument(DocumentSnapshot doc) {
    return MoneyTransactionModel(
      userName: doc['userName'],
      value: doc['value'],
      reference: doc.reference
    );
  }

  Future save() async {
    userName = auth.user.email;

    if (reference == null) {
      reference = await FirebaseFirestore.instance
        .collection('money_transaction')
        .add({
          'userName': userName,
          'value': value,
        });
    }
    else {
      reference.update({
        'userName': userName,
        'value': value,
      });
    }
  }

  changeValue(String type, String valueCalc, [String oldValue]) {
    double money = 00.0;

    double account = double.parse(value.replaceAll(',', '.'));
    double price = double.parse(valueCalc.replaceAll(',', '.'));

    if (oldValue != null) {
      double oldPrice = double.parse(oldValue.replaceAll(',', '.'));
      account = type.toLowerCase() == 'entrada' ?
        account - oldPrice : account + oldPrice;
    }

    if (type.toLowerCase() == 'entrada') {
      money = account + price;
    }
    else {
      money = account - price;
    }

    value = money.toString();
    this.save();
  }

  Future delete() {
    return reference.delete();
  }
}
