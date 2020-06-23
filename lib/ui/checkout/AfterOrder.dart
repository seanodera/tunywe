import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/homeNav.dart';

class AfterOrder extends StatefulWidget {
  @override
  _AfterOrderState createState() => _AfterOrderState();
}

class _AfterOrderState extends State<AfterOrder> {
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.done,
          size: (0.25 * MediaQuery.of(context).size.width),
          color: Colors.green,
        ),
        Text('Order Posted'),
        Text('Thank For Ordering from Tunywe'),
        Text('Stay Close to your Phone we will be with you soon'),
        RaisedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Consumer<ViewModel>(builder: (a, b, c) => HomeNav()))),
          child: Text('Continue Shopping'),
        )
      ],
    );
  }
}
