import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunywe/background/viewModel.dart';

import 'model.dart';

Future<List<Combined>> getCombined(ViewModel viewModel) async {
  List<Combined> list = new List();
  var snaps = await Firestore.instance.collection('products').getDocuments();
  snaps.documents.forEach((bottle) async {
    Bottle _bottle = Bottle.fromMap(bottle.data);
    PreParedBottle preParedBottle = PreParedBottle(
        bottleId: _bottle.bottleId,
        bottleName: _bottle.bottleName,
        description: _bottle.description,
        image: NetworkImage(_bottle.pictureUrl),
    category: _bottle.category);
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
  return list;
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

Future<bool> checkActiveOrders(ViewModel viewModel) async {
  Firestore.instance.collection('active').getDocuments().then((value) {
    List<ActiveOrder> list = new List();
    value.documents.forEach((element) {
      PlacedOrder placedOrder = PlacedOrder.fromMap(element.data);
      Firestore.instance
          .collection('active')
          .document(element.documentID)
          .collection('bottles')
          .getDocuments()
          .then((ds) {
        List<BasketItem> basket = new List();
        ds.documents.forEach((element2) {
          BasketItem basketItem = BasketItem.fromMap(element2.data);
          basket.add(basketItem);
        });
        list.add(ActiveOrder(order: placedOrder, list: basket));
      });
    });
    viewModel.orders = list;
  });
  return true;
}

initialize(BuildContext context) async {
  ViewModel viewModel = Provider.of<ViewModel>(context, listen: false);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  redoFunction(viewModel);
  viewModel.user = user;
  viewModel.preferences = preferences;
  checkActiveOrders(viewModel);
  getAddresses(viewModel);
  // getCombined(viewModel);
}

Future<List<Address>> getAddresses(ViewModel viewModel) async {
  List<Address> list = new List();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  (user != null)
      ? Firestore.instance
          .collection('users')
          .document(user.uid)
          .collection('address')
          .getDocuments()
          .then((value) {
          value.documents.forEach((element) {
            list.add(Address.fromMap(element.data));
            print('at function ' + list.length.toString());
          });
          print('at second function ' + list.length.toString());
        })
      : print('user null');
  print('at last function ' + list.length.toString());
  viewModel.addressList = list;
  print('Address list length ' + list.length.toString());
  return list;
}

switchOder(PlacedOrder placedOrder) async {
  var doc =
      Firestore.instance.collection('active').document(placedOrder.orderId);
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  doc.collection('bottle').getDocuments().then((value) {
    var doc2 = Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('previous')
        .document(placedOrder.orderId);
    doc2.setData(placedOrder.toMap());
    value.documents.forEach((element) {
      doc2.collection('bottles').add(element.data);
    });
    doc.delete();
    doc.collection('bottles').getDocuments().then((value) {
      value.documents.forEach((element) {
        element.reference.delete();
      });
    });
  });
}

redoFunction(ViewModel viewModel) {
  debugPrint('function called');
  Firestore fireStore = Firestore.instance;
  List<Combined> bottleList = new List();
  fireStore.collection('products').getDocuments().then((snapshot) {
    snapshot.documents.forEach((element) {
      Bottle bottle = Bottle.fromMap(element.data);
      PreParedBottle preParedBottle = PreParedBottle(
          bottleId: bottle.bottleId,
          bottleName: bottle.bottleName,
          description: bottle.description,
          image: (bottle.pictureUrl == null)
              ? NetworkImage(
                  'https://images.unsplash.com/photo-1592466509322-3318a3d907d0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1208&q=80')
              : NetworkImage(bottle.pictureUrl),
      category: bottle.category);
      List<BottleSize> list = new List();
      fireStore
          .collection('products')
          .document(element.documentID)
          .collection('prices')
          .getDocuments()
          .then((value) {
        value.documents.forEach((ds) {
          BottleSize size = BottleSize.fromMap(ds.data);
          list.add(size);
          debugPrint('Size list length ' + list.length.toString());
        });
        bottleList.add(Combined(preParedBottle, list));
        debugPrint(bottleList.length.toString());
      });
    });
  });
  viewModel.combinedList = bottleList;
  // viewModel.combinedList = bottleList;
}
