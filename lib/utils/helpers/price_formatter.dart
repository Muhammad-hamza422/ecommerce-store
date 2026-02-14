import 'package:intl/intl.dart';

class PriceFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  static String format(num value) {
    return _formatter.format(value);
  }
}


