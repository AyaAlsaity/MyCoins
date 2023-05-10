import 'package:flutter/material.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:mycoins/providers/coins_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/carrenci_colum_data.dart';
import '../../widgets/static_widgets/appBar_widget.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../../widgets/static_widgets/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<CoinsProvider>(context, listen: false).getCoins();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return Scaffold(
          appBar: AppBarWidget(
            context,
          ),
          drawer: const CustomDrawer(),
          body: RefreshIndicator(
            color: mainColor,
            backgroundColor: themeListener.isDark
                ? darkBackroundContinarColor
                : secondeyTextColor,
            onRefresh: () async {
              Provider.of<CoinsProvider>(context, listen: true).getCoins();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  coinsConsumer.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox(
                          height: 20,
                        ),
                  const SliderWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  !coinsConsumer.isFailed
                      ? SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: AnimatedSwitcher(
                                duration: Duration(seconds: 1),
                                child:
                                    // coinsConsumer.isLoading
                                    //     ? Column(
                                    //         children: [
                                    //           ShimmerWudget(
                                    //             baseColor: darkBackroundScreenColor,
                                    //             height: 30,
                                    //             hilighColor: mainColor,
                                    //             radius: 10,
                                    //             width: double.infinity,
                                    //           ),

                                    //         ],
                                    //       )
                                    //     :
                                    CarrenciColumData(),
                              )))
                      : SizedBox(
                          height: size.height * 1.01,
                          child: const Center(child: Text('FAILED'))),
                ],
              ),
            ),
          ));
    });
  }
}
