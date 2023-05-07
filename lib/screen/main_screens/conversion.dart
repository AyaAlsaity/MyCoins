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

import 'package:flutter/material.dart';
import 'package:mycoins/services/api.dart';

import '../../helpers/consts.dart';
import '../../widgets/static_widgets/appBar_widget.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  ApiClient client = ApiClient();

  // Future<List<String>> getcurrencyList() async {
  //   return await client.getcurrencies();
  // }

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await client.getcurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }

  Color mainColor = const Color(0xFF212936);

  Color mainColor2 = const Color(0xFFF5C249);
  Color secondColor = const Color(0xFF2849E5);

  List<String> currencies = [];
  String? froom;
  String? to;

  double rate = 0.0;
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBackroundScreenColor,
        appBar: AppBarWidget(context),
        drawer: const CustomDrawer(),
        body: const Center(
          child: Text(
            "ConversionScreen",
            style: TextStyle(color: Colors.white),
          ),
        )
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
        );
  }
//   Widget customDropDown(List<String> item, String value, void onChange(val)) {
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
}

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.item,
    required this.value,
  });
  final List<String> item;
  final String value;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          //   widget.onChange();
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(DropdownMenuEntry<ColorLabel>(
          value: color, label: color.label, enabled: color.label != 'Grey'));
    }

    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownMenu<ColorLabel>(
                    initialSelection: ColorLabel.green,
                    controller: colorController,
                    label: const Text('Color'),
                    dropdownMenuEntries: colorEntries,
                    onSelected: (ColorLabel? color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  DropdownMenu<IconLabel>(
                    controller: iconController,
                    enableFilter: true,
                    leadingIcon: const Icon(Icons.search),
                    label: const Text('Icon'),
                    dropdownMenuEntries: iconEntries,
                    inputDecorationTheme:
                        const InputDecorationTheme(filled: true),
                    onSelected: (IconLabel? icon) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    },
                  )
                ],
              ),
            ),
            if (selectedColor != null && selectedIcon != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        selectedIcon?.icon,
                        color: selectedColor?.color,
                      ))
                ],
              )
            else
              const Text('Please select a color and an icon.')
          ],
        )),
      ),
    );
  }
}

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
