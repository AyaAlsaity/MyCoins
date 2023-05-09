import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Api
import 'package:flutter/services.dart';
//font
import 'package:google_fonts/google_fonts.dart';
import 'package:mycoins/providers/coins_provider.dart';
import 'package:mycoins/providers/get_from_fire_storge_provider.dart';
import 'package:mycoins/screen/auth_screens/splah_screen.dart';
// provider
import 'package:provider/provider.dart';
//shared preferences
import 'package:shared_preferences/shared_preferences.dart';

// //lang
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//colors
import 'helpers/consts.dart';
//dark mode
import 'providers/dark_theme_provider.dart';
import 'screen/main_screens/TabsScreen.dart';
// firebase

Future<void> main() async {
  // await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getLocalLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localCode = prefs.getString('langCode');
    if (localCode == 'ar') {
      setState(() {
        _locale = const Locale('ar');
        setLocale(const Locale('ar'));
      });
    } else {
      setState(() {
        _locale = const Locale('en');
        setLocale(const Locale('en'));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocalLang();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinsProvider>(
          create: (BuildContext context) => CoinsProvider(),
        ),
        ChangeNotifierProvider<FireStorgeProvoder>(
          create: (BuildContext context) => FireStorgeProvoder(),
        ),
        ChangeNotifierProvider<DarkThemeProvider>(
          create: (_) {
            return DarkThemeProvider();
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeListener, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              'en',
            ),
            Locale(
              'ar',
            ),
          ],
          locale: _locale,
          theme: ThemeData(
            scaffoldBackgroundColor: themeListener.isDark
                ? darkBackroundScreenColor
                : secondeyTextColor,
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.tajawal(),
              elevation: 0.2,
              backgroundColor: themeListener.isDark
                  ? darkBackroundScreenColor
                  : secondeyTextColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: themeListener.isDark
                    ? darkBackroundScreenColor
                    : secondeyTextColor,
              ),
              iconTheme: const IconThemeData(color: mainColor),
            ),
            textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: themeListener.isDark
                  ? darkBackroundScreenColor
                  : secondeyTextColor,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            primaryColor: mainColor,
            scrollbarTheme: ScrollbarThemeData(
              thickness: MaterialStateProperty.all<double>(10),
              trackVisibility: MaterialStateProperty.all<bool>(true),
            ).copyWith(
              thumbColor: MaterialStateProperty.all(secondeyTextColor),
              trackColor:
                  MaterialStateProperty.all(secondeyTextColor.withOpacity(0.2)),
            ),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: mainColor,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: mainColor,
              unselectedItemColor: themeListener.isDark
                  ? secondeyTextColor
                  : darkBackroundScreenColor,
              backgroundColor: themeListener.isDark
                  ? darkBackroundScreenColor
                  : secondeyTextColor,
              selectedLabelStyle: const TextStyle(
                  color: mainColor, fontSize: 10, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
              showUnselectedLabels: true,
              elevation: 0,
            ),
          ),
          home: auth.currentUser != null
              ? const TabsScreen()
              : const SplashScreen(),
        );
      }),
    );
  }
}
