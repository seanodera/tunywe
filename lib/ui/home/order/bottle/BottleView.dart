import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/localDb.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';

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

    ViewModel viewModel = Provider.of<ViewModel>(context, listen: false);
    ThemeData themeData = Theme.of(context);
    print(sizes.length);
    return Container(
      child: CustomScrollView(slivers: [
        SliverAppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
          pinned: true,
          expandedHeight: size.width,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: bottle.image, fit: BoxFit.fitWidth),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: Text(
              bottle.bottleName,
              style: themeData.textTheme.headline4,
            ),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 5),
          ),
        ),
        SliverToBoxAdapter(
          child: (viewModel.user == null)
              ? Card(
            child: Container(
              child: Text(
                'For you to save the basket you have to sign in or register an account with us',
                style: themeData.textTheme.caption,
              ),
            ),
          )
              : Container(),
        ),
        SliverToBoxAdapter(
          child: Card(
            child: Column(children: [
              Text('Description: '),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  bottle.description,
                  maxLines: 4,
                ),
              ),
              Text(
                'Options',
                style: themeData.textTheme.headline5,
              ),
              Text('size: '),
              Container(
                child: DropdownButton(
                  items: List.generate(
                      sizes.length,
                          (index) => DropdownMenuItem(
                        child: Text(sizes[index].capacity +
                            ' @ Kes ' +
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
                  value: capacity,
                ),
              ),
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
                      controller: TextEditingController(text: count.toString()),
                    ),
                  ),
                  IconButton(
                      icon: Icon(LineAwesomeIcons.minus),
                      onPressed: () {
                        setState(() {
                          count--;
                        });
                      })
                ],
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
                        sizeID: _chosen.sizeId,
                        bottleCount: count))
                        .then((value) {
                      print('adding ' + value.toString());
                    });
                  },
                ),
              )
            ]),
          ),
        ),
      ]),
      color: Theme.of(context).backgroundColor
      ,
    );
  }
}
