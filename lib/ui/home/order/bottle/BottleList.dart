import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/home/order/bottle/BottleItem.dart';

class BottleList extends StatelessWidget {
  final String titleText;
  BottleList({this.titleText});
  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);
    List<Combined> list = viewModel.combinedList;
    return CustomScrollView(
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
        SliverList(delegate: SliverChildBuilderDelegate((context,index){
          return BottleItem(combined: list.elementAt(index));
        },childCount: list.length))
      ],
    );
  }
}
