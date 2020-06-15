import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';
import 'package:tunywe/background/localDb.dart';

class TunyweColors {
  TunyweColors._();
}

class MapNames {
  MapNames._();

  static const String orderId = 'order id';
  static const String totalCost = 'total cost';
  static const String orderTime = 'order time';
  static const String status = 'order status';
  static const String paymentMethod = 'payment method';
  static const String riderId = 'rider id';
  static const String bottleId = 'bottle id';
  static const String sizeId = 'size id';
  static const String bottleName = 'bottle name';
  static const String description = 'description';
  static const String pictureUrl = 'image';
  static const String capacity = 'capacity';
  static const String price = 'price';
  static const String stockCount = 'stock count';
  static const String bottleCount = 'bottle count';
  static const String uid = 'uid';
  static const String firstName = 'first name';
  static const String secondName = 'second name';
  static const String email = 'email';
  static const String dateOfBirth = 'date of birth';
  static const String lastLogin = 'last Login';
  static const String orderCount = 'order Count';
  static const String category = 'category';
  static const String address = 'address';
}

class Types {
  String className;
  String pictureUrl;

  Types(this.className, this.pictureUrl);
}

class PlacedOrder {
  String orderId;
  int totalCost;
  String orderTime;
  String status;
  String paymentMethod;
  String rider;
  String addressId;
  String uid;
  List<BasketItem> bottles;

  PlacedOrder(
      {this.orderId,
      this.totalCost,
      this.orderTime,
      this.status,
      this.paymentMethod,
      this.rider,
      this.addressId,
      this.bottles,
      this.uid});

  Map<String, dynamic> toMap() => {
        MapNames.orderId: this.orderId,
        MapNames.totalCost: this.totalCost,
        MapNames.orderTime: this.orderTime,
        MapNames.status: this.status,
        MapNames.paymentMethod: this.paymentMethod,
        MapNames.riderId: this.rider,
        MapNames.address: this.addressId,
        MapNames.uid: this.uid,
      };

  PlacedOrder.fromMap(Map<String, dynamic> data) {
    this.orderId = data[MapNames.orderId];
    this.totalCost = data[MapNames.totalCost];
    this.orderTime = data[MapNames.orderTime];
    this.status = data[MapNames.status];
    this.paymentMethod = data[MapNames.paymentMethod];
    this.rider = data[MapNames.riderId];
    this.addressId = data[MapNames.address];
    this.uid = data[MapNames.uid];
  }
}

class Bottle {
  String bottleId;
  String bottleName;
  String description;
  String pictureUrl;

  Bottle.fromMap(Map<String, dynamic> data) {
    this.bottleId = data[MapNames.bottleId];
    this.bottleName = data[MapNames.bottleName];
    this.description = data[MapNames.description];
    this.pictureUrl = data[MapNames.pictureUrl];
  }
}

class PreParedBottle {
  String bottleId;
  String bottleName;
  String description;
  NetworkImage image;

  PreParedBottle(
      {this.bottleId, this.bottleName, this.description, this.image});
}

class BottleSize {
  String sizeId;
  String capacity;
  String price;
  int stockCount;

  BottleSize.fromMap(Map<String, dynamic> data) {
    this.sizeId = data[MapNames.sizeId];
    this.capacity = data[MapNames.capacity];
    this.price = data[MapNames.price];
    this.stockCount = data[MapNames.stockCount];
  }
}

class Combined {
  PreParedBottle bottle;
  List<BottleSize> bottleSizes;

  Combined(this.bottle, this.bottleSizes);
}

class UserDetails {
  String uid;
  String firstName;
  String secondName;
  String email;
  String dateOfBirth;

  UserDetails.fromMap(Map<String, dynamic> data) {
    this.uid = data[MapNames.uid];
    this.firstName = data[MapNames.firstName];
    this.secondName = data[MapNames.secondName];
    this.email = data[MapNames.email];
    this.dateOfBirth = data[MapNames.dateOfBirth];
  }

  Map<String, dynamic> toMap() => {
        MapNames.uid: this.uid,
        MapNames.firstName: this.firstName,
        MapNames.secondName: this.secondName,
        MapNames.email: this.email,
        MapNames.dateOfBirth: this.dateOfBirth,
      };

  UserDetails(
      this.uid, this.email, this.firstName, this.secondName, this.dateOfBirth);
}

class BasketBottle {
  String bottleId;
  String sizeId;

  BasketBottle(this.bottleId, this.sizeId);

  BasketBottle.fromMap(Map<String, dynamic> data) {
    this.bottleId = data[MapNames.bottleId];
    this.sizeId = data[MapNames.sizeId];
  }

  Map<String, dynamic> toMap() => {
        MapNames.bottleId: this.bottleId,
        MapNames.sizeId: this.sizeId,
      };
}

class PreviousOrder {
  String orderId;
  String totalCost;
  String bottleCount;
  String orderTime;
  List<BasketBottle> bottles;

  PreviousOrder.fromMap(Map<String, dynamic> data) {
    this.orderId = data[MapNames.orderId];
    this.totalCost = data[MapNames.totalCost];
    this.bottleCount = data[MapNames.bottleCount];
    this.orderTime = data[MapNames.orderTime];
  }

  PreviousOrder(this.orderId, this.totalCost, this.orderTime, this.bottleCount,
      this.bottles);
}

class CommonColors {
  static final Color accent = Color.fromARGB(100, 150, 276, 675);
  static final Color accentHex = HexColor('E54DDB');
  static final Color primary = HexColor('BA06AD');
  static final Color customGrey = HexColor('707070');
  static final Color backgroundGrey = HexColor('262626');
  static final Color otherGrey = Colors.grey[800];

  CommonColors._();
}

class Address {
  String addressId;
  String suburb;
  String street;
  String apartmentName;
  String houseNumber;
  String additionalInstructions;
  double longitude;
  double latitude;

  Address(
      {this.addressId,
      this.suburb,
      this.street,
      this.apartmentName,
      this.houseNumber,
      this.additionalInstructions,
      this.longitude,
      this.latitude});

  Map<String, dynamic> toMap() => {
        'id': this.addressId,
        'suburb': this.suburb,
        'street': this.street,
        'apartment Name': this.apartmentName,
        'hse Number': this.houseNumber,
        'other': additionalInstructions,
        'long': longitude,
        'lat': latitude,
      };
  Address.fromMap(Map<String, dynamic> data){
    this.addressId = data['id'];
    this.suburb = data['suburb'];
    this.street = data['street'];
    this.apartmentName = data['apartment Name'];
    this.houseNumber = data['hse Number'];
    this.additionalInstructions = data['other'];
    this.longitude = data['long'];
    this.latitude = data['lat'];
  }

}

class BasketItem {
  String bottleID, sizeID;
  int bottleCount;

  BasketItem({this.bottleID, this.sizeID, this.bottleCount});

  Map<String, dynamic> toMap() => {
        DatabaseProvider.ColumnBottleID: this.bottleID,
        DatabaseProvider.ColumnSizeID: this.sizeID,
        DatabaseProvider.ColumnCount: this.bottleCount,
      };

  BasketItem.fromMap(Map<String, dynamic> data) {
    this.bottleID = data[DatabaseProvider.ColumnBottleID];
    this.sizeID = data[DatabaseProvider.ColumnSizeID];
    this.bottleCount = data[DatabaseProvider.ColumnCount];
  }
}
