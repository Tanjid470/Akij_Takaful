import 'package:akij_login_app/constants/app_asset.dart';
import 'package:intl/intl.dart';

NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

class StringCurrencyFormatter {
  format(String s) {
    var formatter = NumberFormat('#,##,###');

    return formatter.format(int.parse(s)).toString();
  }

  formatTaka(String s) {
    NumberFormat formatter = NumberFormat('#,##,##,###');
    String formattedValue = formatter.format(int.parse(s)).toString();
    String takaValue = '${AppAsset.taka} $formattedValue';

    return takaValue;
  }

  formatCurr(String s) {
    final formatCurrency =
        NumberFormat.currency(locale: 'en_IN', symbol: AppAsset.taka);
    String formattedAmount = formatCurrency.format(double.parse(s));

    return formattedAmount;
  }

  formatDouble(double d) {
    var formatter = NumberFormat('#,##,###');

    return formatter.format(d);
  }
}
