import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/localDb.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/checkout/SelectAddress.dart';
import 'package:tunywe/ui/login/SignIn.dart';

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  void initState() {
    DatabaseProvider.db.getItems(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);
    List<BasketItem> list = viewModel.basket;

    return Scaffold(
      appBar: AppBar(
        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Basket'),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          BasketItem basketItem = list[index];
          Combined combined = viewModel.combinedList.singleWhere((element) {
            return element.bottle.bottleId == basketItem.bottleID;
          });
          PreParedBottle bottle = combined.bottle;
          BottleSize size = combined.bottleSizes.singleWhere((element) {
            return element.sizeId == basketItem.sizeID;
          });

          return Card(
            child: ListTile(
              leading: Text(basketItem.bottleCount.toString()),
              title: Text(bottle.bottleName + '-' + size.capacity),
              subtitle: Text('Total: ' +
                  (basketItem.bottleCount * int.parse(size.price)).toString()),
              trailing: IconButton(
                icon: Icon(LineAwesomeIcons.remove),
                onPressed: () {
                  DatabaseProvider.db.delete(basketItem);
                },
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 80),
        child: RaisedButton(
          onPressed: () => (viewModel.user == null || viewModel.user.isAnonymous)? Flushbar(
          titleText: RaisedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))),
          ): Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Consumer<ViewModel>(builder: (a, b, c) => SelectAddress()))),
          child: Text('Proceed to Checkout'),
        ),
      ),
    );
  }
}
