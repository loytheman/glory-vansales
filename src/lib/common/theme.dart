// ref:
// https://api.flutter.dev/flutter/material/TextTheme-class.html
// https://www.christianfindlay.com/blog/flutter-mastering-material-design3
// https://www.youtube.com/watch?v=Ct9CrMegezQ
// https://mobisoftinfotech.com/resources/blog/flutter-theme-management-custom-color-schemes
// https://api.flutter.dev/flutter/material/ButtonStyle-class.html

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const double rem = 14;

  static const myRed = Color(0xFFee1818);

  static final font01 = GoogleFonts.getFont('Roboto').fontFamily;
  //static final font02 = GoogleFonts.getFont('Lato').fontFamily;

  static ThemeData lt = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: font01,
    textTheme: lightTextTheme,
    primaryColor: myRed,
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    cardTheme: cardTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    filledButtonTheme: filledButtonTheme,
    textButtonTheme: lightTextButtonTheme,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[50]),
  );

  static final lightTheme = lt.copyWith(extensions: <ThemeExtension<dynamic>>[
    MyCustomStyle(
      linkColor: Colors.blue[800],
      logoutColor: myRed,
    )
  ]);

  static ThemeData dt = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: font01,
    textTheme: darkTextTheme,
    primaryColor: myRed,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850], iconTheme: IconThemeData(color: Colors.grey[50])),
    cardTheme: cardTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    filledButtonTheme: filledButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textButtonTheme: darkTextButtonTheme,
    iconTheme: IconThemeData(color: Colors.grey[50]),
    //drawerTheme: DrawerThemeData(backgroundColor: Colors.amber[200]),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[850]),
  );

  static final darkTheme = dt.copyWith(extensions: <ThemeExtension<dynamic>>[
    MyCustomStyle(
      linkColor: Colors.blue[600],
      logoutColor: myRed,
    )
  ]);

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.w900, color: Colors.grey[900], height: 1.1),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.grey[900], height: 1.1),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.grey[900], height: 1.1),
    headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: Colors.grey[900]),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: Colors.grey[900]),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.grey[900]),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[900]),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[900]),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[900]),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey[900]),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[900]),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.w900, color: Colors.grey[50], height: 1.1),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.grey[50], height: 1.1),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.grey[50], height: 1.1),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: Colors.grey[50]),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.grey[50]),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[50]),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[50]),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[50]),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey[50]),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[50]),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: myRed,
    disabledBackgroundColor: myRed.withAlpha(150),
    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    padding: const EdgeInsets.symmetric(vertical: 8),
  ));

  static FilledButtonThemeData filledButtonTheme = FilledButtonThemeData(
      style: FilledButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: myRed,
    disabledBackgroundColor: myRed.withAlpha(150),
    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: myRed,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    padding: const EdgeInsets.symmetric(vertical: 16),
    side: const BorderSide(color: myRed, width: 1.6),
  ));

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: Colors.black87,
    textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    iconColor: Colors.black87,
  ));

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    iconColor: Colors.white,
  ));

  static CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  );

  //###### merge style stuff ########
  /*
  //MyTheme.mergeStyle(context.bodyMedium, MyTheme.linkStyle)
  static dynamic mergeStyle(dynamic s1, Map<Symbol, dynamic> s2) {
    assert(s1 is TextStyle || s1 is ButtonStyle);
    Function f = s1.copyWith;
    f = s1.copyWith;
    final r = Function.apply(f, [], s2);
    return r;
  }

  static Map<Symbol, dynamic> linkStyle = {
    #color: Colors.blue[600],
  };
  */
}

class MyCustomStyle extends ThemeExtension<MyCustomStyle> {
  final Color? linkColor;
  final Color? logoutColor;
  const MyCustomStyle({this.linkColor, this.logoutColor});

  @override
  ThemeExtension<MyCustomStyle> lerp(ThemeExtension<MyCustomStyle>? other, double t) {
    if (other is! MyCustomStyle) {
      return this;
    }

    final defaultLinkColor = linkColor ?? Colors.blue[800];

    return MyCustomStyle(linkColor: Color.lerp(defaultLinkColor, other.linkColor, t));
  }

  @override
  MyCustomStyle copyWith({Color? linkColor}) => MyCustomStyle(
        linkColor: linkColor ?? this.linkColor,
      );

  @override
  String toString() => 'MyCustomStyle(linkColor: $linkColor)';
}

// Color? get linkColor {
//   Color? c = Colors.blue[800];
//   if(brightness == Brightness.dark){
//     c = Colors.blue[600];
//   }
//   Utils.log("brightness: $brightness");
//   return c;
// }
