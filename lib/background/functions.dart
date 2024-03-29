import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model.dart';

listProcess() {
  List<Types> typesList;
  typesList = new List();
  Types whiskey = new Types('whiskey', 'assets/whiskey.png');
  Types vodka = new Types('Vodka', 'assets/vodka.png');
  Types cognac = new Types('Cognac', 'assets/cognac.png');
  Types gin = new Types('Gin', 'assets/gin.png');
  Types rum = new Types('Rum', 'assets/rum.png');
  Types tequila = new Types('Tequila', 'assets/tequilla.png');
  Types wine = new Types('Wines', 'assets/wine.png');
  Types beer = new Types('Beer', 'assets/beer.png');
  Types liqueur = Types('Liqueur', 'assets/liqueur.png');
  typesList.add(whiskey);
  typesList.add(vodka);
  typesList.add(cognac);
  typesList.add(gin);
  typesList.add(rum);
  typesList.add(tequila);
  typesList.add(wine);
  typesList.add(beer);
  typesList.add(liqueur);
  return typesList;
}

postOrder(PlacedOrder order) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  var collection = Firestore.instance.collection('Active Orders').document();
  collection
      .setData(PlacedOrder(
              orderId: collection.documentID,
              orderTime: DateTime.now().toString(),
              totalCost: order.totalCost,
              status: 'Awaiting Confirmation',
              paymentMethod: order.paymentMethod,
              rider: 'unassigned',
              addressId: order.addressId,
              uid: user.uid)
          .toMap())
      .then((value) {
    order.bottles.forEach((element) {
      collection.collection('bottles').add(element.toMap());
    });
  });
}
