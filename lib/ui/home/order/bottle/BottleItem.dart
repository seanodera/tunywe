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
    var sizeList = combined.bottleSizes;
    sizeList.sort((a,b) => int.parse(a.price).compareTo(int.parse(b.price)));
    int price = int.parse( sizeList.last.price);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        isThreeLine: true,
        leading: Container(
          width: 75,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: bottle.image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(bottle.bottleName),
        subtitle: Text('from ' + price.toString()),

        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Consumer<ViewModel>(
                builder: (a, b, c) => BottleView(combined: combined)))),
      ),
    );
  }
}
