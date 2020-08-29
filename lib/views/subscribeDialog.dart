import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';

import '../helpers/formatted-text.dart';

class SubscribeDialog extends StatelessWidget {
  const SubscribeDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    final _formKey = GlobalKey<FormState>();

    String validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Please Enter a valid Email Address';
      else
        return null;
    }

    addSubscriber(String subscriberEmail) async {
      if (_formKey.currentState.validate()) {
        await DbOperations().addSubscriber(subscriberEmail);
        //print("Email to be saved : $emailToSave");
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pop(context);
              });
              return AlertDialog(
                title: Text(
                    "Thanks a lot for subscribing! I will see you soon..."),
              );
            });
      }
    }

    return Dialog(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Padding(
            padding: EdgeInsets.all(20),
            child: FormattedText(
                "Be the first one to receive my posts delivered to your email box!",
                25,
                Colors.black,
                TextAlign.center)),
        SizedBox(height: 40),
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10, bottom: 20),
                child: Container(
                  width: 400,
                  child: Material(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(0.0))),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 40, right: 20, top: 10, bottom: 10),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "JohnDoe@example.com",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFE1E1E1), fontSize: 14)),
                            ),
                          ))),
                )),
            ClipOval(
              child: Material(
                color: Colors.blue, // button color
                child: InkWell(
                  splashColor: Colors.green, // inkwell color
                  child: SizedBox(
                      width: 56, height: 56, child: Icon(Icons.arrow_forward)),
                  onTap: () {
                    addSubscriber(emailController.text);
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        FormattedText(
            "No spam ever, Promise!", 15, Colors.black, TextAlign.center),
        SizedBox(
          height: 40,
        ),
      ],
    ));
  }
}
