import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helpers/consts.dart';
import '../../screen/sub_screens/search_screen.dart';

PreferredSizeWidget AppBarWidget(BuildContext context){
  return  AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: darkBackroundScreenColor,
        ),
        title: const Text(
          "My Coins",
          style: TextStyle(
              color: mainColor, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
                height: 30,
                width: 30,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const CoinSearchScreen()));
                    },
                    child: const Icon(Icons.search))),
          )
        ],
      );
  
}
 