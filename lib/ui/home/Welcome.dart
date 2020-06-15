import 'package:flutter/material.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/ui/login/Signup.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool active;
  @override
  void initState() {
//    ViewModel viewModel = Provider.of<ViewModel>(context);
//    if(viewModel.user == null){
//      active = false;
//    } else {
//      checkActiveOrders(viewModel).then((value){
//        setState(() {
//          active = value;
//        });
//      });
//    }
  active = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
   // ViewModel viewModel = Provider.of<ViewModel>(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: themeData.appBarTheme.color,
          expandedHeight: 150,
          leading: Container(),
          title: Text(
            'Tunywe Drinks',
            style: Theme.of(context).textTheme.headline4,
          ),
          pinned: true,
          bottom: PreferredSize(
            preferredSize: Size(size.width, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (active == false)? RaisedButton.icon(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp())),
                        icon: Icon(Icons.input),
                        label: Text('Sign in'),
                    color: Colors.transparent,disabledElevation: 0,elevation: 0,) : Container(),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.mail_outline),
                          Text(' Inbox'),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(icon: Icon(Icons.account_circle), onPressed: null)
              ],
            ),
          ),
          elevation: 30,
        ),
        (active == false)? SliverToBoxAdapter() : SliverToBoxAdapter(
          child: Card(
            margin: EdgeInsets.all(10),
            child: FlatButton(onPressed: null, child: Container(
              height: 100,
              width: size.width,
              alignment: Alignment.center,
              child: Text('Track your Order'),
            ),)
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
                  Text(
                      'Join to recieve offers on alcohol and be the first to know when we add a new product')
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image1.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image2.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image3.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image4.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image5.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image6.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image7.jpg',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'New Items',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Praesent aliquet quam ipsum, non rutrum nunc feugiat sed. '
                    'Praesent imperdiet dictum pretium. Nulla eget augue urna. ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CommonColors.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Text('View'),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}