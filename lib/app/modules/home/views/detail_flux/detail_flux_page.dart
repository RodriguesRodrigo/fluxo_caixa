import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/home/home_controller.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/screen_arguments.dart';
import 'package:money2/money2.dart';

class DetailFluxPage extends StatefulWidget {
  final String title;
  const DetailFluxPage({Key key, this.title = "Detail"}) : super(key: key);

  @override
  _DetailFluxPageState createState() => _DetailFluxPageState();
}

class _DetailFluxPageState extends ModularState<DetailFluxPage, HomeController> {
  String paymentTypeInitial = 'Credito';
  List<String> paymentTypeChoices = ['Credito', 'Debito', 'Dinheiro'];

  bool showCircularProgress = false;

  ScreenArguments args;

  final brl = Currency.create('BRL', 2, symbol: r'R$', invertSeparators: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (controller.cashFlowList.data == null) {
      showCircularProgress = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Observer(
      builder: (_) {
        if (controller.cashFlowList.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        CashFlowModel model = controller.cashFlowList.data[args.index];

        return Scaffold(
          appBar: AppBar(
            title: Container(
              width: 15.0,
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18.0,
                ),
                onPressed: () => Modular.to.popAndPushNamed('/home'),
              ),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 18.0),
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await controller.deleteCashFlow(model, args.moneyModel);
                  Modular.to.pushReplacementNamed('/home');
                },
              ),
            ],
            elevation: 0,
            backgroundColor: model.type.toLowerCase() == 'entrada' ?
              Colors.green :
              Colors.red,
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                _header(model),
                _section(model),
              ],
            ),
          ),
        );
      }
    );
  }

  _header(CashFlowModel model) {
    var costPrice = Money.fromInt(int.parse(model.value), brl);
    var money = costPrice.format('S #.###,##');

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
        color: model.type.toLowerCase() == 'entrada' ?
          Colors.green :
          Colors.red,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                money.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.0,
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 8.0)),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.edit,
                    color: model.type.toLowerCase() == 'entrada' ?
                      Colors.green :
                      Colors.red,
                  ),
                  onPressed: () {
                    _changeValue(model);
                  },
                ),
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _section(CashFlowModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Description
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 26.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400],
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Descrição do pagamento',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.description,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                        onPressed: () {
                          _changeDescription(model);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // PaymentType
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 26.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400],
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tipo de pagamento',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.paymentType,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                        onPressed: () {
                          _changePaymentType(model);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // PaymentDate
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 26.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400],
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Data do pagamento',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.paymentDate,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                        onPressed: () {
                          _changePaymentDate(model);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Observation
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 26.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400],
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Observação do pagamento',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      model.observation.isNotEmpty ?
                        model.observation :
                        'Adicione uma observação',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                        onPressed: () {
                          _changeObservation(model);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        
        ],
      ),
    );
  }

  _changeValue(CashFlowModel model) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Editar'),
          content: Container(
            child: TextFormField(
              initialValue: model.value,
              onChanged: (value) => model.value = value,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                await controller.updateCashFlow(model, args.moneyModel);
                Modular.to.pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      }
    );
  }

  _changeDescription(CashFlowModel model) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Editar'),
          content: Container(
            child: TextFormField(
              initialValue: model.description,
              onChanged: (value) => model.description = value,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                await controller.updateCashFlow(model, args.moneyModel);
                Modular.to.pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      }
    );
  }

  _changePaymentType(CashFlowModel model) {
    paymentTypeInitial = model.paymentType;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Editar'),
          content: Container(
            child: DropdownButton<String>(
              value: paymentTypeInitial,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              underline: Container(height: 0),
              onChanged: (String newValue) {
                setState(() {
                  paymentTypeInitial = newValue;
                  model.paymentType = newValue;
                });
              },
              items: paymentTypeChoices
                .map<DropdownMenuItem<String>>((String itemValue) {
                return DropdownMenuItem<String>(
                  value: itemValue,
                  child: Text(itemValue),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                await controller.updateCashFlow(model, args.moneyModel);
                Modular.to.pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      }
    );
  }

  _changePaymentDate(CashFlowModel model) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Editar'),
          content: Container(
            child: TextFormField(
              initialValue: model.paymentDate,
              onChanged: (value) => model.paymentDate = value,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                await controller.updateCashFlow(model, args.moneyModel);
                Modular.to.pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      }
    );
  }

  _changeObservation(CashFlowModel model) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Editar'),
          content: Container(
            child: TextFormField(
              initialValue: model.observation.isNotEmpty ?
                model.observation :
                'Adicione uma observação',
              onChanged: (value) => model.observation = value,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                await controller.updateCashFlow(model, args.moneyModel);
                Modular.to.pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      }
    );
  }

}
