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
  String result = "0";
  TextEditingController rateController = TextEditingController();

  conversionProcess(String rat, double from, double to) {
    String op = (double.parse(rat.toString().trim()) * from * to).toString();
    setState(() {
      result = op;
    });
  }

  @override
  void initState() {
    Provider.of<CoinsProvider>(context, listen: false).initConversion();
    super.initState();
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(AppLocalizations.of(context)!.conver1,
                      style: TextStyle(
                          color: themeListener.isDark
                              ? secondeyTextColor
                              : Colors.black87,
                          fontSize: 20,
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
                            return null;
                          },
                          hintText: AppLocalizations.of(context)!.conver2,
                          ispassword: false,
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
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
                                                          width: 20,
                                                          height: 20,
                                                          child: Image.network(e
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
                                            Provider.of<CoinsProvider>(context,
                                                    listen: false)
                                                .setSelectedCoinTwo(value);
                                          },
                                          value: coinsConsumer.selectedcurrenc2,
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
                                  child: Icon(
                                    Icons.currency_exchange,
                                    size: 30,
                                    color: mainColor,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: themeListener.isDark
                                        ? Colors.white30
                                        : lightBackroundScreenColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            Provider.of<CoinsProvider>(context,
                                                    listen: false)
                                                .setSelectedCurrencyOne(value);
                                          },
                                          value: coinsConsumer.selectedcurrenc1,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                          height: 80,
                          width: 400,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: themeListener.isDark
                                ? Colors.white30
                                : lightBackroundScreenColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.conver3} : ${result}",
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
          ));
    });
  }
}
