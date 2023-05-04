import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../main_screens/notifications_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  bool isOk1 = true; //
   QuerySnapshot? listFavorites;
   DocumentSnapshot? listcoins;
   Future<DocumentSnapshot<Object?>?> getFavorites() async {
     listFavorites=await firestore.collection('favorites').get();
     for (var coin in listFavorites!.docs) {
       listcoins=coin;
      }
      return listcoins;
  }
  @override
  void initState() {
   
    super.initState();
     listcoins=getFavorites() as DocumentSnapshot<Object?>?;
  }
  @override
  Widget build(BuildContext context) {
    
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
     Size size = MediaQuery.of(context).size;
     
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: darkBackroundScreenColor,
          ),
        ),
     
      body: RefreshIndicator(
        color: mainColor,
        backgroundColor: themeListener.isDark
            ? darkBackroundContinarColor
            : secondeyTextColor,
        onRefresh: () async {
          //
          
        },
          child:listcoins==null?
          Center(
            child: Text("Not found favotrites",
             style: TextStyle(
                      fontSize: 20,
                      color: themeListener.isDark ? darktitleColor : mainTextColor,
                    ),
            ),
          )
          :ListView.builder(
            
            itemBuilder:((context, index){
              return Container(
              width: double.infinity,
              height: size.width/4,
              decoration: BoxDecoration(
                  color: themeListener.isDark
                      ? darkBackroundContinarColor
                      : secondeyTextColor,
                  borderRadius: BorderRadius.circular(24)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                 listcoins!.get('image').toString(),
                  width: 40,
                  height: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                const SizedBox(
              height: 15,
            ),
            
                  Row(
                    children: [
                       Text(
               listcoins!.get('name').toString(),
              style: TextStyle(
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
                      Text(
                         listcoins!.get('symbol').toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: themeListener.isDark ? darktitleColor : mainTextColor,
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(
              height: 5,
            ),
                  Text(
                    '\$${ listcoins!.get('current_price').toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: themeListener.isDark ? darktitleColor : mainTextColor,
                    ),
                  ),
              ],
            ),
             IconButton(
            onPressed: () {
              // setState(() {
              //   isOk1 = !isOk1;
              // });
            },
            icon: Icon(
              isOk1 ?Icons.star_border_outlined: Icons.star ,
              color: mainColor,
            ),
          ),
          ],
        ),
                ),
        
            );
                            
              
            }) ,
             itemCount: listFavorites!.docs.length,
           
          ),  
            
      ),
    );
  }
}


        