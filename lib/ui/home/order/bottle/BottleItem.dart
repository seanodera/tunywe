import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';

import 'BottleView.dart';

class BottleItem extends StatelessWidget {
  final Combined combined;

  BottleItem({this.combined});

  @override
  Widget build(BuildContext context) {
    PreParedBottle bottle = combined.bottle;
    return FlatButton(
        child: Card(
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(left: 5, right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: bottle.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(bottle.bottleName),
            ],
          ),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Consumer<ViewModel>(
                builder: (a, b, c) => BottleView(combined: combined)))),
      );
  }
}
