import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:http/http.dart' as http;
import 'package:wipentrepreneur/keys/keys.dart' as keys;

class GetInTouchDialog extends StatelessWidget {
  const GetInTouchDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController nameController = new TextEditingController();
    TextEditingController messageController = new TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String confirmationText;

    String validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value)) {
        emailController.clear();
        return 'Please Enter a valid Email Address';
      } else
        return null;
    }

    sendEmail() async {
      if (_formKey.currentState.validate()) {
        var subject = "Wip reader " + nameController.text + " says something";
        final response =
            await http.post(keys.mailgunURL, headers: <String, String>{
          'Authorization': keys.mailgunAPIKey
        }, body: {
          'from': emailController.text,
          'to': 'admin@wipentrepreneur.com',
          'subject': subject,
          'text': messageController.text
        });
        Navigator.pop(context);
        print("Response code :" + response.statusCode.toString());
        if (response.statusCode == 201 || response.statusCode == 200) {
          confirmationText =
              "Thanks a lot for reaching out to me, I will get back asap";
        } else {
          confirmationText =
              "Something went wrong on our side, please try again sometime later";
        }
        showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pop(context);
              });
              return AlertDialog(
                title: Text(confirmationText),
              );
            });
      }
    }

    return Dialog(
        child: SingleChildScrollView(
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
            child: FormattedText("Give me a shout and I will get back asap!",
                25, Colors.black, TextAlign.center)),
        SizedBox(height: 40),
        Container(
            width: 400,
            child: Material(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        topRight: Radius.circular(0.0))),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Please enter your name.",
                        hintStyle:
                            TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                  ),
                ))),
        SizedBox(
          height: 20,
        ),
        Container(
            width: 400,
            height: 200,
            child: Material(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        topRight: Radius.circular(0.0))),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "How can I help you?",
                        hintStyle:
                            TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                  ),
                ))),
        SizedBox(
          height: 20,
        ),
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
                    sendEmail();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    )));
  }
}
