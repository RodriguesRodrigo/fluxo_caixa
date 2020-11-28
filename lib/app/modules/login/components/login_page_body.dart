import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/login/login_controller.dart';

class LoginPageBody {

  String email;
  String password;

  titleForm() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 42.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  textFormFieldEmail() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,

        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),

        decoration: InputDecoration(
          hintText: "Usuário",

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
          'Por favor, informe seu usuário.' :
          null,

        onChanged: (text) {
          email = text;
        },
      ),
    );
  }

  textFormFieldPassword() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,

        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),

        decoration: InputDecoration(
          hintText: "Senha",

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
          'Por favor, informe sua senha' :
          null,

        onChanged: (text) {
          password = text;
        },
      ),
    );
  }

  containerButton(BuildContext context, LoginController controller) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 48.0,
        child: RaisedButton(
          child: Text(
            "ENTRAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            )
          ),

          color: Colors.blue[600],

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
          ),

          onPressed: () async {
            controller.loginWithFirebase(email, password);
          },
        ),
      ),
    );
  }

  redirectCreateUser() {
    return Container(
      child: InkWell(
        child: Text(
          'Não tenho uma conta. Cadastrar',
          style: TextStyle(
            color: Colors.blue[600],
            fontSize: 16.0,
          )
        ),
        onTap: () => Modular.to.pushReplacementNamed('/createUser'),
      ),
    );
  }
}
