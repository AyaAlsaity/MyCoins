import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/coins_provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../providers/get_from_fire_storge_provider.dart';
import 'details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isOk1 = true;

  var data;

  getFavorites() async {
    data = await firestore
        .collection('favorites')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .get();
    setState(() {});
    
  }

  @override
  void initState() {
   
    getFavorites();
     super.initState();
    // Provider.of<FireStorgeProvoder>(context, listen: false).getFavoritesScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;

    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          color: mainColor,
          backgroundColor: themeListener.isDark
              ? darkBackroundContinarColor
              : secondeyTextColor,
          onRefresh: () async {
            // Provider.of<FireStorgeProvoder>(context, listen: false).getFavoritesScreen();
            // initState();
          },
          child: 
          // Provider.of<FireStorgeProvoder>(context, listen: true).
          data == null
              ? Center(
                  child: Text(
                    textAlign:TextAlign.center,
                    AppLocalizations.of(context)!.favot,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => DetailsScreen(
                                        coinHome:
                                            coinsConsumer.coinsList[index],
                                        index: index,
                                      )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: size.width / 4,
                          decoration: BoxDecoration(
                              color: themeListener.isDark
                                  ? darkBackroundContinarColor
                                  : secondeyTextColor,
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    coinsConsumer
                                        .coinsList[
                                            data.docs[index].data()['index']]
                                        .image,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                Text(
                                  '${coinsConsumer.coinsList[data.docs[index].data()['index']].name} (${coinsConsumer.coinsList[data.docs[index].data()['index']].symbol})',
                                  style: TextStyle(
                                      color: themeListener.isDark
                                          ? darktitleColor
                                          : mainTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ ${coinsConsumer.coinsList[data.docs[index].data()['index']].currentPrice.toString()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  itemCount: data.docs.length,
                ),
        ),
      );
    });
  }
}
