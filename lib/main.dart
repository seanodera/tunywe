import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/source_functions.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/homeNav.dart';

void main() => runApp((MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ViewModel(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          cardColor: Colors.white,
          primaryColor: Colors.white,
          accentColor: CommonColors.primary,
          backgroundColor: Colors.white60,
          appBarTheme:
              AppBarTheme(color: Colors.white, brightness: Brightness.light),
        ),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            backgroundColor: Colors.grey[800],
            appBarTheme: AppBarTheme(
                brightness: Brightness.dark, color: CommonColors.otherGrey),
            primaryColor: Colors.black,
            accentColor: CommonColors.primary),
        home: PreSplash(),
      ),
    )));

class PreSplash extends StatefulWidget {
  @override
  _PreSplashState createState() => _PreSplashState();
}

class _PreSplashState extends State<PreSplash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    start(context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            height: 250,
            width: 250,
          )
        ],
      ),
    );
  }
}

start(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ViewModel(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
        cardColor: Colors.white,
        primaryColor: Colors.white,
        accentColor: CommonColors.primary,
        backgroundColor: Colors.white70,
          textTheme: TextTheme(headline4: TextStyle(color: Colors.black)),
        appBarTheme:
            AppBarTheme(color: Colors.white, brightness: Brightness.light),
        buttonColor: CommonColors.primary
      ),
      themeMode: (preferences.get('theme') == 'system')
          ? ThemeMode.system
          : (preferences.get('theme') == 'dark')
              ? ThemeMode.dark
              :  (preferences.get('theme') == 'Light')? ThemeMode.light : ThemeMode.system,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          buttonColor: CommonColors.primary,
          textTheme: TextTheme(headline4: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              brightness: Brightness.dark, color: CommonColors.otherGrey),
          primaryColor: Colors.black,
          accentColor: CommonColors.primary),
      home: Splash(),
    ),
  ));
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initialize(context);
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Consumer<ViewModel>(builder: (a, b, c) => HomeNav()))));
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            height: 250,
            width: 250,
          )
        ],
      ),
    );
  }
}
