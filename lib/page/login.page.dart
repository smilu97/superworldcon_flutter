import 'package:flutter/material.dart';
import 'package:superworldcon/apis/auth.dart';

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({Key key, this.title}): super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();

  void _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;
    try {
      final LoginResponse res = await fetchLogin(email, password);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success to login'),
            content: Text(res.message + '\nid: ${res.id}'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } on Exception {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Failed to login'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      textInputAction: TextInputAction.next,
      onSubmitted: (v) {
        FocusScope.of(context).requestFocus(passwordFocus);
      },
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "E-MAIL",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextField(
      controller: passwordController,
      focusNode: passwordFocus,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "PASSWORD",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => _login(context),
        child: Text("Login",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 250.0,
                  child: Image.asset(
                    "assets/worldcon.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}