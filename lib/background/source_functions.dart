import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunywe/background/viewModel.dart';

import 'model.dart';

Future<bool> getCombined(ViewModel viewModel) async {
  List<Combined> list = new List();
  var snaps = await Firestore.instance.collection('products').getDocuments();
  snaps.documents.forEach((bottle) async {
    Bottle _bottle = Bottle.fromMap(bottle.data);
    PreParedBottle preParedBottle = PreParedBottle(
        bottleId: _bottle.bottleId,
        bottleName: _bottle.bottleName,
        description: _bottle.description,
        image: NetworkImage(_bottle.pictureUrl));
    var snap2 = await Firestore.instance
        .collection('products')
        .document(bottle.documentID)
        .collection('prices')
        .getDocuments();
    List<BottleSize> sizes = new List();
    snap2.documents.forEach((element) {
      sizes.add(BottleSize.fromMap(element.data));
    });
    list.add(Combined(preParedBottle, sizes));
  });

  viewModel.combinedList = list;
  return true;
}

Future<List<PreviousOrder>> getPreviousBottle(ViewModel viewModel) async {
  List<PreviousOrder> list = new List();
  var snaps = await Firestore.instance
      .collection('User')
      .document(viewModel.preferences.get(MapNames.uid))
      .collection('previousOrders')
      .getDocuments();

  snaps.documents.forEach((element) async {
    List<BasketBottle> bottles = new List();
    PreviousOrder first = PreviousOrder.fromMap(element.data);
    var snaps2 = await Firestore.instance
        .collection('User')
        .document(viewModel.preferences.get(MapNames.uid))
        .collection('previousOrders')
        .document(element.documentID)
        .collection('Bottles')
        .getDocuments();
    snaps2.documents.forEach((ds) {
      bottles.add(BasketBottle.fromMap(ds.data));
    });
    PreviousOrder finale = PreviousOrder(first.orderId, first.totalCost,
        first.orderTime, first.bottleCount, bottles);
    list.add(finale);
  });
  viewModel.previousOrderList = list;
  return list;
}

initialize(BuildContext context) async {
  ViewModel viewModel = Provider.of<ViewModel>(context, listen: false);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  viewModel.user = user;
  viewModel.preferences = preferences;
  getCombined(viewModel);
}

Future<List<Address>>getAddresses(ViewModel viewModel) async {
  List<Address> list = new List();
  var doc = Firestore.instance
      .collection('users')
      .document(viewModel.user.uid)
      .collection('address');
  doc.getDocuments().then((value) {
    value.documents.forEach((element) {
      list.add(Address.fromMap(element.data));
    });
  });
  return list;
}
