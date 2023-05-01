import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/button.dart';


class InfoAppScreen extends StatelessWidget {
  const InfoAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(

      appBar:  AppBar(),
    
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
 
              children: [
              Text(
                                "تاريخ الاصدار :",
                               
                                style: TextStyle(
                              
                                  fontSize: 16,
                                  color: themeFunctions.isDark
                                      ? secondeyTextColor
                                      : Colors.black87,
                                ),),
                                 const SizedBox(
                                  width: 10,
                                ),
              Text(
                                "2023/5/14",
                                
                                style: TextStyle(
                                  
                                  fontSize: 16,
                                  color: themeFunctions.isDark
                                      ? secondeyTextColor.withOpacity(0.7)
                                      : Colors.black87.withOpacity(0.5),
                                ),),
             ],
            ),
            Row(
              
              children: [
               Text(
                                "الجهة :",
                               
                                style: TextStyle(
                                 
                                  fontSize: 16,
                                  color: themeFunctions.isDark
                                      ? secondeyTextColor
                                      : Colors.black87,
                                ),),
                                const SizedBox(
                                  width: 10,
                                ),
              Text(
                                "....",
                                
                                style: TextStyle(
                               
                                  fontSize: 16,
                                  color: themeFunctions.isDark
                                      ? secondeyTextColor.withOpacity(0.7)
                                      : Colors.black87.withOpacity(0.5),
                                ),),
             ],
            ),
           const SizedBox(
              height: 30,
            ),

            GestureDetector(
                              onTap: () {
                                 
                              },
                              child: ButtonScreen(
                                isbackround: true,
                                title: AppLocalizations.of(context)!.support,
                                widthh: double.infinity,
                                heightt: size.width / 7.3,
                                paddingg: 13,
                              ),
                            ),
          ],
        ),
      ),
    );
  }
}