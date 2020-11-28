import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/home/models/money_transaction_model.dart';

class CreateMoneyPage extends StatefulWidget {
  final String title;
  const CreateMoneyPage({Key key, this.title = "CreateMoney"})
      : super(key: key);

  @override
  _CreateMoneyPageState createState() => _CreateMoneyPageState();
}

class _CreateMoneyPageState extends State<CreateMoneyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MoneyMaskedTextController moneyController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    leftSymbol: r'R$',
  );

  MoneyTransactionModel _model = MoneyTransactionModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          right: 16.0,
          left: 16.0,
        ),
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80.0),
              _title(),
              SizedBox(height: 80.0),
              _textFormFieldEmail(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          right: 16.0,
          bottom: 80.0,
          left: 16.0,
        ),
        height: 120.0,
        width: 100.0,
        alignment: Alignment.centerRight,
        child: RaisedButton(
          child: Text(
            'CONTINUAR',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            )
          ),
          color: Colors.white12,
          elevation: 0,
          onPressed: () async => await _validateForm(),
        ),
      ),
    );
  }

  _title() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Primeira etapa',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[400],
              ),
            ),
            Text(
              'Inicie seu planejamento',
              style: TextStyle(
                color: Colors.black,
                fontSize: 42.0,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  _textFormFieldEmail() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nos informe seu saldo atual',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 16.0),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: moneyController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
            decoration: InputDecoration(
              hintText: r"R$ 00,00",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                ),
              ),
              fillColor: Colors.grey[300],
              filled: true,
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                top: 14.0,
                right: 20.0,
                bottom: 14.0,
              ),
            ),
            validator: (value) => value.isEmpty ?
              'Campo obrigatório não pode ser vazio.' :
              null,
            onChanged: (value) {
              var valueReplaced = value.replaceAll(new RegExp(r'[a-zA-Z]|\D'), '');
              _model.value = valueReplaced.toString();
            },
          ),
        ],
      ),
    );
  }

  Future _validateForm() async {
    if (_model.value.isEmpty) {
      _showDialog(
        'Campo obrigatório',
        'Por favor, informe seu valor inicial.'
      );
    }
    else {
      await _model.save();
      Modular.to.pushReplacementNamed('/home');
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
