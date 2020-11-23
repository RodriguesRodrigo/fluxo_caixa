import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
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

  changeValue(CashFlowModel model, bool isDeleteCashFlow) {
    double money = 00.0;

    double account = double.parse(value.replaceAll(',', '.'));
    double price = double.parse(model.value.replaceAll(',', '.'));

    if (isDeleteCashFlow) {
      money = model.type.toLowerCase() == 'entrada' ?
          account - price : account + price;
    }
    else {
      if (model.valueCached != '') {
        double oldPrice = double.parse(model.valueCached.replaceAll(',', '.'));
        account = model.type.toLowerCase() == 'entrada' ?
          account - oldPrice : account + oldPrice;
      }

      money = model.type.toLowerCase() == 'entrada' ?
          account + price : account - price;
    }

    value = money.toString().replaceAll('.', ',');
    this.save();
  }

  Future delete() {
    return reference.delete();
  }
}
