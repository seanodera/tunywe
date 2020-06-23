import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';

import 'BottleView.dart';

class BottleList extends StatelessWidget {
  final String titleText;

  BottleList({this.titleText});

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context, listen: true);
    List<Combined> list = (titleText == 'All')
        ? viewModel.combinedList
        : viewModel.combinedList.where((element) {
            return element.bottle.category.toLowerCase() ==
                titleText.toLowerCase();
          }).toList();
    debugPrint('List length is ' + list.length.toString());
    return Container(
      color: Theme.of(context).backgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Tunywe Bottles'),
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
            ),
            bottom: AppBar(
              automaticallyImplyLeading: false,
              title: Text(titleText),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              Combined combined = list.elementAt(index);
              PreParedBottle bottle = combined.bottle;
              var sizeList = combined.bottleSizes;
              (sizeList.length < 1)
                  ? print(sizeList.length)
                  : sizeList.sort((a, b) =>
                      int.parse(a.price).compareTo(int.parse(b.price)));
              int price = int.parse(sizeList.last.price);
              return Card(
                child: ListTile(
                  isThreeLine: false,
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: bottle.image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  title: Text(bottle.bottleName),
                  subtitle: Text('from ' + price.toString()),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consumer<ViewModel>(
                              builder: (a, b, c) =>
                                  BottleView(combined: combined)))),
                ),
              );
            }, childCount: list.length),
          )
        ],
      ),
    );
  }
}
