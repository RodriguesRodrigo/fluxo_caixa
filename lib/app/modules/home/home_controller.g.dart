// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$cashFlowListAtom = Atom(name: '_HomeControllerBase.cashFlowList');

  @override
  ObservableStream<List<CashFlowModel>> get cashFlowList {
    _$cashFlowListAtom.reportRead();
    return super.cashFlowList;
  }

  @override
  set cashFlowList(ObservableStream<List<CashFlowModel>> value) {
    _$cashFlowListAtom.reportWrite(value, super.cashFlowList, () {
      super.cashFlowList = value;
    });
  }

  final _$moneyTransactionListAtom =
      Atom(name: '_HomeControllerBase.moneyTransactionList');

  @override
  ObservableStream<List<MoneyTransactionModel>> get moneyTransactionList {
    _$moneyTransactionListAtom.reportRead();
    return super.moneyTransactionList;
  }

  @override
  set moneyTransactionList(
      ObservableStream<List<MoneyTransactionModel>> value) {
    _$moneyTransactionListAtom.reportWrite(value, super.moneyTransactionList,
        () {
      super.moneyTransactionList = value;
    });
  }

  final _$logoffAsyncAction = AsyncAction('_HomeControllerBase.logoff');

  @override
  Future logoff() {
    return _$logoffAsyncAction.run(() => super.logoff());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic getList() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getList');
    try {
      return super.getList();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cashFlowList: ${cashFlowList},
moneyTransactionList: ${moneyTransactionList}
    ''';
  }
}
