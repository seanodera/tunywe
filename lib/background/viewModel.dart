import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class ViewModel with ChangeNotifier {

  List<PlacedOrder> _orders = new List();
  Bottle _currentBottle;
  List<Combined> _combinedList = new List();
  Combined _combo;
  SharedPreferences _preferences;
  List<PreviousOrder> _previousOrderList = new List();
  List<BasketItem> _basket = new List();
  FirebaseUser _user;

  UnmodifiableListView<BasketItem> get basket =>
      UnmodifiableListView(_basket);

  UnmodifiableListView<PreviousOrder> get previousOrderList =>
      UnmodifiableListView(_previousOrderList);

  UnmodifiableListView<PlacedOrder> get orders => UnmodifiableListView(_orders);
  UnmodifiableListView<Combined> get combinedList =>
      UnmodifiableListView(_combinedList);

  Bottle get currentBottle => _currentBottle;

  Combined get combo => _combo;

  SharedPreferences get preferences => _preferences;

  FirebaseUser get user => _user;

  set orders(List<PlacedOrder> orders){
    this._orders = orders;
    notifyListeners();
  }

  set user(FirebaseUser user) {
    this._user = user;
    notifyListeners();
  }

  set combinedList(List<Combined> capacityList) {
    this._combinedList = capacityList;
    notifyListeners();
  }

  set currentBottle(Bottle bottle) {
    this._currentBottle = bottle;
    notifyListeners();
  }

  set combo(Combined capacities) {
    this._combo = capacities;
    notifyListeners();
  }

  set preferences(SharedPreferences preferences) {
    this._preferences = preferences;
    notifyListeners();
  }

  set previousOrderList(List<PreviousOrder> previousOrderList) {
    this._previousOrderList = previousOrderList;
    notifyListeners();
  }

  set basket(List<BasketItem> basket) {
    this._basket = basket;
    notifyListeners();
  }
}
