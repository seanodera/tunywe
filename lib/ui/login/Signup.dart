import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/login/Address.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fName, sName, email, pass, phone;
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    fName = TextEditingController();
    sName = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    phone = TextEditingController();
    ViewModel viewModel = Provider.of<ViewModel>(context);
    createUser() {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.text, password: pass.text)
          .then((value) {
        viewModel.user = value.user;
        Firestore.instance.collection('users').document(value.user.uid).setData(
            UserDetails(value.user.uid, value.user.email, fName.text,
                sName.text, dateTime.toString())
                .toMap()).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => NewAddress(toHome: true,))));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'create Account',
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          RaisedButton(onPressed: createUser, child: Text('Done'),color: CommonColors.primary,)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 180,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                    child: Container(
                      alignment: Alignment.center,
                      width: 160,
                      child: TextField(
                        controller: fName,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: 'First Name'),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 180,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                        style: BorderStyle.solid,
                      )),
                  child: Container(
                    alignment: Alignment.center,
                    width: 160,
                    child: TextField(
                      controller: sName,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: 'second Name',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(15.0),
                height: 40,
                width: 370,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                      style: BorderStyle.solid,
                    )),
                child: Container(
                  width: 340,
                  alignment: Alignment.center,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 14.3,
                    ),
                    textAlign: TextAlign.center,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
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
                width: 370,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                      style: BorderStyle.solid,
                    )),
                child: Container(
                  width: 340,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: phone,
                    style: TextStyle(
                      fontSize: 14.3,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      focusColor: CommonColors.primary,
                      hoverColor: CommonColors.primary,
                      fillColor: CommonColors.accentHex,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CommonColors.accentHex,
                          )),
                      icon: Icon(
                        Icons.phone,
                        color: CommonColors.accentHex,
                      ),
                    ),
                  ),
                )),
            Container(
              //padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(15.0),
                height: 40,
                width: 370,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                      style: BorderStyle.solid,
                    )),
                child: Container(
                  width: 340,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: pass,
                    style: TextStyle(
                      fontSize: 14.3,
                    ),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'password',
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
                  ),
                )),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
