import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/helpers/inputWidget.dart';
import 'package:wipentrepreneur/services/firebaseAuth.dart';
import '../../router.dart' as router;

class AdminLogin extends StatefulWidget {
  static const String route = '/admin';

  AdminLogin({Key key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  submitForm() async {
    try {
      await FirebaseAuthService()
          .signIn(emailController.text, passwordController.text)
          .then((value) {
        setState(() {
          if (value != null) {
            Navigator.pushReplacementNamed(
              this.context,
              router.ADMINOPS,
            );
          }
        });
      });
    } catch (e) {
      print("Unable to login user due to enter $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FormattedText("Please login to continue...", 30, Colors.black,
                TextAlign.center),
            SizedBox(
              height: 30,
            ),
            Container(
              child: InputWidget(
                10.0,
                0.0,
                false,
                'Enter your email address to continue ...',
                emailController,
              ),
              height: 70,
            ),
            Container(
              child: InputWidget(
                0.0,
                0.0,
                true,
                'Enter your password to continue ...',
                passwordController,
              ),
              height: 70,
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {
                submitForm();
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    ));
  }
}
