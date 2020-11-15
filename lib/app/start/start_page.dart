import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StartPage extends StatefulWidget {
  final String title;
  const StartPage({Key key, this.title = "Start"}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _containerHeader(),
            Padding(padding: EdgeInsets.only(bottom: 46.0)),
            _redirectSignIn(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            _redirectLogin(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
          ],
        ),
      ),
    );
  }

  _containerHeader() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'FLUXO DE CAIXA',
            style: TextStyle(
              color: Colors.black,
              fontSize: 42.0,
            ),
            textAlign: TextAlign.left,
          ),

          Padding(padding: EdgeInsets.only(bottom: 38.0)),

          Text(
            'Tenha o controle dos seus gastos e lucros. Acesse o aplicativo através do botão abaixo, caso não tenha um usuário, crie seu login, é rápido.',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  _redirectSignIn() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 48.0,
        child: RaisedButton(
          child: Text(
            "REGISTRAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            )
          ),

          color: Colors.blue[600],

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
          ),

          onPressed: () => Modular.to.pushReplacementNamed('/createUser'),
        ),
      ),
    );
  }

  _redirectLogin() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 48.0,
        child: RaisedButton(
          child: Text(
            "ENTRAR",
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 20.0,
            )
          ),

          color: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: Colors.blue[600]),
          ),
          

          onPressed: () => Modular.to.pushReplacementNamed('/login'),
        ),
      ),
    );
  }
}
