import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/source_functions.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/homeNav.dart';

class TrackOrder extends StatefulWidget {
  final List<ActiveOrder> activeOrder;

  TrackOrder(this.activeOrder);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int progress;
  String status;

  @override
  void initState() {
    status = 'pending';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context, listen: true);
    ActiveOrder activeOrder = viewModel.orders.single;
    PlacedOrder placedOrder = activeOrder.order;
    List<BasketItem> list = activeOrder.list;
    List<Combined> fnList = new List();
    list.forEach((element) {
      Combined combined = viewModel.combinedList
          .singleWhere((value) => value.bottle.bottleId == element.bottleID);
      fnList.add(combined);
    });
    print('address list at track order ' +
        viewModel.addressList.length.toString());
    Address address = viewModel.addressList.singleWhere((element) {
      return element.addressId == placedOrder.addressId;
    });
    var totalAmount = placedOrder.totalCost;
    if (status == 'pending') {
      setState(() {
        progress = 25;
      });
    } else if (status == 'confirmed') {
      setState(() {
        progress = 50;
      });
    } else if (status == 'picked up') {
      setState(() {
        progress = 75;
      });
    } else if (status == 'delivered') {
      setState(() {
        progress = 100;
      });
      switchOder(placedOrder);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Consumer<ViewModel>(builder: (a, b, c) => HomeNav())));
    }
    Firestore.instance
        .collection('active')
        .document(placedOrder.orderId)
        .snapshots()
        .listen((event) {
      setState(() {
        status = event.data[MapNames.status];
      });
    });
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            title: Text('Track Order'),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Text('Progress'),
                    FAProgressBar(
                      currentValue: (progress == null) ? 0 : progress,
                      backgroundColor: Colors.grey[800],
                      progressColor: CommonColors.primary,
                    ),
                    Text(status)
                  ],
                ),
              ),
            ),
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
                 // int totalAmount = placedOrder.totalCost;
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
                        Text('Pay exactly '),
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
                            Text(address.suburb),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Apartment/House :'),
                            Text(address.apartmentName +
                                " - " +
                                address.houseNumber),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Street :'),
                            Text(address.street),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('additional Instructions :'),
                            Text(address.additionalInstructions),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
