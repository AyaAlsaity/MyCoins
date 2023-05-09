import 'package:flutter/material.dart';
import 'package:mycoins/models/coins_model.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../models/currency_model.dart';
import '../../providers/coins_provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/input_widgets/text_form_field.dart';
import '../../widgets/static_widgets/appBar_widget.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  // late double rate;
  String result = "0";
  TextEditingController rateController = TextEditingController();

  conversionProcess(String rat, double from, double to) {
    String op = (double.parse(rat.toString().trim()) * from * to).toString();
    setState(() {
      result = op;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, child) {
      return Scaffold(
          appBar: AppBarWidget(
            context,
          ),
          drawer: const CustomDrawer(),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(" Coins Conversion",
                        style: TextStyle(
                            color: themeListener.isDark
                                ? secondeyTextColor
                                : Colors.black87,
                            fontSize: 36,
                            fontWeight: FontWeight.bold)),
                    Expanded(
                        child: Center(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFieldWidget(
                            maxLine: 2,
                            controller: rateController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.email3;
                              }
                              // if (!value.contains('@') ||
                              //     !value.contains('.com')) {
                              //   return AppLocalizations.of(context)!.email4;
                              // }
                              return null;
                            },
                            hintText: "Input a value to convert",
                            ispassword: false,
                            keyboardType: TextInputType.number),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      color: themeListener.isDark
                                          ? Colors.white30
                                          : lightBackroundScreenColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<CoinsModel?>(
                                            iconEnabledColor: mainColor,
                                            dropdownColor: themeListener.isDark
                                                ? Colors.white54
                                                : greyTextColor,
                                            style: TextStyle(
                                                color: themeListener.isDark
                                                    ? secondeyTextColor
                                                    : Colors.black87),
                                            items: coinsConsumer.coinsList
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child:
                                                                Image.network(e
                                                                    .image
                                                                    .toString()),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "${e.symbol.toString().toUpperCase()}"),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              Provider.of<CoinsProvider>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedCoinTwo(value);

                                              // setState(() {
                                              //   value = selectedcurrenc2;
                                              // });
                                              // print(
                                              //     "SELECTED IS : ${selectedcurrenc2!.name}");
                                            },
                                            value:
                                                coinsConsumer.selectedcurrenc2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  FloatingActionButton(
                                    onPressed: () {
                                      conversionProcess(
                                          rateController.text,
                                          coinsConsumer.selectedcurrenc1!.price,
                                          coinsConsumer
                                              .selectedcurrenc2!.currentPrice);
                                    },
                                    elevation: 0.0,
                                    backgroundColor: themeListener.isDark
                                        ? Colors.white30
                                        : lightBackroundScreenColor,
                                    child: Icon(
                                      Icons.currency_exchange,
                                      size: 30,
                                      color: mainColor,
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      color: themeListener.isDark
                                          ? Colors.white30
                                          : lightBackroundScreenColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<CurrencyModel?>(
                                            iconEnabledColor: mainColor,
                                            dropdownColor: themeListener.isDark
                                                ? Colors.white54
                                                : greyTextColor,
                                            style: TextStyle(
                                                color: themeListener.isDark
                                                    ? secondeyTextColor
                                                    : Colors.black87),
                                            items: coinsConsumer.currencies1
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        "${e.name}",
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              Provider.of<CoinsProvider>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedCurrencyOne(
                                                      value);
                                              // setState(() {
                                              //   value = selectedcurrenc1;
                                              // });
                                              // print(
                                              //     "SELECTED IS : ${selectedcurrenc1!.name}");
                                            },
                                            value:
                                                coinsConsumer.selectedcurrenc1,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // customDropDown(currencies1, selectedcurrenc1,
                                  //     (val) {
                                  //   setState(() {
                                  //     selectedcurrenc1 = val;
                                  //   });
                                  // }),
                                ])),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            height: 80,
                            width: 400,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                              color: themeListener.isDark
                                  ? Colors.white30
                                  : lightBackroundScreenColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Result : ${result}",
                                  style: TextStyle(
                                      color: themeListener.isDark
                                          ? secondeyTextColor
                                          : Colors.black87,
                                      fontSize: 16),
                                ),
                              ],
                            )),
                      ],
                    )))
                  ]),
            ),
          ));
    });
  }
}
// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:mycoins/models/coins_search_model.dart';

// import 'package:provider/provider.dart';
// import '../../helpers/consts.dart';
// import '../../providers/dark_theme_provider.dart';
// import '../../widgets/static_widgets/appBar_widget.dart';
// import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
// import '../sub_screens/details_screen.dart';
// import '../sub_screens/search_screen.dart';

// class ConversionScreen extends StatefulWidget {
//   const ConversionScreen({super.key});

//   @override
//   State<ConversionScreen> createState() => _ConversionScreenState();
// }

// class _ConversionScreenState extends State<ConversionScreen> {
//   @override
//   Widget build(BuildContext context) {
//         Size size = MediaQuery.of(context).size;
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     return Scaffold(
//       appBar: AppBarWidget(context),
//       drawer: const CustomDrawer(),
//       body:  const Text("Conversion Screen"),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:mycoins/services/api.dart';

// import '../../helpers/consts.dart';
// import '../../widgets/static_widgets/appBar_widget.dart';
// import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

// class ConversionScreen extends StatefulWidget {
//   const ConversionScreen({super.key});

//   @override
//   State<ConversionScreen> createState() => _ConversionScreenState();
// }

// class _ConversionScreenState extends State<ConversionScreen> {
//   ApiClient client = ApiClient();

//   // Future<List<String>> getcurrencyList() async {
//   //   return await client.getcurrencies();
//   // }

//   @override
//   void initState() {
//     super.initState();
//     (() async {
//       List<String> list = await client.getcurrencies();
//       setState(() {
//         currencies = list;
//       });
//     })();
//   }

//   Color mainColor = const Color(0xFF212936);

//   Color mainColor2 = const Color(0xFFF5C249);
//   Color secondColor = const Color(0xFF2849E5);

//   List<String> currencies = [];
//   String? froom;
//   String? to;

//   double rate = 0.0;
//   String result = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: darkBackroundScreenColor,
//         appBar: AppBarWidget(context),
//         drawer: const CustomDrawer(),
//         body: const Center(
//           child: Text(
//             "ConversionScreen",
//             style: TextStyle(color: Colors.white),
//           ),
//         )
        // SafeArea(
        //     child: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(
        //         width: 200.0,
        //         child: Text(
        //           "Currency Converter",
        //           style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 36,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Expanded(
        //           child: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             TextField(
        //                 onSubmitted: (value) async {
        //                   rate = await client.getRate(froom!, to!);
        //                   setState(() {
        //                     // result = (rate * double.parse(value).toStringAsFixed(3)) ;
        //                   });
        //                 },
        //                 textAlign: TextAlign.center,
        //                 keyboardType: TextInputType.number,
        //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        //                 cursorColor: mainColor,
        //                 decoration: InputDecoration(
        //                   contentPadding: const EdgeInsets.symmetric(
        //                       vertical: 13.0, horizontal: 16),
        //                   fillColor: const Color.fromARGB(255, 228, 225, 225),
        //                   filled: true,
        //                   hintText: "Input value to Convert",
        //                   border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(16),
        //                       borderSide:
        //                           BorderSide(color: mainColor2.withOpacity(0.2))),
        //                   focusColor: mainColor2.withOpacity(0.2),
        //                   focusedBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(16),
        //                       borderSide: const BorderSide()),
        //                   enabledBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(16),
        //                       borderSide:
        //                           BorderSide(color: mainColor2.withOpacity(0.2))),
        //                 )

        //                 // InputDecoration(
        //                 //   focusedBorder: OutlineInputBorder(
        //                 //       borderSide: BorderSide(color: mainColor2)),
        //                 //   filled: true,
        //                 //   fillColor: Colors.white,
        //                 //   label: const Text(
        //                 //     "Input value to Convert",
        //                 //     textAlign: TextAlign.start,
        //                 //     style: TextStyle(color: Colors.grey),
        //                 //   ),
        //                 // ),
        //                 ),
        //             const SizedBox(
        //               height: 20.0,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 customDropDown(currencies, froom!, (val) {
        //                   setState(() {
        //                     froom = val;
        //                   });
        //                 }),
        //                 FloatingActionButton(
        //                   onPressed: () {
        //                     String? temb = froom;
        //                     setState(() {
        //                       froom = to;
        //                       to = temb;
        //                     });
        //                   },
        //                   elevation: 0.0,
        //                   backgroundColor: secondColor,
        //                   child: const Icon(Icons.swap_horiz),
        //                 )
        //                 // // DropdownMenuExample(),
        //                 // CustomDropdownButton(
        //                 //   item: currencies, value: from,
        //                 //   // onChange: (from) {}
        //                 // )
        //               ],
        //             ),
        //             const SizedBox(
        //               height: 50.0,
        //             ),
        //             Container(
        //               width: double.infinity,
        //               padding: const EdgeInsets.all(16.0),
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.circular(8.0)),
        //               child: Column(
        //                 children: [
        //                   const Text(
        //                     "Result",
        //                     style: TextStyle(
        //                         color: Colors.black,
        //                         fontSize: 24.0,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                   Text(
        //                     result,
        //                     style: TextStyle(
        //                         color: secondColor,
        //                         fontSize: 36.0,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       ))
        //     ],
        //   ),
        // )),
//         );
//   }
// //   Widget customDropDown(List<String> item, String value, void onChange(val)) {
//   return Container(
//     child: DropdownButton<String>(
//         items: item.map<DropdownMenuItem<String>>?( (String val){
//           return DropdownMenuItem(value: val,child: Text(val),);
//         });
//         value: value,
//         onChanged: (val) {
//           onChange(val);
//         }),
//   );
// }
// }

// class CustomDropdownButton extends StatefulWidget {
//   const CustomDropdownButton({
//     super.key,
//     required this.item,
//     required this.value,
//   });
//   final List<String> item;
//   final String value;

//   @override
//   State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
// }

// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
//       child: DropdownButton<String>(
//         value: dropdownValue,
//         icon: const Icon(Icons.arrow_downward),
//         elevation: 16,
//         style: const TextStyle(color: Colors.deepPurple),
//         underline: Container(
//           height: 2,
//           color: Colors.deepPurpleAccent,
//         ),
//         onChanged: (String? value) {
//           // This is called when the user selects an item.
//           setState(() {
//             dropdownValue = value!;
//           });
//           //   widget.onChange();
//         },
//         items: list.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class DropdownMenuExample extends StatefulWidget {
//   const DropdownMenuExample({super.key});

//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
// }

// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
//   final TextEditingController colorController = TextEditingController();
//   final TextEditingController iconController = TextEditingController();
//   ColorLabel? selectedColor;
//   IconLabel? selectedIcon;

//   @override
//   Widget build(BuildContext context) {
//     final List<DropdownMenuEntry<ColorLabel>> colorEntries =
//         <DropdownMenuEntry<ColorLabel>>[];
//     for (final ColorLabel color in ColorLabel.values) {
//       colorEntries.add(DropdownMenuEntry<ColorLabel>(
//           value: color, label: color.label, enabled: color.label != 'Grey'));
//     }

//     final List<DropdownMenuEntry<IconLabel>> iconEntries =
//         <DropdownMenuEntry<IconLabel>>[];
//     for (final IconLabel icon in IconLabel.values) {
//       iconEntries
//           .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
//     }

//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
//       home: Scaffold(
//         body: SafeArea(
//             child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   DropdownMenu<ColorLabel>(
//                     initialSelection: ColorLabel.green,
//                     controller: colorController,
//                     label: const Text('Color'),
//                     dropdownMenuEntries: colorEntries,
//                     onSelected: (ColorLabel? color) {
//                       setState(() {
//                         selectedColor = color;
//                       });
//                     },
//                   ),
//                   const SizedBox(width: 20),
//                   DropdownMenu<IconLabel>(
//                     controller: iconController,
//                     enableFilter: true,
//                     leadingIcon: const Icon(Icons.search),
//                     label: const Text('Icon'),
//                     dropdownMenuEntries: iconEntries,
//                     inputDecorationTheme:
//                         const InputDecorationTheme(filled: true),
//                     onSelected: (IconLabel? icon) {
//                       setState(() {
//                         selectedIcon = icon;
//                       });
//                     },
//                   )
//                 ],
//               ),
//             ),
//             if (selectedColor != null && selectedIcon != null)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                       'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
//                   Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5),
//                       child: Icon(
//                         selectedIcon?.icon,
//                         color: selectedColor?.color,
//                       ))
//                 ],
//               )
//             else
//               const Text('Please select a color and an icon.')
//           ],
//         )),
//       ),
//     );
//   }
// }

// enum ColorLabel {
//   blue('Blue', Colors.blue),
//   pink('Pink', Colors.pink),
//   green('Green', Colors.green),
//   yellow('Yellow', Colors.yellow),
//   grey('Grey', Colors.grey);

//   const ColorLabel(this.label, this.color);
//   final String label;
//   final Color color;
// }

// enum IconLabel {
//   smile('Smile', Icons.sentiment_satisfied_outlined),
//   cloud(
//     'Cloud',
//     Icons.cloud_outlined,
//   ),
//   brush('Brush', Icons.brush_outlined),
//   heart('Heart', Icons.favorite);

//   const IconLabel(this.label, this.icon);
//   final String label;
//   final IconData icon;
// }
