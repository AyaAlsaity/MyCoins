

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({super.key});

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Shimmer.fromColors(
              period: Duration(seconds: 2),
              baseColor: Colors.grey.withOpacity(0.25),
              highlightColor: Colors.white.withOpacity(0.6),
              //Localization =>
              direction: ShimmerDirection.ltr,
              child: Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.9)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 120,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  period: Duration(seconds: 2),
                  baseColor: Colors.grey.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.6),
                  child: Container(
                      margin: EdgeInsets.all(15),
                      height: 90,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.9))),
                );
              },
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 26,
                          child: Shimmer.fromColors(
                            period: Duration(seconds: 2),
                            baseColor: Colors.grey.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.6),
                            child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.withOpacity(0.9))),
                          )),
                      Expanded(flex: 3, child: Text("")),
                      Expanded(
                          flex: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                period: Duration(seconds: 2),
                                baseColor: Colors.grey.withOpacity(0.25),
                                highlightColor: Colors.white.withOpacity(0.6),
                                child: Container(
                                    height: 16,
                                    width: 220,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.withOpacity(0.9))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Shimmer.fromColors(
                                period: Duration(seconds: 2),
                                baseColor: Colors.grey.withOpacity(0.25),
                                highlightColor: Colors.white.withOpacity(0.6),
                                child: Container(
                                    margin: EdgeInsets.all(12),
                                    height: 16,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.withOpacity(0.9))),
                              )
                            ],
                          )),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

//////////////////////////Home Shimmer  Widget//////////////////////////////

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        Container(
          height: 120,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                period: Duration(seconds: 2),
                baseColor: Colors.grey.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.6),
                child: Container(
                  width: double.infinity,
          
                  decoration: BoxDecoration(
                    color: themeListener.isDark
                        ? darkBackroundContinarColor
                        : lightBackroundBottomNavigationBarColor
                            .withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        flex: 26,
                        child: Shimmer.fromColors(
                          period: Duration(seconds: 2),
                          baseColor: Colors.grey.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.6),
                          child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.9))),
                        )),
                    Expanded(flex: 3, child: Text("")),
                    Expanded(
                        flex: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                              period: Duration(seconds: 2),
                              baseColor: Colors.grey.withOpacity(0.25),
                              highlightColor: Colors.white.withOpacity(0.6),
                              child: Container(
                                  height: 16,
                                  width: 220,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withOpacity(0.9))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Shimmer.fromColors(
                              period: Duration(seconds: 2),
                              baseColor: Colors.grey.withOpacity(0.25),
                              highlightColor: Colors.white.withOpacity(0.6),
                              child: Container(
                                  margin: EdgeInsets.all(12),
                                  height: 16,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withOpacity(0.9))),
                            )
                          ],
                        )),
                  ],
                ),
              );
            })
      ],
    );
  }
}
