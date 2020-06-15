import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/home/order/bottle/BottleView.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);
    List<Combined> list = viewModel.combinedList;
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          Combined combined = list[index];
          PreParedBottle bottle = combined.bottle;
          return InkWell(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: bottle.image, fit: BoxFit.fill),
                        shape: BoxShape.circle),
                  ),
                  Text(bottle.bottleName)
                ],
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Consumer<ViewModel>(builder: (a, b, c) => BottleView(combined: combined,))),
                  ));
        }, childCount: list.length)),
      ],
    );
  }
}
