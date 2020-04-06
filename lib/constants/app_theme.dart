import 'colors.dart';
import 'font_family.dart';
/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.productSans,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.orange[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.orange[500],
    accentColorBrightness: Brightness.light,
    iconTheme: IconThemeData(color:Colors.white54),
    accentIconTheme: IconThemeData(color:Colors.white70),
    backgroundColor: AppColors.orange[500],
    colorScheme: ColorScheme(
      primary: AppColors.orange[500], 
      primaryVariant: AppColors.orange[500], 
      secondary: AppColors.orange[500], 
      secondaryVariant: AppColors.orange[500], 
      surface: AppColors.orange[500], 
      background: AppColors.orange[500], 
      error: AppColors.orange[500], 
      onPrimary: Colors.white70, 
      onSecondary: AppColors.orange[500], 
      onSurface: AppColors.orange[500], 
      onBackground: AppColors.orange[500], 
      onError: AppColors.orange[500],
      brightness: Brightness.light
      ),
      primaryIconTheme: IconThemeData(
        color:Colors.white70
      )
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.orange[500],
  accentColorBrightness: Brightness.dark,
);