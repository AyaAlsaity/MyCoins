import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../models/currency_model.dart';

class FireStorgeProvoder with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  bool isFailed = false;
  bool isOk = false;
  String name = '';
  String email = '';
  // List<CurrencyModel> currencies = [];
  var data;
  var dataUser;
  // var dataCurrency;

  // CurrencyModel? selectedcurrenc1;

  getFavorites(
    String coinId,
  ) async {
    var dataFavorites = await firestore
        .collection('favorites')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .get();
    for (var i in dataFavorites.docs) {
      if (i.data()['coin_id'] == coinId) {
        isOk = true;
        // addToFaveId(coinId, index);
        // removeFaveId(coinId);
      }
    }
    notifyListeners();
  }

  addToFaveId(
    String coinId,
    int index,
  ) {
    //  getFavorites(coinId);
    firestore.collection('favorites').add({
      'user_id': auth.currentUser!.uid,
      "coin_id": coinId,
      "index": index,
    });
    notifyListeners();
    // getFavorites(coinId);
  }

  removeFaveId(
    String coinId,
  ) async {
    // getFavorites(coinId);
    var deletable = await firestore
        .collection('favorites')
        .where("user_id", isEqualTo: auth.currentUser!.uid)
        .where("coin_id", isEqualTo: coinId)
        .get();
    firestore
        .collection('favorites')
        .doc(deletable.docs.first.id.toString())
        .delete()
        .then((value) {
      isOk = false;
    });
    notifyListeners();
  }

// ///////////////

  getFavoritesScreen() async {
    data = await firestore
        .collection('favorites')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .get();
    notifyListeners();
  }

// ///////////////

  getUser() async {
    dataUser = await firestore
        .collection('users')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .get();
    for (var i = 0; i <= dataUser.docs.length; i++) {
      if (dataUser.docs[i].data()['user_id'] == auth.currentUser!.uid) {
        name = dataUser.docs[i].data()['name'];
        email = dataUser.docs[i].data()['email'];

        break;
      }
    }
    notifyListeners();
  }

  addUserToFire(String name, String email) {
    firestore
        .collection('users')
        .add({'user_id': auth.currentUser!.uid, "name": name, "email": email});
    notifyListeners();
  }

// ///////////////

  // initConversion(){
  //   // await getCurrency();
  //   selectedcurrenc1 = currencies.first;
  //   notifyListeners();
  // }

  // getCurrency() async {
  //   dataCurrency = await firestore.collection('currency').get();
  //   for (var i in dataCurrency.docs) {
  //     currencies.add(
  //       CurrencyModel(
  //         id: i,
  //         name: dataCurrency.docs[i].data()['code'],
  //         price: dataCurrency.docs[i].data()['price'],
  //       ),
  //     );
  //   }
  //   notifyListeners();
  // }

  // setSelectedCurrencyOne(CurrencyModel? currency) {
  //   selectedcurrenc1 = currency;
  //   notifyListeners();
  // }
}
