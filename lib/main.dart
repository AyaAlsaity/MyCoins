import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Api
import 'package:flutter/services.dart';
//font
import 'package:google_fonts/google_fonts.dart';
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
import 'screen/main_screens/home.dart';
import 'screen/sub_screens/sign_in_screen.dart';
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
  Locale _locale = const Locale('ar');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getLocalLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localCode = prefs.getString('langCode');
    if (localCode == 'en') {
      setState(() {
        _locale = const Locale('en');
        setLocale(const Locale('en'));
      });
    } else {
      setState(() {
        _locale = const Locale('ar');
        setLocale(const Locale('ar'));
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
        // ChangeNotifierProvider<AuthProvider>(
        //     create: (BuildContext context) => AuthProvider()),
        ChangeNotifierProvider<DarkThemeProvider>(
          create: (_) {
            return DarkThemeProvider();
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeListener, _) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor:
              themeListener.isDark ? darkBackroundScreenColor : lightBackroundScreenColor,
        ));
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
        textTheme:
                GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),

        primarySwatch: Colors.blue,
        ),
      
      home:auth.currentUser != null
              ? const HomeScreen()
              : const LoginScreen(),
    );
      }
      ),
    );
  }
}
