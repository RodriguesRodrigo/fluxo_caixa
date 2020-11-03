import 'package:cloud_firestore/cloud_firestore.dart';

class CashFlowModel {
  // TODO:
  // Order by date

  String title;
  bool check;
  DocumentReference reference;

  CashFlowModel({this.title = '', this.check = false, this.reference});

  factory CashFlowModel.fromDocument(DocumentSnapshot doc) {
    return CashFlowModel(title: doc['title'], check: doc['check'], reference: doc.reference);
  }

  Future save() async {
    if (reference == null) {
      reference = await FirebaseFirestore.instance
        .collection('cash_flux')
        .add({'title': title, 'check': check,});
    }
    else {
      reference.update({
        'title': title,
        'check': check,
      });
    }
  }

  Future delete() {
    return reference.delete();
  }
}