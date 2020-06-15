import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/ui/homeNav.dart';

class NewAddress extends StatefulWidget {
  final bool toHome;

  NewAddress({@required this.toHome});

  @override
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  String _suburb;
  List<String> names = [
    'kilimani',
    'runda',
    'nyari - Gigiri',
    'Lower Kabete',
    'muthaiga',
    'karen',
    'Nairobi West',
    'South B',
    'South C',
    'Upper Hill',
    'langata',
    'Lavington',
    'muthangari',
    'stateHouse',
    'WestLands',
    'Kileleshwa',
    'parklands',
    'RidgeWays',
    'Garden Estate',
    'Rossyln',
    'Spring Valley',
    'Loresho',
    'Rongai'
  ];
  TextEditingController street,
      apartmentName,
      houseNumber,
      additionalInstructions;
  bool hovering;

  @override
  void initState() {
    hovering = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> suburbs = new List();
    names.sort((string1, string2) {
      return string1.toLowerCase().compareTo(string2.toLowerCase());
    });
    names.forEach((name) {
      suburbs.add(DropdownMenuItem(
        child: Text(name),
        value: name,
      ));
    });
    street = TextEditingController();
    apartmentName = TextEditingController();
    houseNumber = TextEditingController();
    additionalInstructions = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: (widget.toHome == false) ? false : true,
        title: Text(
          'Add New Address',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'address',
            style: TextStyle(),
            textAlign: TextAlign.left,
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  DropdownButton(
                    items: suburbs,
                    onChanged: (value) {
                      setState(() {
                        _suburb = value;
                      });
                    },
                    value: _suburb,
                    isExpanded: true,
                    hint: Text('choose suburb'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black38)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Street / close'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black38)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Apartment Name'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black38)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Apartment Number'),
                    ),
                  ),
                ],
              ),
            ),
            margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
          ),
          Text('Additional instructions'),
          Card(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Additional instructions',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              maxLines: 4,
              maxLength: 50,
            ),
          ),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.currentUser().then((value) {
                var doc = Firestore.instance
                    .collection('users')
                    .document(value.uid)
                    .collection('address')
                    .document();
                Location.instance.getLocation().then((value) {
                  doc
                      .setData(Address(
                              addressId: doc.documentID,
                              suburb: _suburb,
                              street: street.text,
                              apartmentName: apartmentName.text,
                              houseNumber: houseNumber.text,
                              additionalInstructions:
                                  additionalInstructions.text,
                              longitude: value.longitude,
                              latitude: value.latitude)
                          .toMap())
                      .whenComplete(() {
                    (widget.toHome == true)? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeNav())) : Navigator.pop(context);
                  });
                });
              });
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: CommonColors.primary,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: CommonColors.primary)),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
    );
  }
}
