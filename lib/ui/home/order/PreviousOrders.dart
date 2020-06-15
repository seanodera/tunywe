import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/source_functions.dart';
import 'package:tunywe/background/viewModel.dart';

import 'bottle/BottleView.dart';

class PreviousOrders extends StatefulWidget {
  @override
  _PreviousOrdersState createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  ViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<ViewModel>(context);
    (viewModel.previousOrderList == null)
        ? getPreviousBottle(viewModel)
        : print('already has');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (viewModel.previousOrderList == null ||
            viewModel.previousOrderList.isEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(LineAwesomeIcons.close),
              Text("You Haven't bought anything from us yet"),
              Text('Rick is a madam!!'),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              PreviousOrder order = viewModel.previousOrderList[index];
              DateTime orderDate = DateTime.parse(order.orderTime);

              return Card(
                child: InkWell(
                  child: Container(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(orderDate.month.toString() +
                                '-' +
                                orderDate.day.toString() +
                                '-' +
                                orderDate.year.toString()),
                            Text(orderDate.hour.toString() +
                                ':' +
                                orderDate.minute.toString()),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Bottle Count: ' + order.bottleCount),
                          Text('Total Cost: Kes' + order.totalCost),
                        ],
                      )
                    ]),
                  ),
                  onTap: () {
                    List<Combined> bottle = viewModel.combinedList;
                    List<Combined> list = new List();
                    order.bottles.forEach((element) {
                      list.add(bottle.singleWhere((combo) {
                        return combo.bottle.bottleId == element.bottleId;
                      }));
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              onPressed: () {
                                Scaffold.of(context).hideCurrentSnackBar(
                                    reason: SnackBarClosedReason.dismiss);
                              },
                              child: Text('close'),
                            ),
                          ],
                        ),
                        Container(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            BasketBottle basketBottle = order.bottles[index];
                            Combined combined =
                                viewModel.combinedList.singleWhere((element) {
                              return element.bottle.bottleId ==
                                  basketBottle.bottleId;
                            });
                            PreParedBottle bottle = combined.bottle;
                            BottleSize size =
                                combined.bottleSizes.singleWhere((element) {
                              return element.sizeId == basketBottle.sizeId;
                            });
                            return InkWell(
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: bottle.image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Text(bottle.bottleName),
                                    Text(size.capacity),
                                  ],
                                ),
                              ),
                              onTap: () => Consumer<ViewModel>(
                                  builder: (a, b, c) => BottleView(
                                      combined: list.elementAt(index))),
                            );
                          }),
                        )
                      ],
                    )));
                  },
                ),
              );
            },
            itemCount: viewModel.previousOrderList.length,
          );
  }
}
