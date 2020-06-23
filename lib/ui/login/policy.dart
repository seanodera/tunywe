import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String terms;

  @override
  Widget build(BuildContext context) {
    Future<String> loadAsset(BuildContext context) async {
      return await rootBundle.loadString('assets/privacy.txt');
    }

    loadAsset(context).then((value) {
      setState(() {
        terms = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (terms == null)
              ? CircularProgressIndicator()
              : Expanded(child:  SingleChildScrollView(
            child: Text(terms, textAlign: TextAlign.center,),
          ),)
        ],
      ),
    );
  }
}
