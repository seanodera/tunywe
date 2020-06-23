import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/home/order/TrackOrder.dart';
import 'package:tunywe/ui/homeNav.dart';
import 'package:tunywe/ui/login/Signup.dart';

class Welcome extends StatefulWidget {
  final ViewModel viewModel;

  Welcome(this.viewModel);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool active;

  @override
  void initState() {
    active = widget.viewModel.orders.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    print('orders ' + widget.viewModel.orders.length.toString());
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: themeData.appBarTheme.color,
          leading: Container(),
          title: Text(
            'Tunywe Drinks',
            style: Theme.of(context).textTheme.headline4,
          ),
          pinned: true,
          bottom: PreferredSize(
            preferredSize: Size(size.width, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (widget.viewModel.user == null)
                    ? IconButton(
                        icon: Icon(LineAwesomeIcons.user_plus),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Consumer<ViewModel>(
                                    builder: (a, b, c) => SignUp()))))
                    : IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Consumer<ViewModel>(
                                    builder: (a, b, c) => HomeNav(
                                          goTo: 3,
                                        ))))),
              ],
            ),
          ),
          elevation: 30,
        ),
        (widget.viewModel.orders.isEmpty == true)
            ? SliverToBoxAdapter()
            : SliverToBoxAdapter(
                child: Card(
                    margin: EdgeInsets.all(10),
                    child: FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Consumer<ViewModel>(
                                  builder: (a, b, c) =>
                                      TrackOrder(widget.viewModel.orders)))),
                      child: Container(
                        height: 100,
                        width: size.width,
                        alignment: Alignment.center,
                        child: Text('Track your Order'),
                      ),
                    )),
              ),
        SliverToBoxAdapter(
          child: Container(
            width: size.width,
            margin: EdgeInsets.all(10),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image1.jpg'),
                            fit: BoxFit.fitWidth)),
                    height: (size.width * 9) / 16,
                    child: Icon(
                      Icons.add_circle_outline,
                      size: (0.25 * size.width),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                  ),
                  Text(
                    'Suggestions',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Not Seeing your favourite drinks? '
                    'Suggest them Here',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RaisedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController name = TextEditingController(),
                            sizeText = TextEditingController();
                        return Material(
                          child: Container(
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: size.width,
                                height: (size.width * 9) / 16,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Bottle Name here'),
                                      controller: name,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextField(
                                      decoration:
                                          InputDecoration(hintText: 'Size'),
                                      controller: sizeText,
                                      textAlign: TextAlign.center,
                                    ),
                                    RaisedButton(
                                      color: CommonColors.primary,
                                      onPressed: () {
                                        Firestore.instance
                                            .collection('suggestions')
                                            .add({
                                          'name': name.text,
                                          'size': sizeText.text,
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text('add'),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                          color: Colors.transparent,
                        );
                      },
                      useSafeArea: true,
                    ),
                    child: Text('add a suggestion'),
                  )
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: size.width,
            margin: EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    'assets/giphy.gif',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
