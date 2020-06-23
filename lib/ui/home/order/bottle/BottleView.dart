import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:tunywe/background/localDb.dart';
import 'package:tunywe/background/model.dart';

class BottleView extends StatefulWidget {
  final Combined combined;

  BottleView({@required this.combined});

  @override
  _BottleViewState createState() => _BottleViewState();
}

class _BottleViewState extends State<BottleView> {
  int count;
  BottleSize _chosen;
  String capacity;

  @override
  void initState() {
    count = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PreParedBottle bottle = widget.combined.bottle;
    List<BottleSize> sizes = widget.combined.bottleSizes;

    ThemeData themeData = Theme.of(context);
    print(sizes.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text(bottle.bottleName),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              height: (size.width - 40),
              width: (size.width),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: bottle.image, fit: BoxFit.fitHeight)),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description: '),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      bottle.description,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Options',
                    style: themeData.textTheme.headline5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('size: '),
                      Container(
                        child: DropdownButton(
                          items: List.generate(
                              sizes.length,
                              (index) => DropdownMenuItem(
                                    child: Text(sizes[index].capacity +
                                        'ml @ Kes ' +
                                        sizes[index].price),
                                    value: sizes[index].capacity,
                                    onTap: () {
                                      setState(() {
                                        _chosen = sizes[index];
                                        print(index);
                                      });
                                    },
                                  )),
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              capacity = value;
                              print(capacity);
                            });
                          },
                          value: (capacity == null)
                              ? sizes.elementAt(0).capacity
                              : capacity,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Quantity: '),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(LineAwesomeIcons.plus),
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              }),
                          Container(
                            width: 30,
                            child: TextField(
                              onChanged: (value) => count = int.parse(value),
                              keyboardType: TextInputType.number,
                              controller:
                                  TextEditingController(text: count.toString()),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                              icon: Icon(LineAwesomeIcons.minus),
                              onPressed: () {
                                setState(() {
                                  count--;
                                });
                              }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: (size.width / 4), right: (size.width / 4), top: 5),
            width: (size.width / 2),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: CommonColors.primary,
            ),
            alignment: Alignment.center,
            child: InkWell(
              child: Text('Add to Basket'),
              onTap: () {
                print('The chosen is' + capacity.toString());
                DatabaseProvider.db
                    .insert(BasketItem(
                        bottleID: widget.combined.bottle.bottleId,
                        sizeID: (_chosen == null)
                            ? sizes.elementAt(0).sizeId
                            : _chosen.sizeId,
                        bottleCount: count))
                    .then((value) {
                  print('adding ' + value.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
