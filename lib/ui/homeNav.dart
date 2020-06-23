import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/home/Welcome.dart';

import 'home/Order.dart';
import 'home/Profile.dart';

class HomeNav extends StatefulWidget {
  final int goTo;

  HomeNav({this.goTo});

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _selectedIndex;

  @override
  void initState() {
    (widget.goTo == null) ? _selectedIndex = 0 : _selectedIndex = widget.goTo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    List<Widget> _widgetOptions = [
      Welcome(Provider.of<ViewModel>(context)),
      Consumer<ViewModel>(
        builder: (context, notifier, child) {
          return Order();
        },
        child: Order(),
      ),
//      Consumer<ViewModel>(
//        builder: (context, notifier, child) {
//          return Search();
//        },
//        child: Search(),
      //     ),
      Consumer<ViewModel>(builder: (a, b, c) => Profile())
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: themeData.cardColor, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: themeData.accentColor,
                tabs: [
                  GButton(
                    icon: LineAwesomeIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineAwesomeIcons.glass,
                    text: 'Order',
                  ),
//                  GButton(
//                    icon: LineAwesomeIcons.search,
//                    text: 'Search',
//                  ),
                  GButton(
                    icon: LineAwesomeIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
    );
  }
}
