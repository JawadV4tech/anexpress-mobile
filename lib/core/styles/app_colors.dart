import 'package:flutter/material.dart';

class AppColors {
  static Color gray5001 = fromHex('#f7f8fa');

  static Color blueGray10001 = fromHex('#d9d9d9');

  static Color lightGreenA700 = fromHex('#2ce728');

  static Color gray7004c = fromHex('#4c5f5b5b');

  static Color indigoA200 = fromHex('#7479ff');

  static Color indigo20001 = fromHex('#9ca5e9');

  static Color gray80001 = fromHex('#494646');

  static Color deepPurple100 = fromHex('#dbd1fc');

  static Color black9003f = fromHex('#3f000000');

  static Color gray50 = fromHex('#f8f8f8');

  static Color black90001 = fromHex('#000001');

  static Color black900 = fromHex('#000000');

  static Color gray600 = fromHex('#737373');

  static Color gray700 = fromHex('#636363');

  static Color orange7006c = fromHex('#6cff7f00');

  static Color gray400 = fromHex('#c4c4c4');

  static Color gray60001 = fromHex('#7C7B7B');

  static Color blueGray100 = fromHex('#d3d3d3');

  static Color blue700 = fromHex('#1363df');

  static Color blueGray400 = fromHex('#888888');

  static Color gray800 = fromHex('#3a3a3a');

  static Color indigo50 = fromHex('#e6e7f4');

  static Color gray900 = fromHex('#1e1e1e');

  static Color gray90001 = fromHex('#191919');

  // static Color secondary = fromHex('#ff7f00');

  static Color secondary = fromHex('#D65A00');

  static Color gray200 = fromHex('#ececec');

  static Color indigo70087 = fromHex('#872c34a0');

  static Color orange7004c = fromHex('#4cff7f00');

  static Color indigo300 = fromHex('#737be4');

  static Color orange70063 = fromHex('#63ff7f00');

  static Color whiteA70063 = fromHex('#63ffffff');

  static Color indigo100 = fromHex('#d0d2f4');

  static Color indigo200 = fromHex('#9599cf');

  static Color gray40001 = fromHex('#c3c3c3');

  static Color gray40002 = fromHex('#c8c7c7');

  static Color gray40003 = fromHex('#bcbcbc');

  static Color primaryDark = fromHex('#1a1f75');

  static Color primary = fromHex('#2E308D');

  static Color black90014 = fromHex('#14000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
