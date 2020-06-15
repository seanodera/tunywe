import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/source_functions.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/login/Address.dart';

import 'Checkout.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  List<Address> addressList;

  @override
  void initState() {
    getAddresses(Provider.of<ViewModel>(context)).then((value) {
      setState(() {
        addressList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: (addressList == null)
          ? [
              SliverToBoxAdapter(
                child: CircularProgressIndicator(
                  backgroundColor: CommonColors.primary,
                ),
              )
            ]
          : (addressList.isEmpty)? [
            SliverToBoxAdapter(
              child: Text('No addresses found'),
            ),
        SliverToBoxAdapter(
          child: RaisedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewAddress(toHome: false,))),
              icon: Icon(Icons.add),
              label: Text('Add Address')),
        )
      ] : [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                Address address = addressList[index];
                return ListTile(
                  leading: Text(address.suburb),
                  title:
                      Text(address.apartmentName + ' - ' + address.houseNumber),
                  subtitle: Text(address.street),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consumer<ViewModel>(
                              builder: (a, b, c) => Checkout(address: address,)))),
                );
              }, childCount: addressList.length)),
              SliverToBoxAdapter(
                child: RaisedButton.icon(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewAddress(toHome: false,))),
                    icon: Icon(Icons.add),
                    label: Text('Add Address')),
              ),
            ],
    );
  }
}
