import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/home/home_controller.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'package:fluxo_caixa/app/modules/home/models/screen_arguments.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CreateFluxPage extends StatefulWidget {
  final String title;
  const CreateFluxPage({Key key, this.title = "CreateFlux"}) : super(key: key);

  @override
  _CreateFluxPageState createState() => _CreateFluxPageState();
}

class _CreateFluxPageState extends ModularState<CreateFluxPage, HomeController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MoneyMaskedTextController moneyController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  CashFlowModel model = CashFlowModel();

  String paymentTypeInitial = 'Credito';
  List<String> paymentTypeChoices = ['Credito', 'Debito', 'Dinheiro'];

  String typeInitial = 'Entrada';
  List<String> typeChoices = ['Entrada', 'Saída'];

  ScreenArguments args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: FlatButton(
          padding: EdgeInsets.all(0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.close,
                color: Colors.black,
                size: 18.0,
              ),
              Text(
                'Fechar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          onPressed: () => Modular.to.popAndPushNamed('/home'),
        ),
        actions: [
          Container(
            // padding: EdgeInsets.only(right: 14.0),
            child: RaisedButton(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Text(
                    'Finalizar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 18.0,
                  ),
                ],
              ),
              onPressed: _createFlux, // Modular.to.pushReplacementNamed('/home'),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            _header(),
            _section(),
          ],
        ),
      ),
    );
  }

  _header() {
    return Container(
      padding: EdgeInsets.all(18.0),
      child: Text(
        'Nova receita',
        style: TextStyle(
          color: Colors.black,
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _section() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Value Field
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  controller: moneyController,
                  decoration: InputDecoration(
                    labelText: 'Valor da receita',
                    hintText: r'R$ 00,00',
                    contentPadding: const EdgeInsets.only(
                      left: 18.0,
                      top: 14.0,
                      right: 18.0,
                      bottom: 14.0,
                    ),
                  ),
                  onChanged: (value) {
                    var valueReplaced = value.replaceAll(new RegExp('[,.]'), '');
                    model.value = valueReplaced.toString();
                  },
                  validator: (value) => value.isEmpty ?
                    'Campo obrigatório não pode ser vazio.' :
                    null,
                ),
              ],
            ),
          ),

          // Description Field
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Descrição do pagamento',
                    contentPadding: const EdgeInsets.only(
                      left: 18.0,
                      top: 14.0,
                      right: 18.0,
                      bottom: 14.0,
                    ),
                  ),
                  onChanged: (value) => model.description = value,
                  validator: (value) => value.isEmpty ?
                    'Campo obrigatório não pode ser vazio.' :
                    null,
                ),
              ],
            ),
          ),

          // PaymentType Field
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400],
                )
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecione a forma de pagamento',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.0,
                  ),
                ),
                DropdownButton<String>(
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
              ],
            ),
          ),

          // Type Field
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400],
                )
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecione o tipo de receita',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.0,
                  ),
                ),
                DropdownButton<String>(
                  value: typeInitial,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  underline: Container(height: 0),
                  onChanged: (String newValue) {
                    setState(() {
                      typeInitial = newValue;
                      model.type = newValue;
                    });
                  },
                  items: typeChoices
                    .map<DropdownMenuItem<String>>((String itemValue) {
                    return DropdownMenuItem<String>(
                      value: itemValue,
                      child: Text(itemValue),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // PaymentDate Field
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Data do pagamento',
                    contentPadding: const EdgeInsets.only(
                      left: 18.0,
                      top: 14.0,
                      right: 18.0,
                      bottom: 14.0,
                    ),
                  ),
                  onChanged: (value) {
                    model.paymentDate = value;
                  },
                  validator: (value) => value.isEmpty ?
                    'Campo obrigatório não pode ser vazio.' :
                    null,
                ),
              ],
            ),
          ),

          // Observation Field
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Observação',
                    contentPadding: const EdgeInsets.only(
                      left: 18.0,
                      top: 14.0,
                      right: 18.0,
                      bottom: 14.0,
                    ),
                  ),
                  onChanged: (value) {
                    model.observation = value;
                  },
                ),
              ],
            ),
          ),

          Container(height: 40.0,),
        ],
      ),
    );
  }

  _createFlux() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      controller.createCashFlow(model, args.moneyModel);
      Modular.to.pushReplacementNamed('/home');
    }
    else {
      _showDialog(
        'Ops',
        'Por favor, preencha todos os campos da forma correta para continuar.'
      );
    }
  }

  _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Modular.to.pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      }
    );
  }

}
