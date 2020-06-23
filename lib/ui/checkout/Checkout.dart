import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Items',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Combined combo = viewModel.combinedList.singleWhere(
                      (value) => value.bottle.bottleId == list[index].bottleID);
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
                },
                itemCount: list.length,
                shrinkWrap: true,
              ),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Total',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        Text((totalAmount * 0.14).roundToDouble().toString()),
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
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Chosen Address',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Suburb :'),
                            Text(widget.address.suburb),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Apartment/House :'),
                            Text(widget.address.apartmentName +
                                " - " +
                                widget.address.houseNumber),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Street :'),
                            Text(widget.address.street),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('additional Instructions :'),
                            Text(widget.address.additionalInstructions),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: RaisedButton(
              onPressed: () {
                var doc = Firestore.instance.collection('active').document();
                PlacedOrder placed = PlacedOrder(
                    orderId: doc.documentID,
                    orderTime: DateTime.now().toString(),
                    totalCost: (totalAmount + 150),
                    status: 'pending',
                    paymentMethod: 'on delivery',
                    rider: 'Unassigned',
                    uid: viewModel.user.uid,
                    bottles: list,
                    addressId: widget.address.addressId);
                doc.setData(placed.toMap());
                list.forEach((element) {
                  doc.collection('bottles').add(element.toMap());
                });
              },
              child: Text('Post Order'),
            ),
          )
        ],
      ),
    );
  }
}

postOrder() {}
