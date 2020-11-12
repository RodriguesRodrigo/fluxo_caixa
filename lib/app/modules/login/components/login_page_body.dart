import 'package:flutter/material.dart';
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

        validator: (String value) {
          if (value.isEmpty) {
            return 'Por favor, informe seu usuário';
          }
          return null;
        },

        onChanged: (text) {
          email = text;
          print(email);
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

        validator: (String value) {
          if (value.isEmpty) {
            return 'Por favor, informe seu usuário';
          }
          return null;
        },

        onChanged: (text) {
          password = text;
          print(password);
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
            print(email);
            print(password);
            controller.loginWithFirebase(email, password);
          },
        ),
      ),
    );
  }
}
