import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quicky_customer/pages/localization/app_localizations.dart';
import 'package:quicky_customer/pages/localization/language_constants.dart';
import 'package:quicky_customer/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_screen/splash_screen.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPrefs.shared = await SharedPreferences.getInstance();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   const MyApp({Key key}) : super(key: key);

//   static void setLocale(BuildContext context, Locale newLocale) {
//     _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
//     state.setLocale(newLocale);
//   }

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Locale _locale;

//   setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     getLocale().then((locale) {
//       setState(() {
//         this._locale = locale;
//       });
//     });
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       locale: _locale,
//       supportedLocales: [Locale("en", "US"), Locale("ml", "IN")],
//       localizationsDelegates: [
//         DemoLocalization.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       localeResolutionCallback: (locale, supportedLocales) {
//         for (var supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale.languageCode &&
//               supportedLocale.countryCode == locale.countryCode) {
//             return supportedLocale;
//           }
//         }
//         return supportedLocales.first;
//       },
//       home: SpalshScreen(),
//       theme: ThemeData(
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           appBarTheme: AppBarTheme(
//               color: Colors.white,
//               iconTheme: IconThemeData(color: Colors.black)),
//           scaffoldBackgroundColor: Colors.white,
//           primarySwatch: Colors.red,
//           // primaryColor: Color.fromRGBO(255, 186, 0, 1),
//           // primaryColorDark: Color.fromRGBO(255, 186, 0, 1),
//           // primaryColorLight: Color.fromRGBO(255, 186, 0, 1),
//           cardColor: Color.fromRGBO(241, 241, 247, 1)),
//       debugShowCheckedModeBanner: false,
//       routes: {
//         //LoginPage.routeName: (_) => LoginPage(),
//       },
//     );
//   }
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.shared = await SharedPreferences.getInstance();
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyHomePageState state =
        context.findAncestorStateOfType<_MyHomePageState>();
    state.setLocale(newLocale);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    this._fetchLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Localization',
      theme: ThemeData(primaryColor: Colors.blue[800]),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ml', 'IN'),
      ],
      locale: _locale,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: SpalshScreen(),
      routes: {
        // LoginPage.routeName: (context) => LoginPage(),
        // mainHomePage.routeName: (context) => mainHomePage()
      },
    );
  }

  _fetchLocale() async {
    Locale tempLocale;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = (prefs.getString(LAGUAGE_CODE) ?? 'en');
    print(languageCode);

    switch (languageCode) {
      case ENGLISH:
        tempLocale = Locale(ENGLISH, 'US');
        break;
      case MALAYALAM:
        tempLocale = Locale(MALAYALAM, 'IN');
        break;
      default:
        tempLocale = Locale(ENGLISH, 'US');
    }
    return tempLocale;
  }
}
