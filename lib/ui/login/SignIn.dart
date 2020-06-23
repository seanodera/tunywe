import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/homeNav.dart';

import 'Signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email, pass;

  @override
  Widget build(BuildContext context) {
    email = TextEditingController();
    pass = TextEditingController();
    ViewModel viewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Back',
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    //padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.all(15.0),
                    height: 40,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                    child: Container(
                      width: 270,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: email,
                        style: TextStyle(
                          fontSize: 14.3,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          focusColor: CommonColors.primary,
                          hoverColor: CommonColors.primary,
                          fillColor: CommonColors.accentHex,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: CommonColors.accentHex,
                          )),
                          icon: Icon(
                            Icons.person_outline,
                            color: CommonColors.accentHex,
                          ),
                        ),
                      ),
                    )),
                Container(
                    //padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.all(15.0),
                    height: 40,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                    child: Container(
                      width: 270,
                      alignment: Alignment.center,
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(
                          fontSize: 14.3,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          focusColor: CommonColors.primary,
                          hoverColor: CommonColors.primary,
                          fillColor: CommonColors.accentHex,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: CommonColors.accentHex,
                          )),
                          icon: Icon(
                            Icons.lock_outline,
                            color: CommonColors.accentHex,
                          ),
                        ),
                        controller: pass,
                      ),
                    )),
                InkWell(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      height: 40,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CommonColors.primary),
                      child: Text(
                        'Log in',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email.text, password: pass.text)
                          .then((value) {
                        viewModel.user = value.user;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Consumer<ViewModel>(
                                    builder: (a, b, c) => HomeNav())));
                      }).catchError(() {
                        print('Error occured');
                      });
                    }),
                Container(
                  margin: EdgeInsets.only(top: 10),
                ),
                InkWell(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black38),
                        ),
                        Text(
                          ' Sign up',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp())))
              ],
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
    );
  }
}
