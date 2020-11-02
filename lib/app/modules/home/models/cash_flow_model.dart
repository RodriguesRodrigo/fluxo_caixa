import 'package:cloud_firestore/cloud_firestore.dart';

class CashFlowModel {
  String title;
  bool check;
  final DocumentReference reference;

  CashFlowModel({this.title, this.check, this.reference});

  factory CashFlowModel.fromDocument(DocumentSnapshot doc) {
    return CashFlowModel(title: doc['title'], check: doc['check'], reference: doc.reference);
  }
}