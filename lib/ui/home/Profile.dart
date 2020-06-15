import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/main.dart';
import 'package:tunywe/ui/login/SignIn.dart';
import 'package:tunywe/ui/login/Signup.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Account'),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: (viewModel.user == null)
                  ? Container(
                      height: 150,
                      child: ButtonBar(
                        mainAxisSize: MainAxisSize.max,
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlineButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
                            child: Text('Log in'),
                            borderSide: BorderSide(color: CommonColors.primary),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp())),
                              child: Text('Sign up'),
                              color: CommonColors.primary,
                            ),
                          )
                        ],
                      ))
                  : Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Sean'),
                              Text('Olero'),
                            ],
                          ),
                          Text('seanolero@outlook.com'),
                          Text('+254718215036'),
                        ],
                      ),
                    ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Preferences'),
                  Row(
                    children: [
                      Text('Theme'),
                      Container(
                        width: 100,
                        child: DropdownButton(items: [
                          DropdownMenuItem(child: Text('system'),value: 'system',),
                          DropdownMenuItem(child: Text('Dark'), value: 'dark',),
                          DropdownMenuItem(child: Text('Light'), value: 'light',),
                        ], onChanged: (value) {
                          viewModel.preferences.setString('theme', value.toString());
                          start(context);
                          PreSplash();
                        },value: viewModel.preferences.get('theme'),isExpanded: true,),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
