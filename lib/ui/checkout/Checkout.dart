import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/localDb.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';

class Checkout extends StatefulWidget {
  final Address address;

  Checkout({@required this.address});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    DatabaseProvider.db.getItems(context);
    super.initState();
  }

  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);
    List<BasketItem> list = viewModel.basket;
    List<Combined> fnList = new List();
    list.forEach((element) {
      Combined combined = viewModel.combinedList
          .singleWhere((value) => value.bottle.bottleId == element.bottleID);
      fnList.add(combined);
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            title: Text('Checkout'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text('Items'),
                Card(
                  child: ListView.builder(itemBuilder: (context, index) {
                    Combined combo = viewModel.combinedList.singleWhere(
                        (value) =>
                            value.bottle.bottleId == list[index].bottleID);
                    BottleSize size = combo.bottleSizes.singleWhere(
                        (element) => element.sizeId == list[index].sizeID);
                    int total = list[index].bottleCount * int.parse(size.price);
                    totalAmount += total;
                    return ListTile(
                      leading: Text(list[index].bottleCount.toString()),
                      title: Text(combo.bottle.bottleName),
                      subtitle: Text(size.capacity),
                      trailing: Text('Kes' + total.toString()),
                    );
                  }),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                ),
                Text('Total'),
                Card(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sub Total: '),
                          Text('Kes' + totalAmount.toString()),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax @ 14%'),
                          Text((totalAmount * 0.14).toString()),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery '),
                          Text('KES150'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('You will pay '),
                          Text((totalAmount + 150).toString()),
                        ],
                      )
                    ],
                  ),
                ),
                Text('Address'),
                Card(
                  child: Column(
                    children: [
                      Text(widget.address.suburb),
                      Text(widget.address.apartmentName +
                          " - " +
                          widget.address.houseNumber),
                      Text(widget.address.street),
                      Text(widget.address.additionalInstructions),
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: RaisedButton(onPressed: () {
              var doc = Firestore.instance.collection('active').document();
              PlacedOrder placed = PlacedOrder(
                  orderId: doc.documentID,
                  orderTime: DateTime.now().toString(),
                  totalCost: (totalAmount + 150),
                  status: 'pending',
                  paymentMethod: 'on delivery',
                  rider: 'Unassigned',
                  uid: viewModel.user.uid,
                  bottles: list);
              doc.setData(placed.toMap());
            }),
          )
        ],
      ),
    );
  }
}

postOrder() {}
