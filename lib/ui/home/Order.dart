import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/home/order/Categories.dart';
import 'package:tunywe/ui/home/order/Featured.dart';

import 'order/PreviousOrders.dart';
import 'order/basket.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      Categories(),
      Consumer<ViewModel>(
        builder: (context, notifier, child) {
          return Featured();
        },
        child: Featured(),
      ),
      Consumer<ViewModel>(
        builder: (context, notifier, child) {
          return PreviousOrders();
        },
        child: PreviousOrders(),
      ),
    ];
    return DefaultTabController(
        length: _widgets.length,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Order'),
            actions: [
              IconButton(
                  icon: Icon(LineAwesomeIcons.shopping_cart),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Consumer<ViewModel>(builder: (a, b, c) => Basket()))))
            ],
            bottom: TabBar(tabs: [
              Tab(text: 'Categories'),
              Tab(
                text: 'Featured',
              ),
              Tab(
                text: 'Past Orders',
              ),
            ]),
          ),
          body: TabBarView(children: _widgets),
        ));
  }
}
